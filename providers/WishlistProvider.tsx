'use client'

import { createContext, useContext, useEffect, useState } from 'react'
import { useAuth } from './AuthProvider'
import { createClient } from '@/lib/supabase/client'

type WishlistItem = {
  id: string
  product_id: string
}

type WishlistContextType = {
  wishlist: WishlistItem[]
  loading: boolean
  addToWishlist: (productId: string) => Promise<void>
  removeFromWishlist: (productId: string) => Promise<void>
}

const WishlistContext = createContext<WishlistContextType>({
  wishlist: [],
  loading: true,
  addToWishlist: async () => {},
  removeFromWishlist: async () => {},
})

export function WishlistProvider({ children }: { children: React.ReactNode }) {
  const [wishlist, setWishlist] = useState<WishlistItem[]>([])
  const [loading, setLoading] = useState(true)
  const { user } = useAuth()
  const supabase = createClient()

  useEffect(() => {
    if (!user) {
      setWishlist([])
      setLoading(false)
      return
    }

    const fetchWishlist = async () => {
      setLoading(true)
      const { data, error } = await supabase
        .from('wishlist')
        .select('*')
        .eq('user_id', user.id)
      
      if (!error && data) {
        setWishlist(data)
      }
      setLoading(false)
    }

    fetchWishlist()
  }, [user, supabase])

  const addToWishlist = async (productId: string) => {
    if (!user) return

    const { data, error } = await (supabase as any)
      .from('wishlist')
      .insert({ user_id: user.id, product_id: productId })
      .select()
      .single()

    if (!error && data) {
      setWishlist(prev => [...prev, data])
    }
  }

  const removeFromWishlist = async (productId: string) => {
    if (!user) return

    const { error } = await supabase
      .from('wishlist')
      .delete()
      .eq('user_id', user.id)
      .eq('product_id', productId)

    if (!error) {
      setWishlist(prev => prev.filter(item => item.product_id !== productId))
    }
  }

  return (
    <WishlistContext.Provider value={{ wishlist, loading, addToWishlist, removeFromWishlist }}>
      {children}
    </WishlistContext.Provider>
  )
}

export const useWishlist = () => useContext(WishlistContext)
