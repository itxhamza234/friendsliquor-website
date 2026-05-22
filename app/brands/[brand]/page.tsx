import { getBrands, getProductsByBrand } from '@/lib/api/products';
import ProductCard from '@/components/ProductCard';
import Link from 'next/link';

export const revalidate = 0;

export default async function BrandProductsPage({ params }: { params: Promise<{ brand: string }> }) {
  const resolvedParams = await params;
  const decodedBrand = decodeURIComponent(resolvedParams.brand).replace(/-/g, ' ');
  
  // Try to find the exact brand name with correct capitalization
  const allBrands = await getBrands();
  const exactBrand = allBrands.find(b => b.toLowerCase() === decodedBrand.toLowerCase()) || decodedBrand;

  const products = await getProductsByBrand(exactBrand);

  return (
    <div className="w-full min-h-screen pt-32 pb-24 px-6 relative">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,rgba(255,0,0,0.1),transparent_50%)] pointer-events-none" />
      
      <div className="max-w-7xl mx-auto relative z-10">
        <nav className="flex text-sm text-white/50 mb-12">
          <Link href="/" className="hover:text-red-500 transition">Home</Link>
          <span className="mx-3">/</span>
          <Link href="/brands" className="hover:text-red-500 transition">Brands</Link>
          <span className="mx-3">/</span>
          <span className="text-white capitalize">{exactBrand}</span>
        </nav>

        <div className="mb-16">
          <h1 className="text-5xl md:text-7xl font-black mb-4 capitalize">
            {exactBrand} <span className="text-red-500">Collection</span>
          </h1>
          <p className="text-white/50 text-xl">
            {products.length} {products.length === 1 ? 'product' : 'products'} available
          </p>
        </div>

        {products.length === 0 ? (
          <div className="text-center text-white/50 py-20">
            No products found for this brand.
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
            {products.map(product => (
              <ProductCard key={product.product_id} product={product} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
