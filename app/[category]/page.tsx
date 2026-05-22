import { getCategoryBySlug, getProducts } from '@/lib/api/products';
import ProductCard from '@/components/ProductCard';
import { notFound } from 'next/navigation';

export const revalidate = 0;

export default async function CategoryPage({
  params,
}: {
  params: Promise<{ category: string }>;
}) {

  const resolvedParams = await params;
  const categorySlug = resolvedParams.category;

  const categoryInfo = await getCategoryBySlug(categorySlug);

  if (!categoryInfo) {
    notFound();
  }

  // Fetch all category products
  const allProducts = await getProducts(categoryInfo.id);

  // Remove premium drinks from normal categories
  const categoryProducts = allProducts.filter(
    (product) => product.is_premium === false
  );

  return (
    <div className="w-full pb-24">

      {/* Category Hero */}
      <section className="relative h-[60vh] min-h-[500px] flex items-center justify-center px-6">

        <div
          className="absolute inset-0 opacity-40 bg-cover bg-center"
          style={{
            backgroundImage: `url('${
              categoryInfo.image ||
              'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1974'
            }')`,
          }}
        />

        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/50 to-transparent" />

        <div className="relative z-10 text-center max-w-3xl mx-auto">

          <p className="uppercase tracking-[8px] text-red-500 mb-4 font-bold">
            Category
          </p>

          <h1 className="text-6xl md:text-8xl font-black mb-6">
            {categoryInfo.name}
          </h1>

          <p className="text-xl text-white/80 leading-relaxed">
            {categoryInfo.description || 'Discover our premium selection.'}
          </p>

        </div>
      </section>

      {/* Toolbar */}
      <div className="sticky top-[88px] z-40 bg-black/80 backdrop-blur-md border-y border-white/10 py-4 px-6 mb-12">

        <div className="max-w-7xl mx-auto flex flex-wrap items-center justify-between gap-4">

          <p className="text-white/60">
            Showing {categoryProducts.length} results
          </p>

          <div className="flex gap-4">

            <button className="px-6 py-2 rounded-full border border-white/20 bg-white/5 hover:bg-white/10 transition-all text-sm flex items-center gap-2">
              <span>Filter</span>
              <span>▼</span>
            </button>

            <button className="px-6 py-2 rounded-full border border-white/20 bg-white/5 hover:bg-white/10 transition-all text-sm flex items-center gap-2">
              <span>Sort: Featured</span>
              <span>▼</span>
            </button>

          </div>
        </div>
      </div>

      {/* Product Grid */}
      <div className="max-w-7xl mx-auto px-6">

        {categoryProducts.length > 0 ? (

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">

            {categoryProducts.map((product) => (
              <ProductCard
                key={product.product_id}
                product={product}
              />
            ))}

          </div>

        ) : (

          <div className="text-center py-20 text-white/60">

            <h3 className="text-2xl font-bold mb-4">
              No products found
            </h3>

            <p>
              We are currently updating our collection.
            </p>

          </div>

        )}

      </div>
    </div>
  );
}