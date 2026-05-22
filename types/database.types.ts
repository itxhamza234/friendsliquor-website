export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          id: string
          full_name: string | null
          email: string
          phone: string | null
          address: Json | null
          role: 'customer' | 'admin' | 'manager'
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          full_name?: string | null
          email: string
          phone?: string | null
          address?: Json | null
          role?: 'customer' | 'admin' | 'manager'
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          full_name?: string | null
          email?: string
          phone?: string | null
          address?: Json | null
          role?: 'customer' | 'admin' | 'manager'
          created_at?: string
          updated_at?: string
        }
      }
      categories: {
        Row: {
          id: string
          name: string
          slug: string
          image: string | null
          description: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          slug: string
          image?: string | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          slug?: string
          image?: string | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      products: {
        Row: {
          id: string
          slug: string
          product_name: string
          category_id: string | null
          brand: string | null
          description: string | null
          premium: boolean
          featured: boolean
          image_url: string | null
          rating: number
          stock: number
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          slug: string
          product_name: string
          category_id?: string | null
          brand?: string | null
          description?: string | null
          premium?: boolean
          featured?: boolean
          image_url?: string | null
          rating?: number
          stock?: number
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          slug?: string
          product_name?: string
          category_id?: string | null
          brand?: string | null
          description?: string | null
          premium?: boolean
          featured?: boolean
          image_url?: string | null
          rating?: number
          stock?: number
          created_at?: string
          updated_at?: string
        }
      }
      product_variants: {
        Row: {
          id: string
          product_id: string
          variant_name: string | null
          size: string
          price_euro: number
          stock: number
          sku: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          product_id: string
          variant_name?: string | null
          size: string
          price_euro: number
          stock?: number
          sku?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          product_id?: string
          variant_name?: string | null
          size?: string
          price_euro?: number
          stock?: number
          sku?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      cart: {
        Row: {
          id: string
          user_id: string
          product_variant_id: string
          quantity: number
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          product_variant_id: string
          quantity?: number
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          product_variant_id?: string
          quantity?: number
          created_at?: string
        }
      }
      wishlist: {
        Row: {
          id: string
          user_id: string
          product_id: string
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          product_id: string
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          product_id?: string
          created_at?: string
        }
      }
      orders: {
        Row: {
          id: string
          user_id: string | null
          total_price: number
          total_amount: number | null
          payment_status: 'pending' | 'completed' | 'failed' | 'refunded'
          order_status: 'pending' | 'processing' | 'shipped' | 'delivered' | 'cancelled'
          shipping_address: Json
          stripe_session_id: string | null
          stripe_payment_intent_id: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id?: string | null
          total_price?: number
          total_amount?: number
          payment_status?: 'pending' | 'completed' | 'failed' | 'refunded'
          order_status?: 'pending' | 'processing' | 'shipped' | 'delivered' | 'cancelled'
          shipping_address: Json
          stripe_session_id?: string | null
          stripe_payment_intent_id?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string | null
          total_price?: number
          total_amount?: number
          payment_status?: 'pending' | 'completed' | 'failed' | 'refunded'
          order_status?: 'pending' | 'processing' | 'shipped' | 'delivered' | 'cancelled'
          shipping_address?: Json
          stripe_session_id?: string | null
          stripe_payment_intent_id?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      order_items: {
        Row: {
          id: string
          order_id: string
          product_variant_id: string | null
          quantity: number
          price: number
          created_at: string
        }
        Insert: {
          id?: string
          order_id: string
          product_variant_id?: string | null
          quantity: number
          price: number
          created_at?: string
        }
        Update: {
          id?: string
          order_id?: string
          product_variant_id?: string | null
          quantity?: number
          price?: number
          created_at?: string
        }
      }
      payments: {
        Row: {
          id: string
          order_id: string
          user_id: string | null
          amount: number
          currency: string
          payment_method: string
          cardholder_name: string | null
          card_last_four: string | null
          status: 'pending' | 'completed' | 'failed' | 'refunded'
          metadata: Json
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          order_id: string
          user_id?: string | null
          amount: number
          currency?: string
          payment_method?: string
          cardholder_name?: string | null
          card_last_four?: string | null
          status?: 'pending' | 'completed' | 'failed' | 'refunded'
          metadata?: Json
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          order_id?: string
          user_id?: string | null
          amount?: number
          currency?: string
          payment_method?: string
          cardholder_name?: string | null
          card_last_four?: string | null
          status?: 'pending' | 'completed' | 'failed' | 'refunded'
          metadata?: Json
          created_at?: string
          updated_at?: string
        }
      }
    }
    Views: {
      product_details_view: {
        Row: {
          product_id: string
          product_slug: string
          product_name: string
          brand: string | null
          description: string | null
          premium: boolean
          featured: boolean
          image_url: string | null
          rating: number
          total_stock: number
          created_at: string
          category_id: string | null
          category_name: string | null
          category_slug: string | null
          variants: Json | null
        }
      }
    }
  }
}
