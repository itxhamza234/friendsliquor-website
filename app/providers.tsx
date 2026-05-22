'use client'

import { useEffect } from 'react'
import { AuthProvider } from '@/providers/AuthProvider'
import { CartProvider } from '@/providers/CartProvider'
import { WishlistProvider } from '@/providers/WishlistProvider'

/** In dev, recover once when Turbopack serves a stale JS chunk after hot reload */
function DevChunkRecovery() {
  useEffect(() => {
    if (process.env.NODE_ENV !== 'development') return

    const key = 'chunk_reload_once'
    const handler = (event: PromiseRejectionEvent) => {
      const reason = event.reason
      const message =
        reason instanceof Error
          ? reason.message
          : typeof reason === 'object' && reason && 'message' in reason
            ? String((reason as { message: unknown }).message)
            : String(reason ?? '')

      if (
        !message.includes('ChunkLoadError') &&
        !message.includes('Failed to load chunk')
      ) {
        return
      }

      if (sessionStorage.getItem(key)) return
      sessionStorage.setItem(key, '1')
      window.location.reload()
    }

    window.addEventListener('unhandledrejection', handler)
    return () => window.removeEventListener('unhandledrejection', handler)
  }, [])

  return null
}

export function Providers({ children }: { children: React.ReactNode }) {
  // Check for clear-cart cookie on mount and clear localStorage
  useEffect(() => {
    const clearCartCookie = document.cookie
      .split('; ')
      .find(row => row.startsWith('clear-cart='))

    if (clearCartCookie) {
      // Clear localStorage cart with the correct key
      localStorage.removeItem('friends-liquor-cart')
      // Remove the cookie
      document.cookie = 'clear-cart=; path=/; max-age=0'
    }
  }, [])

  return (
    <AuthProvider>
      <CartProvider>
        <WishlistProvider>
          <DevChunkRecovery />
          {children}
        </WishlistProvider>
      </CartProvider>
    </AuthProvider>
  )
}
