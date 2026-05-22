export interface ProductVariant {
  id: string;
  variant_name: string | null;
  size: string;
  price_euro: number;
  stock: number;
  stock_quantity?: number;
  sku: string | null;
}

export interface Product {
  product_id: string;
  product_slug: string;
  product_name: string;
  brand: string | null;
  description: string | null;
  premium: boolean;
  featured: boolean;
  image_url: string | null;
  rating: number;
  total_stock: number;
  created_at: string;
  category_id: string | null;
  category_name: string | null;
  category_slug: string | null;
  variants: ProductVariant[] | null;
  
  // Legacy / Mock Data Support
  id?: string;
  name?: string;
  image?: string;
  category?: string;
  price?: number;
  isOnSale?: boolean;
  isNew?: boolean;
  is_premium?: boolean;
}
