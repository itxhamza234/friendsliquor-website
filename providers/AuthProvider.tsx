'use client'

import { createContext, useContext, useEffect, useState, useCallback } from 'react'
import { createClient } from '@/lib/supabase/client'
import { User, Session } from '@supabase/supabase-js'
import { ensureUserProfile } from '@/lib/auth/ensureUserProfile'

type AuthContextType = {
  user: User | null
  session: Session | null
  displayName: string | null
  loading: boolean
  refreshProfile: () => Promise<void>
}

const AuthContext = createContext<AuthContextType>({
  user: null,
  session: null,
  displayName: null,
  loading: true,
  refreshProfile: async () => {},
})

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null)
  const [session, setSession] = useState<Session | null>(null)
  const [displayName, setDisplayName] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  const loadDisplayName = useCallback(
    async (currentUser: User | null) => {
      if (!currentUser) {
        setDisplayName(null)
        return
      }

      const metaName = currentUser.user_metadata?.full_name as string | undefined
      const { data: profile } = await supabase
        .from('users')
        .select('full_name')
        .eq('id', currentUser.id)
        .maybeSingle()

      const name =
        profile?.full_name?.trim() ||
        metaName?.trim() ||
        currentUser.email?.split('@')[0] ||
        'User'

      setDisplayName(name)

      if (!profile?.full_name && metaName) {
        await ensureUserProfile(supabase, currentUser, metaName)
      }
    },
    [supabase]
  )

  const refreshProfile = useCallback(async () => {
    const {
      data: { user: currentUser },
    } = await supabase.auth.getUser()
    await loadDisplayName(currentUser)
  }, [supabase, loadDisplayName])

  useEffect(() => {
    const init = async () => {
      const {
        data: { session: currentSession },
      } = await supabase.auth.getSession()
      setSession(currentSession)
      setUser(currentSession?.user ?? null)
      await loadDisplayName(currentSession?.user ?? null)
      setLoading(false)
    }

    init()

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (_event, newSession) => {
      setSession(newSession)
      setUser(newSession?.user ?? null)
      await loadDisplayName(newSession?.user ?? null)
      setLoading(false)

      // Clear cart when user signs out
      if (_event === 'SIGNED_OUT') {
        localStorage.removeItem('friends-liquor-cart')
        window.dispatchEvent(new Event('friends-cart-updated'))
      }
    })

    return () => subscription.unsubscribe()
  }, [supabase, loadDisplayName])

  return (
    <AuthContext.Provider
      value={{ user, session, displayName, loading, refreshProfile }}
    >
      {children}
    </AuthContext.Provider>
  )
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
