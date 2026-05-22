'use client'

import { createContext, useCallback, useContext, useEffect, useState } from 'react'
import { useAuth } from './AuthProvider'
import { createClient } from '@/lib/supabase/client'
import { enrichCartItems } from '@/lib/cart/enrichCartItems'
import { ensureUserProfile } from '@/lib/auth/ensureUserProfile'
import {
  getStoredCart,
  setStoredCart,
  clearStoredCart,
  StoredCartItem,
} from '@/lib/cart/localStorageCart'
import { CartLineItem } from '@/types/cart'

type CartRow = {
  id: string
  product_variant_id: string
  quantity: number
}

type CartContextType = {
  cartItems: CartLineItem[]
  loading: boolean
  addToCart: (variantId: string, quantity?: number) => Promise<boolean>
  removeFromCart: (variantId: string) => Promise<void>
  updateQuantity: (variantId: string, quantity: number) => Promise<void>
  refreshCart: () => Promise<void>
  clearCart: () => void
  cartTotal: number
  cartCount: number
}

const CartContext = createContext<CartContextType>({
  cartItems: [],
  loading: true,
  addToCart: async () => false,
  removeFromCart: async () => {},
  updateQuantity: async () => {},
  refreshCart: async () => {},
  clearCart: () => {},
  cartTotal: 0,
  cartCount: 0,
})

function storedToRows(items: StoredCartItem[]): CartRow[] {
  return items.map((item) => ({
    id: `local-${item.product_variant_id}`,
    product_variant_id: item.product_variant_id,
    quantity: item.quantity,
  }))
}

export function CartProvider({ children }: { children: React.ReactNode }) {
  const [cartItems, setCartItems] = useState<CartLineItem[]>([])
  const [cartCount, setCartCount] = useState(0)
  const [loading, setLoading] = useState(true)
  const { user } = useAuth()
  const supabase = createClient()

  const applyCart = useCallback(
    async (stored: StoredCartItem[]) => {
      setStoredCart(stored)
      setCartCount(stored.reduce((sum, i) => sum + i.quantity, 0))

      if (stored.length === 0) {
        setCartItems([])
        return
      }

      const rows = storedToRows(stored)
      const enriched = await enrichCartItems(supabase, rows)
      setCartItems(enriched)
    },
    [supabase]
  )

  const refreshCart = useCallback(async () => {
    setLoading(true)
    const stored = getStoredCart()
    await applyCart(stored)
    setLoading(false)
  }, [applyCart])

  useEffect(() => {
    refreshCart()
  }, [refreshCart])

  useEffect(() => {
    const onCartUpdate = () => refreshCart()
    window.addEventListener('friends-cart-updated', onCartUpdate)
    window.addEventListener('storage', (e) => {
      if (e.key === 'friends-liquor-cart') onCartUpdate()
    })
    return () => {
      window.removeEventListener('friends-cart-updated', onCartUpdate)
    }
  }, [refreshCart])

  /** Sync local cart to Supabase when logged in (best effort) */
  const syncToDatabase = useCallback(
    async (stored: StoredCartItem[]) => {
      if (!user) return

      await ensureUserProfile(supabase, user)

      for (const item of stored) {
        await supabase.from('cart').upsert(
          {
            user_id: user.id,
            product_variant_id: item.product_variant_id,
            quantity: item.quantity,
          },
          { onConflict: 'user_id,product_variant_id' }
        )
      }
    },
    [user, supabase]
  )

  const addToCart = async (variantId: string, quantity: number = 1) => {
    if (!variantId) return false

    const stored = getStoredCart()
    const existing = stored.find((i) => i.product_variant_id === variantId)
    const newQty = existing ? existing.quantity + quantity : quantity

    const updated: StoredCartItem[] = existing
      ? stored.map((i) =>
          i.product_variant_id === variantId ? { ...i, quantity: newQty } : i
        )
      : [...stored, { product_variant_id: variantId, quantity: newQty }]

    await applyCart(updated)
    window.dispatchEvent(new Event('friends-cart-updated'))

    if (user) {
      await syncToDatabase(updated)
    }

    return updated.length > 0
  }

  const removeFromCart = async (variantId: string) => {
    const updated = getStoredCart().filter(
      (i) => i.product_variant_id !== variantId
    )
    await applyCart(updated)
    window.dispatchEvent(new Event('friends-cart-updated'))

    if (user) {
      await supabase
        .from('cart')
        .delete()
        .eq('user_id', user.id)
        .eq('product_variant_id', variantId)
    }
  }

  const updateQuantity = async (variantId: string, quantity: number) => {
    if (quantity <= 0) {
      await removeFromCart(variantId)
      return
    }

    const updated = getStoredCart().map((i) =>
      i.product_variant_id === variantId ? { ...i, quantity } : i
    )
    await applyCart(updated)
    window.dispatchEvent(new Event('friends-cart-updated'))

    if (user) {
      await supabase
        .from('cart')
        .update({ quantity })
        .eq('user_id', user.id)
        .eq('product_variant_id', variantId)
    }
  }

  const clearCart = () => {
    clearStoredCart()
    setCartItems([])
    setCartCount(0)
    window.dispatchEvent(new Event('friends-cart-updated'))
  }

  const cartTotal = cartItems.reduce((sum, item) => sum + item.lineTotal, 0)

  return (
    <CartContext.Provider
      value={{
        cartItems,
        loading,
        addToCart,
        removeFromCart,
        updateQuantity,
        refreshCart,
        clearCart,
        cartTotal,
        cartCount,
      }}
    >
      {children}
    </CartContext.Provider>
  )
}

export const useCart = () => useContext(CartContext)
