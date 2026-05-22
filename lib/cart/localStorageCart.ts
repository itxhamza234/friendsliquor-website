export type StoredCartItem = {
  product_variant_id: string
  quantity: number
}

const CART_STORAGE_KEY = 'friends-liquor-cart'

export function getStoredCart(): StoredCartItem[] {
  if (typeof window === 'undefined') return []
  try {
    const raw = localStorage.getItem(CART_STORAGE_KEY)
    if (!raw) return []
    const parsed = JSON.parse(raw) as StoredCartItem[]
    return Array.isArray(parsed) ? parsed.filter((i) => i.product_variant_id && i.quantity > 0) : []
  } catch {
    return []
  }
}

export function setStoredCart(items: StoredCartItem[]): void {
  if (typeof window === 'undefined') return
  localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(items))
}

export function clearStoredCart(): void {
  if (typeof window === 'undefined') return
  localStorage.removeItem(CART_STORAGE_KEY)
}
