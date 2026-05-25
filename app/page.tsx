import Link from 'next/link';
import { getPremiumProducts, getShopCategories } from '@/lib/api/products';
import ProductCard from '@/components/ProductCard';

export const revalidate = 0;

export default async function HomePage() {
  const [featuredProducts, homepageCategories] = await Promise.all([
    getPremiumProducts(),
    getShopCategories(),
  ]);

  const premiumFour = featuredProducts.slice(0, 4);

  return (
    <div className="w-full">

      {/* Hero */}
      <section className="relative min-h-screen flex items-center justify-center px-6">
        <div className="absolute inset-0 opacity-30 bg-cover bg-center" style={{ backgroundImage: "url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1974&auto=format&fit=crop')" }} />

        <div className="relative z-10 max-w-7xl mx-auto grid md:grid-cols-2 gap-16 items-center">
          <div>
            <p className="uppercase tracking-[8px] text-red-500 mb-4">Feeling Thirsty?</p>

            <h2 className="text-6xl md:text-8xl font-black leading-none mb-8">
              Premium
              <span className="block text-transparent bg-clip-text bg-gradient-to-r from-red-500 to-yellow-400">
                Drinks
              </span>
              Delivered
            </h2>

            <p className="text-white/70 text-xl leading-relaxed mb-10 max-w-xl">
              Discover Amsterdam&apos;s most luxurious liquor delivery experience with premium whiskey, champagne, wine, vodka and exclusive collections.
            </p>

            <div className="flex flex-wrap gap-5">
              <Link href="/premium-drinks" className="px-8 py-4 rounded-full bg-red-500 text-lg font-bold hover:scale-105 transition-all shadow-[0_0_40px_rgba(255,0,0,0.6)] inline-block">
                Order Now
              </Link>

              <Link href="/shop" className="px-8 py-4 rounded-full border border-white/20 bg-white/5 backdrop-blur-xl hover:bg-white/10 transition-all text-lg inline-block">
                Explore Collections
              </Link>
            </div>
          </div>

          <div className="relative flex justify-center">
            <div className="absolute w-96 h-96 bg-red-500/20 blur-[120px] rounded-full" />
            <img
              src="https://images.unsplash.com/photo-1569529465841-dfecdab7503b?q=80&w=1887&auto=format&fit=crop"
              alt="Bottle"
              className="relative z-10 w-full max-w-[450px] rounded-[40px] rotate-[-8deg] shadow-[0_0_100px_rgba(255,0,0,0.4)] hover:scale-105 transition duration-700"
            />
          </div>
        </div>
      </section>

      {/* Premium Drinks */}
      <section className="py-24 px-6">
        <div className="max-w-7xl mx-auto">
          <h3 className="text-5xl font-black tracking-tight mb-12 text-center md:text-left">
            PREMIUM <span className="text-red-500">DRINKS</span>
          </h3>

          {premiumFour.length > 0 ? (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
              {premiumFour.map((product) => (
                <ProductCard key={product.product_id} product={product} />
              ))}
            </div>
          ) : (
            <p className="text-white/50 text-center py-12">No premium drinks available yet.</p>
          )}

          <div className="mt-12 text-center">
            <Link
              href="/premium-drinks"
              className="inline-block px-10 py-4 rounded-full bg-gradient-to-r from-red-600 to-red-500 hover:from-red-500 hover:to-red-400 font-bold text-lg shadow-[0_0_40px_rgba(255,0,0,0.4)] transition-all hover:scale-105"
            >
              VIEW ALL PREMIUM DRINKS
            </Link>
          </div>
        </div>
      </section>

      {/* Our Collections */}
      <section className="py-24 px-6 bg-gradient-to-b from-black to-[#120707]">
        <div className="max-w-7xl mx-auto">
          <h3 className="text-5xl font-black mb-12 text-center md:text-left">
            OUR <span className="text-red-500">COLLECTIONS</span>
          </h3>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {homepageCategories.slice(0, 4).map((cat) => (
              <Link
                key={cat.id}
                href={`/shop?category=${cat.slug}`}
                className="group relative rounded-3xl overflow-hidden bg-white/5 border border-white/10 aspect-square hover:bg-white/10 hover:border-red-500/50 transition-all duration-500 hover:-translate-y-2"
              >
                {cat.image && (
                  <div
                    className="absolute inset-0 bg-cover bg-center group-hover:scale-110 transition-transform duration-700"
                    style={{ backgroundImage: `url('${cat.image}')` }}
                  />
                )}
                <div className="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent" />
                <div className="absolute inset-0 flex flex-col items-center justify-center p-4">
                  <h4 className="text-base md:text-lg font-bold text-center text-white group-hover:text-red-400 transition-colors">
                    {cat.name}
                  </h4>
                </div>
              </Link>
            ))}
          </div>

          <div className="mt-12 text-center">
            <Link
              href="/shop"
              className="inline-block px-10 py-4 rounded-full border border-white/20 bg-white/5 hover:bg-red-500 hover:border-red-500 font-bold transition-all"
            >
              VIEW ALL CATEGORIES
            </Link>
          </div>
        </div>
      </section>

      {/* Delivery */}
      <section className="py-24 px-6">
        <div className="max-w-7xl mx-auto rounded-[40px] border border-white/10 bg-gradient-to-r from-red-950/40 to-black/60 p-8 md:p-16 backdrop-blur-xl">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <p className="uppercase tracking-[5px] text-yellow-400 mb-4">Fast Delivery</p>
              <h3 className="text-4xl md:text-6xl font-black mb-8 leading-tight">
                Amsterdam Same Day Delivery
              </h3>
              <p className="text-white/70 text-lg mb-8 leading-relaxed">
                Get your favorite premium drinks delivered in under 30 minutes with our luxury express delivery system.
              </p>
              <div className="flex gap-4 flex-wrap">
                <div className="px-5 py-3 rounded-2xl bg-black/40 border border-white/10 text-sm">⚡ 30 Min Delivery</div>
                <div className="px-5 py-3 rounded-2xl bg-black/40 border border-white/10 text-sm">🍾 Premium Packaging</div>
                <div className="px-5 py-3 rounded-2xl bg-black/40 border border-white/10 text-sm">🔒 Secure Payments</div>
              </div>
            </div>
            <div className="relative rounded-[35px] overflow-hidden border border-white/10 bg-gradient-to-br from-red-900/30 to-black">
              <img
                src="https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?q=80&w=1200&auto=format&fit=crop"
                alt="Delivery"
                className="h-[400px] md:h-[500px] w-full object-cover"
              />
            </div>
          </div>
        </div>
      </section>

    </div>
  );
}