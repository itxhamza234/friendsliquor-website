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

const FREE_ITEM_THRESHOLD = 100
const FREE_ITEM_VARIANT_ID = '2910d511-cb8a-436d-8028-8cc1b9ce89d2'
const FREE_ITEM_QUANTITY = 2

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
  hasFreeItem: boolean
  amountUntilFreeItem: number
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
  hasFreeItem: false,
  amountUntilFreeItem: FREE_ITEM_THRESHOLD,
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

      // Real total calculate karo (free item exclude)
      const realTotal = enriched.reduce((sum, item) => sum + item.lineTotal, 0)

      if (realTotal >= FREE_ITEM_THRESHOLD) {
        // Check karo user ne khud Heineken 250ml add ki hai ya nahi
        const userAddedHeineken = enriched.find(
          (i) => i.product_variant_id === FREE_ITEM_VARIANT_ID
        )

        if (userAddedHeineken) {
          // User ki apni Heineken hai — uske upar FREE_ITEM_QUANTITY aur add karo
          const updatedItems = enriched.map((item) => {
            if (item.product_variant_id === FREE_ITEM_VARIANT_ID) {
              return {
                ...item,
                quantity: item.quantity + FREE_ITEM_QUANTITY,
                // Extra free quantity track karo
                freeQuantity: FREE_ITEM_QUANTITY,
              }
            }
            return item
          })
          setCartItems(updatedItems)
        } else {
          // User ne khud nahi add ki — free item alag se dikhao
          const freeItem: CartLineItem = {
            id: 'free-heineken-250ml',
            product_variant_id: FREE_ITEM_VARIANT_ID,
            product_id: 'free-heineken-250ml',
            product_name: 'Can/Bottle',
            brand: 'Heineken',
            category_name: 'Beer',
            price: 0,
            quantity: FREE_ITEM_QUANTITY,
            lineTotal: 0,
            size: '250ml',
            image_url: null,
            product_slug: 'heineken',
            isFreeItem: true,
          }
          setCartItems([...enriched, freeItem])
        }
      } else {
        setCartItems(enriched)
      }
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

  const syncToDatabase = useCallback(
    async (stored: StoredCartItem[]) => {
      if (!user) return
      await ensureUserProfile(supabase, user)
      for (const item of stored) {
        await (supabase.from('cart') as any).upsert(
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
    // Pure free item (jab user ne khud nahi add ki) remove nahi hogi
    const item = cartItems.find((i) => i.product_variant_id === variantId)
    if (item?.isFreeItem) return

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
    // Pure free item ki quantity change nahi hogi
    const item = cartItems.find((i) => i.product_variant_id === variantId)
    if (item?.isFreeItem) return

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
      await (supabase.from('cart') as any)
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

  // Real total = free items exclude karke
  const realCartItems = cartItems.filter((i) => !i.isFreeItem)
  const cartTotal = realCartItems.reduce((sum, item) => sum + item.lineTotal, 0)
  const hasFreeItem = cartTotal >= FREE_ITEM_THRESHOLD
  const amountUntilFreeItem = Math.max(0, FREE_ITEM_THRESHOLD - cartTotal)

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
        hasFreeItem,
        amountUntilFreeItem,
      }}
    >
      {children}
    </CartContext.Provider>
  )
}

export const useCart = () => useContext(CartContext)