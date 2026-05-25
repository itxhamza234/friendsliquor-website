import { SupabaseClient } from '@supabase/supabase-js'
import { CartLineItem } from '@/types/cart'

type CartRow = {
  id: string
  product_variant_id: string
  quantity: number
}

type VariantRow = {
  id: string
  product_id: string
  size: string | null
  size_ml?: number | null
  price: number | null
  price_euro?: number | null
}

type ProductRow = {
  id: string
  name: string | null
  product_name: string | null
  slug: string
  brand: string | null
  image_url: string | null
  image: string | null
  category_id: string | null
}

function formatSize(variant: VariantRow): string {
  if (variant.size && variant.size.trim()) return variant.size
  if (variant.size_ml) return `${variant.size_ml}ml`
  return 'Standard'
}

export async function enrichCartItems(
  supabase: SupabaseClient,
  cartRows: CartRow[]
): Promise<CartLineItem[]> {
  if (cartRows.length === 0) return []

  const variantIds = cartRows.map((row) => row.product_variant_id)

  // Standard product_variants has: size, size_ml, price, price_euro
  const { data: standardVariants } = await supabase
    .from('product_variants')
    .select('id, product_id, size, size_ml, price, price_euro')
    .in('id', variantIds)

  // Premium product_variants has: size, price (no size_ml, no price_euro)
  let premiumVariants = null
  try {
    const result = await supabase
      .from('premium_product_variants')
      .select('id, product_id, size, price')
      .in('id', variantIds)
    premiumVariants = result.data
  } catch (e) {
    console.error('Error fetching premium variants:', e)
  }

  const allVariants = [
    ...(standardVariants || []).map((v) => ({ ...v, isPremium: false })),
    ...(premiumVariants || []).map((v) => ({
      ...v,
      size_ml: null,
      price_euro: null,
      isPremium: true,
    })),
  ]

  if (allVariants.length === 0) return []

  const standardProductIds = [
    ...new Set(
      allVariants.filter((v) => !v.isPremium).map((v) => v.product_id)
    ),
  ]
  const premiumProductIds = [
    ...new Set(
      allVariants.filter((v) => v.isPremium).map((v) => v.product_id)
    ),
  ]

  const { data: standardProducts } = await supabase
    .from('products')
    .select('id, name, product_name, slug, brand, image_url, image, category_id')
    .in('id', standardProductIds)

  let premiumProducts = null
  try {
    const result = await supabase
      .from('premium_products')
      .select('id, name, product_name, slug, brand, image_url, image, category_id')
      .in('id', premiumProductIds)
    premiumProducts = result.data
  } catch (e) {
    console.error('Error fetching premium products:', e)
  }

  const allProducts = [
    ...(standardProducts || []).map((p) => ({ ...p, isPremium: false })),
    ...(premiumProducts || []).map((p) => ({ ...p, isPremium: true })),
  ]

  if (allProducts.length === 0) return []

  const categoryIds = [
    ...new Set(
      (allProducts as (ProductRow & { isPremium: boolean })[])
        .map((p) => p.category_id)
        .filter((id): id is string => Boolean(id))
    ),
  ]

  const categoryMap = new Map<string, string>()
  if (categoryIds.length > 0) {
    const { data: categories } = await supabase
      .from('categories')
      .select('id, name')
      .in('id', categoryIds)

    for (const cat of categories ?? []) {
      categoryMap.set(cat.id, cat.name)
    }
  }

  const variantMap = new Map(
    allVariants.map((v) => [v.id, v] as [string, VariantRow & { isPremium: boolean }])
  )
  const productMap = new Map(
    allProducts.map((p) => [p.id, p] as [string, ProductRow & { isPremium: boolean }])
  )

  return cartRows
    .map((row) => {
      const variant = variantMap.get(row.product_variant_id)
      if (!variant) return null

      const product = productMap.get(variant.product_id)
      if (!product) return null

      // Use price_euro if available (standard variants), otherwise fallback to price
      const price = Number(variant.price_euro ?? variant.price ?? 0)
      const categoryName = product.category_id
        ? categoryMap.get(product.category_id) ?? null
        : null

      return {
        id: row.id,
        product_variant_id: row.product_variant_id,
        quantity: row.quantity,
        product_id: product.id,
        product_name: product.product_name || product.name || 'Product',
        product_slug: product.slug,
        brand: product.brand,
        category_name: categoryName,
        image_url: product.image_url || product.image,
        size: formatSize(variant),
        price,
        lineTotal: price * row.quantity,
      }
    })
    .filter((item): item is CartLineItem => item !== null)
}