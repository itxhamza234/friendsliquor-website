import { createClient } from '@/lib/supabase/server'
import { Product } from '@/types/product'

export function isProductPremium(product: Product): boolean {
  return Boolean(
    product.premium === true ||
      product.is_premium === true ||
      (product as { is_premium?: boolean }).is_premium === true
  )
}

/** Exclude products marked is_premium in database (e.g. Royal Salute, Glenfiddich 18) */
export async function filterOutPremiumProducts(
  products: Product[]
): Promise<Product[]> {
  const supabase = await createClient()
  const { data } = await supabase.from('products').select('id').eq('is_premium', true) as { data: { id: string }[] | null }

  const premiumIds = new Set((data ?? []).map((row) => row.id))

  return products.filter(
    (p) => !premiumIds.has(p.product_id) && !isProductPremium(p)
  )
}
