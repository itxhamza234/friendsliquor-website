import { createClient } from '@/lib/supabase/server'
import { Product } from '@/types/product'

export function isProductPremium(product: Product): boolean {
  // Since premium products are now in a separate table, check the premium flag
  // This is a fallback check for products that might still have the flag set
  return Boolean(
    product.premium === true ||
      product.is_premium === true ||
      (product as { is_premium?: boolean }).is_premium === true
  )
}

/** Exclude products that exist in premium_products table */
export async function filterOutPremiumProducts(
  products: Product[]
): Promise<Product[]> {
  const supabase = await createClient()

  // Get all premium product IDs from the premium_products table
  const { data } = await (supabase
    .from('premium_products') as any)
    .select('id')

  const premiumIds = new Set((data ?? []).map((row: any) => row.id))

  return products.filter(
    (p) => !premiumIds.has(p.product_id) && !isProductPremium(p)
  )
}
