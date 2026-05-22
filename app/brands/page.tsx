import { getBrands } from '@/lib/api/products';
import Link from 'next/link';

export const revalidate = 0;

export default async function BrandsPage() {
  const brands = await getBrands();

  return (
    <div className="w-full min-h-screen pt-32 pb-24 px-6 relative">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,rgba(255,0,0,0.1),transparent_50%)] pointer-events-none" />
      
      <div className="max-w-7xl mx-auto relative z-10">
        <div className="text-center mb-20">
          <h1 className="text-5xl md:text-7xl font-black mb-6 uppercase tracking-tighter">
            Our <span className="text-red-500">Brands</span>
          </h1>
          <p className="text-white/50 text-xl max-w-2xl mx-auto">
            Discover our curated collection of the world&apos;s most prestigious liquor brands.
          </p>
        </div>

        {brands.length === 0 ? (
          <div className="text-center text-white/50 py-20">No brands found in the catalog.</div>
        ) : (
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {brands.map((brand, index) => (
              <Link 
                key={brand} 
                href={`/brands/${encodeURIComponent(brand.toLowerCase().replace(/ /g, '-'))}`}
                className="group relative rounded-3xl overflow-hidden bg-white/5 border border-white/10 p-8 flex flex-col items-center justify-center aspect-square hover:bg-white/10 hover:border-red-500/50 transition-all duration-500 hover:-translate-y-2"
              >
                <div className="absolute inset-0 bg-gradient-to-t from-red-500/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
                <h3 className="text-2xl font-bold text-center relative z-10 group-hover:scale-110 transition-transform duration-500">
                  {brand}
                </h3>
              </Link>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
