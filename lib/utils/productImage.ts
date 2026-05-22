import { Product } from '@/types/product'

/** Resolve product image from view row or products-table fields. */
export function getProductImageUrl(
  product: Pick<Product, 'image_url' | 'image'> & { image?: string | null }
): string | null {
  const url = product.image_url || product.image
  if (!url || typeof url !== 'string') return null
  const trimmed = url.trim()
  return trimmed.length > 0 ? trimmed : null
}

export function withResolvedProductImage<T extends Product>(
  product: T,
  fallbackUrl?: string | null
): T {
  const imageUrl = getProductImageUrl(product) || fallbackUrl || null
  if (!imageUrl) return product
  return { ...product, image_url: imageUrl, image: imageUrl }
}
