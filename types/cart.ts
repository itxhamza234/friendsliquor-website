export type CartLineItem = {
  id: string
  product_variant_id: string
  quantity: number
  product_id: string
  product_name: string
  product_slug: string
  brand: string | null
  category_name: string | null
  image_url: string | null
  size: string
  price: number
  name?: string;
  lineTotal: number
}
