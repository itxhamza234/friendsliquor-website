import { createClient } from '@/lib/supabase/server'
import { Database } from '@/types/database.types'
import { Product } from '@/types/product'
import { withResolvedProductImage } from '@/lib/utils/productImage'
import {
  normalizeProductVariants,
  normalizeVariantFromRow,
} from '@/lib/utils/productVariants'

type Category = Database['public']['Tables']['categories']['Row']

type ProductImageRow = {
  id: string
  image_url: string | null
  image: string | null
}

/** View reads variant images; admin saves on products — fill gaps from products or premium_products table. */
async function enrichProductImages(products: Product[]): Promise<Product[]> {
  const needsLookup = products.filter((p) => !p.image_url && !p.image)
  if (needsLookup.length === 0) {
    return products.map((p) =>
      normalizeProductVariants(withResolvedProductImage(p))
    )
  }

  const supabase = await createClient()
  const ids = needsLookup.map((p) => p.product_id)

  const { data: standardData, error: standardError } = await supabase
    .from('products')
    .select('id, image_url, image')
    .in('id', ids)

  const { data: premiumData, error: premiumError } = await (supabase
    .from('premium_products') as any)
    .select('id, image_url, image')
    .in('id', ids)

  const imageById = new Map()

  if (!standardError && standardData) {
    for (const row of standardData as ProductImageRow[]) {
      imageById.set(row.id, row.image_url || row.image || null)
    }
  }

  if (!premiumError && premiumData) {
    for (const row of premiumData as ProductImageRow[]) {
      if (!imageById.has(row.id)) {
        imageById.set(row.id, row.image_url || row.image || null)
      }
    }
  }

  if (standardError && premiumError) {
    console.error('Error fetching product images:', standardError.message, premiumError.message)
    return products.map((p) =>
      normalizeProductVariants(withResolvedProductImage(p))
    )
  }

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

  return enriched.filter((product) => {
    const raw = product as any
    const isPremiumItem =
      raw.premium === true ||
      raw.premium === 'true' ||
      raw.is_premium === true ||
      raw.is_premium === 'true'

    return !isPremiumItem
  })
}

export async function getStandardProducts(categoryId?: string): Promise<Product[]> {
  return getProducts(categoryId)
}

export async function getPremiumProducts(): Promise<Product[]> {
  const supabase = await createClient()

  const { data, error } = await (supabase
    .from('premium_products') as any)
    .select('*')
    .eq('is_active', true)

  if (error) {
    console.error('Error fetching premium products:', error.message)
    return []
  }

  if (!data?.length) return []

  const productIds = data.map((p: any) => p.id)

  const { data: variants, error: variantError } = await (supabase
    .from('premium_product_variants') as any)
    .select('*')
    .in('product_id', productIds)

  if (variantError) {
    console.error('Error fetching premium variants:', variantError.message)
  }

  const variantsByProduct = new Map<string, any[]>()
  for (const variant of variants || []) {
    if (!variantsByProduct.has(variant.product_id)) {
      variantsByProduct.set(variant.product_id, [])
    }
    variantsByProduct.get(variant.product_id)!.push(variant)
  }

  const enriched = data.map((product: any) => {
    const productVariants = variantsByProduct.get(product.id) || []

    return normalizeProductVariants({
      product_id: product.id,
      product_name: product.product_name || product.name,
      product_slug: product.slug,
      brand: product.brand,
      description: product.description,
      category_id: product.category_id,
      image_url: product.image_url || product.image || null,
      image: product.image || product.image_url || null,
      is_premium: true,
      is_active: product.is_active,
      is_featured: product.is_featured,
      flavor_profile: product.flavor_profile,
      abv: product.abv,
      variants: productVariants.map((v: any) =>
        normalizeVariantFromRow(v as Record<string, unknown>)
      ),
    } as unknown as Product)
  })

  return enrichProductImages(enriched)
}

export async function getTopPremiumProducts(limit = 5): Promise<Product[]> {
  const products = await getPremiumProducts()
  return products.slice(0, limit)
}