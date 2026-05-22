import { createClient } from '@/lib/supabase/server'
import { Database } from '@/types/database.types'
import { Product } from '@/types/product'
import { withResolvedProductImage } from '@/lib/utils/productImage'
import {
  normalizeProductVariants,
  normalizeVariantFromRow,
} from '@/lib/utils/productVariants'
import { filterOutPremiumProducts } from '@/lib/utils/premiumProduct'

type Category = Database['public']['Tables']['categories']['Row']

type ProductImageRow = {
  id: string
  image_url: string | null
  image: string | null
}

/** View reads variant images; admin saves on products — fill gaps from products table. */
async function enrichProductImages(products: Product[]): Promise<Product[]> {
  const needsLookup = products.filter((p) => !p.image_url && !p.image)
  if (needsLookup.length === 0) {
    return products.map((p) =>
      normalizeProductVariants(withResolvedProductImage(p))
    )
  }

  const supabase = await createClient()
  const ids = needsLookup.map((p) => p.product_id)
  const { data, error } = await supabase
    .from('products')
    .select('id, image_url, image')
    .in('id', ids)

  if (error) {
    console.error('Error fetching product images:', error.message)
    return products.map((p) =>
      normalizeProductVariants(withResolvedProductImage(p))
    )
  }

  const imageById = new Map(
    ((data ?? []) as ProductImageRow[]).map((row) => [
      row.id,
      row.image_url || row.image || null,
    ])
  )

  return products.map((p) =>
    normalizeProductVariants(
      withResolvedProductImage(p, imageById.get(p.product_id))
    )
  )
}

async function attachVariantsFromTable(
  product: Product
): Promise<Product> {
  if (product.variants && product.variants.length > 0) {
    return product
  }

  const supabase = await createClient()
  const { data, error } = await supabase
    .from('product_variants')
    .select('*')
    .eq('product_id', product.product_id)

  if (error || !data?.length) return product

  return normalizeProductVariants({
  ...product,
  variants: data.map((row) =>
    normalizeVariantFromRow(row as Record<string, unknown>)
  ),
})
}

export async function getCategories(): Promise<Category[]> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('categories')
    .select('*')
    .order('name')

  if (error) {
    console.error('Error fetching categories:', error.message, error.details, error.hint, error.code)
    return []
  }
  return data as Category[]
}

function isWineCategory(cat: Category): boolean {
  const slug = (cat.slug || '').toLowerCase()
  const name = (cat.name || '').toLowerCase()
  return slug === 'wines' || slug === 'wine' || name === 'wines' || name === 'wine'
}

function isWhiskyCategory(cat: Category): boolean {
  const slug = (cat.slug || '').toLowerCase()
  const name = (cat.name || '').toLowerCase()
  return slug === 'whisky' || slug === 'whiskey' || name === 'whisky' || name === 'whiskey'
}

function isVodkaCategory(cat: Category): boolean {
  const slug = (cat.slug || '').toLowerCase()
  const name = (cat.name || '').toLowerCase()
  return slug === 'vodka' || name === 'vodka'
}

/** Our Collection sidebar: show WHISKY & VODKA, hide Wine and Gin */
export async function getShopCategories(): Promise<Category[]> {
  const categories = await getCategories()

  let visible = categories.filter((cat) => !isWineCategory(cat))

  

  if (!visible.some(isWhiskyCategory)) {
    visible.push({
      id: 'whisky',
      name: 'WHISKY',
      slug: 'whisky',
      image: null,
      description: null,
      created_at: '',
      updated_at: '',
    })
  }

  if (!visible.some(isVodkaCategory)) {
    visible.push({
      id: 'vodka',
      name: 'VODKA',
      slug: 'vodka',
      image: null,
      description: null,
      created_at: '',
      updated_at: '',
    })
  }

  return visible.sort((a, b) => a.name.localeCompare(b.name))
}

export async function getCategoryBySlug(slug: string): Promise<Category | null> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('categories')
    .select('*')
    .eq('slug', slug)
    .single()

  if (error) {
    return null
  }
  return data as Category
}

export async function getProducts(categoryId?: string): Promise<Product[]> {
  const supabase = await createClient()
  
  let query = supabase
    .from('product_details_view')
    .select('*')
    
  if (categoryId) {
    query = query.eq('category_id', categoryId)
  }

  const { data, error } = await query

  if (error) {
    console.error('Error fetching products:', error.message, error.details, error.hint, error.code)
    return []
  }
  const enriched = await enrichProductImages(data as unknown as Product[])
  return filterOutPremiumProducts(enriched)
}

export async function getStandardProducts(categoryId?: string): Promise<Product[]> {
  return getProducts(categoryId)
}

