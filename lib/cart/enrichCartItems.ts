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
  size_ml: number | null
  price: number | null
  price_euro: number | null
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
  const { data: variants, error: variantError } = await supabase
    .from('product_variants')
    .select('id, product_id, size, size_ml, price, price_euro')
    .in('id', variantIds)

  if (variantError || !variants?.length) return []

  const productIds = [...new Set(variants.map((v) => v.product_id))]
  const { data: products, error: productError } = await supabase
    .from('products')
    .select('id, name, product_name, slug, brand, image_url, image, category_id')
    .in('id', productIds)

  if (productError || !products?.length) return []

  const categoryIds = [
    ...new Set(
      (products as ProductRow[])
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

  const variantMap = new Map((variants as VariantRow[]).map((v) => [v.id, v]))
  const productMap = new Map((products as ProductRow[]).map((p) => [p.id, p]))

  return cartRows
    .map((row) => {
      const variant = variantMap.get(row.product_variant_id)
      if (!variant) return null

      const product = productMap.get(variant.product_id)
      if (!product) return null

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
