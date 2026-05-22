import Link from 'next/link';
import { Product } from '@/types/product';
import { getProductImageUrl } from '@/lib/utils/productImage';
import AddToCartButton from '@/components/AddToCartButton';

interface ProductCardProps {
  product: Product
}

export default function ProductCard({ product }: ProductCardProps) {
  // Bridge the old mock data format and the new Supabase ProductView format
  const id = product.id || product.product_slug || product.product_id;
  const name = product.name || product.product_name || '';
  const brand = product.brand || '';
  const fullName = brand ? `${brand} ${name}`.trim() : name;
  const category = product.category_name || product.category || '';
  const isPremium = product.premium || product.is_premium;

  // Category-based placeholder images with variety
  const getPlaceholderImage = (catName: string, pName: string) => {
    const c = (catName || '').toLowerCase();
    const hash = pName.split('').reduce((acc, char) => acc + char.charCodeAt(0), 0);
    
    if (c.includes('whisky')) {
      const imgs = [
        'https://images.unsplash.com/photo-1599411062035-7798f41e3828?q=80&w=800',
        'https://images.unsplash.com/photo-1527281400683-1aae777175f8?q=80&w=800',
        'https://images.unsplash.com/photo-1614316886475-654db906dc6c?q=80&w=800'
      ];
      return imgs[hash % imgs.length];
    }
    if (c.includes('wine')) {
      const imgs = [
        'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?q=80&w=800',
        'https://images.unsplash.com/photo-1584916201218-f4242ceb4809?q=80&w=800',
        'https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?q=80&w=800'
      ];
      return imgs[hash % imgs.length];
    }
    if (c.includes('vodka')) {
      const imgs = [
        'https://images.unsplash.com/photo-1614313511387-1436a4480ebb?q=80&w=800',
        'https://images.unsplash.com/photo-1582819509237-d2b2c88f0e31?q=80&w=800'
      ];
      return imgs[hash % imgs.length];
    }
    if (c.includes('champagne') || c.includes('sparkling')) {
      const imgs = [
        'https://images.unsplash.com/photo-1558636508-e0ee976bb7eb?q=80&w=800',
        'https://images.unsplash.com/photo-1595991209266-5dd5fbc8f5c3?q=80&w=800'
      ];
      return imgs[hash % imgs.length];
    }
    if (c.includes('gin')) return 'https://images.unsplash.com/photo-1551538827-9c037cb4f32a?q=80&w=800';
    if (c.includes('tequila')) return 'https://images.unsplash.com/photo-1516535794938-6063878f08cc?q=80&w=800';
    if (c.includes('cognac')) return 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=800';
    return 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=800';
  };

  const image = getProductImageUrl(product) || getPlaceholderImage(category, name);
  
  const defaultVariant =
    product.variants && product.variants.length > 0 ? product.variants[0] : null
  const price = defaultVariant
    ? Number(defaultVariant.price_euro ?? 0)
    : Number(product.price ?? 0)
  const variantId =
    defaultVariant?.id && Number(defaultVariant.stock ?? 0) > 0
      ? defaultVariant.id
      : undefined

  return (
    <div className={`group rounded-[20px] sm:rounded-[25px] md:rounded-[30px] lg:rounded-[35px] overflow-hidden bg-white/5 border border-white/10 backdrop-blur-xl transition-all duration-500 hover:-translate-y-2 sm:hover:-translate-y-3 md:hover:-translate-y-4 flex flex-col h-full ${product.premium || product.is_premium ? 'hover:shadow-[0_0_60px_rgba(255,0,0,0.3)]' : 'hover:shadow-[0_0_40px_rgba(255,255,255,0.1)]'}`}>
      <div className="relative overflow-hidden aspect-[4/5] bg-black/20">
        <img
          src={image}
          alt={name}
          className="w-full h-full object-cover group-hover:scale-110 transition duration-700 opacity-90 group-hover:opacity-100"
        />

        {/* Badges */}
        <div className="absolute top-3 sm:top-4 md:top-5 left-3 sm:left-4 md:left-5 flex flex-col gap-1 sm:gap-2 z-10">
          {isPremium && (
            <span className="px-2 sm:px-3 md:px-4 py-1 sm:py-1.5 md:py-2 rounded-full bg-gradient-to-r from-red-600 to-red-800 text-white font-black text-[8px] sm:text-[9px] md:text-[10px] tracking-widest shadow-lg border border-red-400/30 uppercase">PREMIUM</span>
          )}
          {product.isOnSale && (
            <span className="px-2 sm:px-3 md:px-4 py-1 sm:py-1.5 md:py-2 rounded-full bg-red-500 font-bold text-[10px] sm:text-xs md:text-xs shadow-lg">SALE</span>
          )}
          {product.isNew && (
            <span className="px-2 sm:px-3 md:px-4 py-1 sm:py-1.5 md:py-2 rounded-full bg-yellow-500 text-black font-bold text-[10px] sm:text-xs md:text-xs shadow-lg">NEW</span>
          )}
        </div>

        {/* Wishlist Button */}
        <button className="absolute top-3 sm:top-4 md:top-5 right-3 sm:right-4 md:right-5 w-8 h-8 sm:w-9 sm:h-9 md:w-10 md:h-10 rounded-full bg-black/50 backdrop-blur-md border border-white/20 flex items-center justify-center text-white/70 hover:text-red-500 hover:border-red-500 transition-all z-10">
          ♡
        </button>

        {/* Quick Actions (Hover) */}
        <div className="absolute inset-x-0 bottom-0 p-3 sm:p-4 opacity-0 group-hover:opacity-100 transform translate-y-4 group-hover:translate-y-0 transition-all duration-300 z-10 flex gap-2">
           <Link href={`/product/${id}`} className="flex-1 py-2 sm:py-2.5 md:py-3 text-center rounded-xl sm:rounded-2xl bg-white/10 backdrop-blur-xl border border-white/20 hover:bg-white/20 transition-all font-semibold text-xs sm:text-sm">
            Quick View
           </Link>
        </div>

        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
      </div>

      <div className="p-4 sm:p-5 md:p-6 lg:p-8 flex flex-col flex-1 justify-between gap-3 md:gap-4">
        <div>
          <p className="text-red-500/80 text-[9px] sm:text-[10px] md:text-[11px] font-black uppercase tracking-[2px] sm:tracking-[3px] mb-2 md:mb-3">{category || 'Luxury Selection'}</p>
          <Link href={`/product/${id}`}>
            <h4 className="text-sm sm:text-base md:text-lg lg:text-xl font-bold leading-snug break-words hover:text-red-500 transition-colors tracking-tight">{fullName}</h4>
          </Link>
        </div>

        <div className="flex items-center justify-between mt-auto pt-3 md:pt-4">
          <span className={`text-lg sm:text-xl md:text-2xl font-black ${isPremium ? 'text-yellow-400' : 'text-white'}`}>€{Number(price || 0).toFixed(2)}</span>

          <AddToCartButton
            variantId={variantId}
            price={price}
            size="sm"
            className="shrink-0"
          />
        </div>
      </div>
    </div>
  );
}
