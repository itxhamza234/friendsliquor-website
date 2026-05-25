'use client'

import { useEffect, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import ProductCard from '@/components/ProductCard'
import { Product } from '@/types/product'

type Category = {
  id: string
  name: string
  slug: string
  image: string | null
  description: string | null
  created_at: string
  updated_at: string
}

export default function ShopPage() {
  const [products, setProducts] = useState<Product[]>([])
  const [categories, setCategories] = useState<Category[]>([])
  const [filteredProducts, setFilteredProducts] = useState<Product[]>([])
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)
  const searchParams = useSearchParams()

  useEffect(() => {
    const fetchData = async () => {
      const supabase = createClient()

      // 🔥 CACHE BUSTER QUERY: `.not` modifier query structure ko unique banata hai
      // jis se Next.js aur browser ka local cache majbooran bypass ho jata hai aur direct fresh DB data aata hai.
      const { data: productsData } = await supabase
        .from('product_details_view')
        .select('*')
        .not('product_id', 'is', null)

      // 🔥 STRICT DATABASE FILTER: Filter out premium items (fallback since premium products are now in separate table)
      const nonPremiumProducts = (productsData || []).filter(
        (p: any) => {
          const isPremiumFlag =
            p.premium === true ||
            String(p.premium).toLowerCase() === 'true' ||
            p.is_premium === true ||
            String(p.is_premium).toLowerCase() === 'true';

          return !isPremiumFlag;
        }
      )

      const { data: categoriesData } = await supabase
        .from('categories')
        .select('*')
        .order('name')

      const visibleCategories = (categoriesData || []) as Category[]

      setProducts(nonPremiumProducts as Product[])
      setCategories(visibleCategories)
      setFilteredProducts(nonPremiumProducts as Product[])

      const categorySlug = searchParams.get('category')
      if (categorySlug) {
        const matchedCat = visibleCategories.find(
          (cat: Category) => cat.slug === categorySlug
        )
        if (matchedCat) setSelectedCategory(matchedCat.id)
      }

      setLoading(false)
    }
    fetchData()
  }, [searchParams])

  useEffect(() => {
    let filtered = [...products]
    if (selectedCategory) {
      filtered = filtered.filter(p => p.category_id === selectedCategory)
    }
    setFilteredProducts(filtered)
  }, [products, selectedCategory])

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-white">Loading...</div>
      </div>
    )
  }

  return (
    <div className="w-full pb-24">
      {/* Shop Hero */}
      <section className="relative h-[40vh] min-h-[300px] md:min-h-[400px] flex items-center justify-center px-6 border-b border-white/10">
        <div
          className="absolute inset-0 opacity-20 bg-cover bg-center"
          style={{ backgroundImage: "url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1974&auto=format&fit=crop')" }}
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/80 to-transparent" />
        <div className="relative z-10 text-center max-w-3xl mx-auto mt-10 px-4">
          <h1 className="text-4xl md:text-6xl lg:text-7xl font-black mb-6">
            Our <span className="text-red-500">Collection</span>
          </h1>
          <p className="text-lg md:text-xl text-white/70">
            Explore the finest selection of premium liquors in Amsterdam.
          </p>
        </div>
      </section>

      {/* Main Content */}
      <div className="max-w-[1400px] mx-auto px-3 sm:px-4 md:px-6 py-6 md:py-8 lg:py-12 flex flex-col lg:flex-row gap-6 lg:gap-12">

        {/* Sidebar Categories */}
        <aside className="w-full lg:w-72 flex-shrink-0 order-1">
          <div className="sticky top-[72px] lg:top-[100px] space-y-6 lg:space-y-8">
            <div>
              <h4 className="font-bold text-sm md:text-base lg:text-lg mb-3 md:mb-4 uppercase tracking-wider">
                Categories
              </h4>

              {/* Mobile: Horizontal Scroll Pills */}
              <div className="flex lg:hidden gap-2 overflow-x-auto pb-2 scrollbar-hide">
                <button
                  onClick={() => setSelectedCategory(null)}
                  className={`flex-shrink-0 px-3 py-1.5 rounded-full text-xs font-bold transition ${
                    !selectedCategory ? 'bg-red-500 text-white' : 'bg-white/10 text-white/60'
                  }`}
                >
                  All ({products.length})
                </button>
                {categories.map(cat => {
                  const count = products.filter(p => p.category_id === cat.id).length
                  return (
                    <button
                      key={cat.id}
                      onClick={() => setSelectedCategory(cat.id)}
                      className={`flex-shrink-0 px-3 py-1.5 rounded-full text-xs font-bold transition ${
                        selectedCategory === cat.id
                          ? 'bg-red-500 text-white'
                          : 'bg-white/10 text-white/60'
                      }`}
                    >
                      {cat.name} ({count})
                    </button>
                  )
                })}
              </div>

              {/* Desktop: Vertical List */}
              <div className="hidden lg:block space-y-2 md:space-y-3 max-h-[calc(100vh-220px)] overflow-y-auto pr-2 scrollbar-thin scrollbar-thumb-white/10 scrollbar-track-transparent">
                <button
                  onClick={() => setSelectedCategory(null)}
                  className={`flex items-center justify-between w-full transition group cursor-pointer py-2 px-3 rounded-lg ${
                    !selectedCategory
                      ? 'text-red-500 bg-red-500/10'
                      : 'text-white/60 hover:text-white hover:bg-white/5'
                  }`}
                >
                  <span className="text-sm md:text-base">All Products</span>
                  <span className={`px-2 py-0.5 rounded-full text-xs font-bold ${
                    !selectedCategory ? 'bg-red-500/20 text-red-500' : 'bg-white/5 group-hover:bg-white/10'
                  }`}>
                    {products.length}
                  </span>
                </button>
                {categories.map(cat => {
                  const count = products.filter(p => p.category_id === cat.id).length
                  return (
                    <button
                      key={cat.id}
                      onClick={() => setSelectedCategory(cat.id)}
                      className={`flex items-center justify-between w-full transition group cursor-pointer py-2 px-3 rounded-lg ${
                        selectedCategory === cat.id
                          ? 'text-red-500 bg-red-500/10'
                          : 'text-white/60 hover:text-white hover:bg-white/5'
                      }`}
                    >
                      <span className="text-sm md:text-base">{cat.name}</span>
                      <span className={`px-2 py-0.5 rounded-full text-xs ${
                        selectedCategory === cat.id
                          ? 'bg-red-500/20 text-red-500'
                          : 'bg-white/5 group-hover:bg-white/10'
                      }`}>
                        {count}
                      </span>
                    </button>
                  )
                })}
              </div>
            </div>
          </div>
        </aside>

        {/* Product Grid */}
        <div className="flex-1 order-2">
          {/* Top Toolbar */}
          <div className="flex flex-wrap items-center justify-between gap-3 md:gap-4 mb-4 md:mb-6 lg:mb-8 bg-white/5 border border-white/10 rounded-xl md:rounded-2xl p-3 md:p-4 backdrop-blur-md">
            <p className="text-white/60 font-medium text-xs sm:text-sm md:text-base">
              Showing {filteredProducts.length} of {products.length} products
            </p>
          </div>

          {/* Grid */}
          {filteredProducts.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-white/60 text-base md:text-lg">No products found in this category</p>
              <button
                onClick={() => setSelectedCategory(null)}
                className="mt-4 text-red-500 hover:underline"
              >
                View all products
              </button>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3 md:gap-4 lg:gap-6 xl:gap-8">
              {filteredProducts.map(product => (
                <ProductCard key={product.product_id} product={product} />
              ))}
            </div>
          )}
        </div>

      </div>
    </div>
  )
}