export async function getPremiumProducts(): Promise<Product[]> {
  const supabase = await createClient()

  const { data: premiumIds } = await supabase
    .from('products')
    .select('id')
    .eq('is_premium', true)

  if (premiumIds && premiumIds.length > 0) {
    const ids = premiumIds.map((p: { id: string }) => p.id)
    const { data: fromView } = await supabase
      .from('product_details_view')
      .select('*')
      .in('product_id', ids)

    if (fromView && fromView.length > 0) {
      return enrichProductImages(fromView as unknown as Product[])
    }
  }

  let { data, error } = await supabase
    .from('product_details_view')
    .select('*')
    .eq('premium', true)

  if (error || !data?.length) {
    const fallback = await supabase
      .from('product_details_view')
      .select('*')
      .eq('is_premium', true)
    data = fallback.data
    error = fallback.error
  }

  if (error) return []
  return enrichProductImages(data as unknown as Product[])
}

export async function getTopPremiumProducts(limit = 5): Promise<Product[]> {
  const products = await getPremiumProducts()
  return products.slice(0, limit)
}

/** Homepage: first N shop categories (Whisky, Vodka, Rum, etc.) */
export async function getHomepageCategories(limit = 5): Promise<Category[]> {
  const categories = await getShopCategories()

  // Add AI-style images for categories
  const categoryImages: Record<string, string> = {
    'whisky': 'https://images.unsplash.com/photo-1527281400683-1aae777175f8?q=80&w=1000&auto=format&fit=crop',
    'whiskey': 'https://images.unsplash.com/photo-1527281400683-1aae777175f8?q=80&w=1000&auto=format&fit=crop',
    'vodka': 'https://images.unsplash.com/photo-1607622750642-4d71d4e7e3e0?q=80&w=1000&auto=format&fit=crop',
    'gin': 'https://images.unsplash.com/photo-1619371191026-646279316492?q=80&w=1000&auto=format&fit=crop', // Whiskey image as requested
    'rum': 'https://images.unsplash.com/photo-1569529465841-dfecdab7503b?q=80&w=1000&auto=format&fit=crop',
    'tequila': 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1000&auto=format&fit=crop',
    'beer': 'https://images.unsplash.com/photo-1608270586620-248524c67de9?q=80&w=1000&auto=format&fit=crop',
    'beer-brands': 'https://images.unsplash.com/photo-1608270586620-248524c67de9?q=80&w=1000&auto=format&fit=crop',
    'cans': 'https://images.unsplash.com/photo-1581006852262-e4307cf6283a?q=80&w=1200&auto=format&fit=crop', // Beer cans
    'champagne': 'https://images.unsplash.com/photo-1594372365401-3b5ff14eaaed?q=80&w=1000&auto=format&fit=crop',
    'champagne-sparkling': 'https://images.unsplash.com/photo-1594372365401-3b5ff14eaaed?q=80&w=1000&auto=format&fit=crop',
    'dutch-gin-genever-cognac': 'https://images.unsplash.com/photo-1569529465841-dfecdab7503b?q=80&w=1000&auto=format&fit=crop', // Cognac/brandy image
    'liqueurs-shots': 'https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?q=80&w=1000&auto=format&fit=crop',
    'wines': 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?q=80&w=1000&auto=format&fit=crop',
    'soft-drinks': 'https://images.unsplash.com/photo-1527960471264-932f39eb5846?q=80&w=1000&auto=format&fit=crop',
    'seed-drinks-infused': 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1000&auto=format&fit=crop',
  }

  return categories.slice(0, limit).map(cat => ({
    ...cat,
    image: cat.image || categoryImages[cat.slug?.toLowerCase() || ''] || categoryImages[cat.name?.toLowerCase() || ''] || null
  }))
}

export async function getFeaturedProducts(): Promise<Product[]> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('product_details_view')
    .select('*')
    .eq('featured', true)
    .limit(3)

  if (error) {
    return []
  }
  return enrichProductImages(data as unknown as Product[])
}

export async function getProductBySlug(slug: string): Promise<Product | null> {
  const supabase = await createClient()

  const { data, error } = await supabase
    .from('product_details_view')
    .select('*')
    .eq('product_slug', slug)
    .single()

  if (error) {
    console.error('Error fetching product details:', {
      message: error.message,
      details: error.details,
      hint: error.hint,
      code: error.code,
      slug: slug
    })
    return null
  }
  const [enriched] = await enrichProductImages([data as unknown as Product])
  if (!enriched) return null
  return attachVariantsFromTable(enriched)
}

export async function getBrands(): Promise<string[]> {
  const supabase = await createClient()
  const { data, error } = await supabase.from('products').select('brand')

  if (error) return []

  const uniqueBrands = Array.from(
    new Set(
      (data as { brand: string | null }[]).map((item) => item.brand).filter(Boolean)
    )
  ) as string[]

  return uniqueBrands.sort((a, b) => a.localeCompare(b))
}

export async function getTopBrands(limit = 5): Promise<string[]> {
  const brands = await getBrands()
  return brands.slice(0, limit)
}

export async function getProductsByBrand(brand: string): Promise<Product[]> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('product_details_view')
    .select('*')
    .ilike('brand', brand)

  if (error) {
    console.error('Error fetching products by brand:', error.message)
    return []
  }
  const enriched = await enrichProductImages(data as unknown as Product[])
  return filterOutPremiumProducts(enriched)
}
