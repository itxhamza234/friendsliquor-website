import { getProductBySlug, getProducts, getPremiumProducts } from '@/lib/api/products';
import { notFound } from 'next/navigation';
import Link from 'next/link';
import ProductDetailsClient from '@/components/ProductDetailsClient';
import { Product, ProductVariant } from '@/types/product';
import { getProductImageUrl } from '@/lib/utils/productImage';

export const revalidate = 0;

export default async function ProductPage({ params }: { params: Promise<{ id: string }> }) {
  const resolvedParams = await params;
  const product = await getProductBySlug(resolvedParams.id);
  
  if (!product) {
    notFound();
  }

  // Fetch related products
  // If current product is premium, show other premium products
  // Otherwise show products from same category
  let relatedProducts: Product[] = [];
  if (product.premium) {
    const allPremium = await getPremiumProducts();
    relatedProducts = allPremium.filter(p => p.product_id !== product.product_id);
  } else {
    const categoryProducts = await getProducts(product.category_id || undefined);
    relatedProducts = categoryProducts.filter(p => p.product_id !== product.product_id);
  }

  relatedProducts = relatedProducts.slice(0, 3);

  const productImage =
    getProductImageUrl(product) ||
    'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=800&auto=format&fit=crop';

  // We parse variants
  const variants = (product.variants as ProductVariant[]) || [];
  const defaultVariant = variants.length > 0 ? variants[0] : null;
  const price = defaultVariant ? defaultVariant.price_euro : 0;

  return (
    <div className="w-full pb-24 px-6 pt-12 max-w-7xl mx-auto">
      {/* Breadcrumb */}
      <nav className="flex text-sm text-white/50 mb-12">
        <Link href="/" className="hover:text-red-500 transition">Home</Link>
        <span className="mx-3">/</span>
        <Link href={`/${product.category_slug || ''}`} className="hover:text-red-500 transition capitalize">{product.category_name || 'Collection'}</Link>
        <span className="mx-3">/</span>
        <span className="text-white">{product.product_name}</span>
      </nav>

      <div className="grid md:grid-cols-2 gap-16">
        {/* Product Image Gallery */}
        <div className="relative rounded-[40px] overflow-hidden bg-white/5 border border-white/10 p-8 flex items-center justify-center aspect-square group">
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,0,0,0.1),transparent_70%)] opacity-0 group-hover:opacity-100 transition-opacity duration-700" />
          <img 
            src={productImage} 
            alt={product.product_name} 
            className="h-full w-auto object-contain hover:scale-110 transition-transform duration-700 relative z-10 drop-shadow-[0_0_30px_rgba(255,255,255,0.1)]"
          />
        </div>

        <ProductDetailsClient product={product} />
      </div>

      {/* Related Products */}
      {relatedProducts.length > 0 && (
        <div className="mt-32 border-t border-white/10 pt-20">
          <h3 className="text-4xl font-black mb-12 text-center">Related <span className="text-red-500">Products</span></h3>
          <div className="grid md:grid-cols-3 gap-8">
            {relatedProducts.map(p => {
              const pVariants = (p.variants as ProductVariant[]) || [];
              const defaultPVariant = pVariants.length > 0 ? pVariants[0] : null;
              const pPrice = defaultPVariant ? defaultPVariant.price_euro : 0;
              return (
                <Link key={p.product_id} href={`/product/${p.product_slug}`} className="group relative rounded-[30px] overflow-hidden bg-white/5 border border-white/10 p-6 flex flex-col items-center hover:bg-white/10 transition-all">
                  <img src={getProductImageUrl(p) || 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=800'} alt={p.product_name} className="h-48 w-auto object-contain mb-6 group-hover:scale-110 transition duration-500" />
                  <h4 className="font-bold text-xl mb-2 text-center">{p.product_name}</h4>
                  <span className="text-yellow-400 font-black">€{pPrice.toFixed(2)}</span>
                </Link>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
