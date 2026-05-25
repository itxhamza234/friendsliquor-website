import { getPremiumProducts } from '@/lib/api/products'
import ProductCard from '@/components/ProductCard'

export const revalidate = 0

export default async function PremiumDrinksPage() {

  const premiumProducts = await getPremiumProducts()

  console.log('Premium products count:', premiumProducts.length)
  console.log('First product:', JSON.stringify(premiumProducts[0], null, 2))

  return (
    <div className="w-full bg-black min-h-screen text-white pb-24">

      {/* Hero */}
      <section className="relative h-[40vh] min-h-[300px] flex items-center justify-center px-6 border-b border-white/10">

        <div
          className="absolute inset-0 opacity-20 bg-cover bg-center"
          style={{
            backgroundImage:
              "url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1974&auto=format&fit=crop')",
          }}
        />

        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/80 to-transparent" />

        <div className="relative z-10 text-center max-w-3xl mx-auto mt-10 px-4">

          <h1 className="text-4xl md:text-6xl lg:text-7xl font-black mb-6">
            Premium <span className="text-red-500">Drinks</span>
          </h1>

          <p className="text-lg md:text-xl text-white/70">
            Explore our exclusive premium liquor collection.
          </p>

        </div>
      </section>

      {/* Debug Info - baad mein remove kar dena */}
      <div className="max-w-[1400px] mx-auto px-4 py-4">
        <p className="text-yellow-400 text-sm">
          Total products found: {premiumProducts.length}
        </p>
      </div>

      {/* Products */}
      <div className="max-w-[1400px] mx-auto px-4 md:px-6 py-12">

        {premiumProducts.length === 0 ? (

          <div className="text-center py-20 text-white/60">
            No premium products found
          </div>

        ) : (

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">

            {premiumProducts.map((product) => (

              <ProductCard
                key={product.product_id}
                product={product}
              />

            ))}

          </div>

        )}

      </div>
    </div>
  )
}