'use client';

import { useState } from 'react';
import { Product, ProductVariant } from '@/types/product';
import AddToCartButton from '@/components/AddToCartButton';

export default function ProductDetailsClient({ product }: { product: Product }) {
  const variants: ProductVariant[] = product.variants || [];
  const isPremium = product.premium || product.is_premium;

  // Sort variants by size ascending or just use as is
  const [selectedVariant, setSelectedVariant] = useState<ProductVariant | null>(variants.length > 0 ? variants[0] : null);
  const [quantity, setQuantity] = useState(1);

  const price = selectedVariant
    ? Number(selectedVariant.price_euro ?? 0)
    : Number(product.price ?? 0);
  const stock = selectedVariant ? Number(selectedVariant.stock_quantity ?? selectedVariant.stock ?? 0) : 0;
  const canAddToCart = Boolean(selectedVariant?.id) && stock > 0;

  return (
    <div className="flex flex-col justify-center">
      <div className="flex items-center gap-3 mb-4">
        <p className="text-red-500 uppercase tracking-[5px] text-xs font-black">{product.brand}</p>
        <span className="w-1 h-1 rounded-full bg-white/20" />
        <p className="text-white/40 uppercase tracking-[3px] text-[10px] font-bold">{product.category_name}</p>
      </div>

      <div className="relative mb-6">
        {isPremium && (
          <span className="inline-block px-3 py-1 rounded-full bg-red-500/10 border border-red-500/20 text-red-500 text-[10px] font-black tracking-[3px] uppercase mb-4">
            Premium Selection
          </span>
        )}
        <h1 className="text-4xl md:text-6xl font-black leading-[1.1] tracking-tight">{product.product_name}</h1>
      </div>

      <div className="flex items-center gap-6 mb-10">
        <span className={`text-4xl md:text-5xl font-black ${isPremium ? 'text-yellow-400' : 'text-white'}`}>€{Number(price).toFixed(2)}</span>
        <div className="flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10 backdrop-blur-md">
          <span className="text-yellow-400 text-lg">★</span>
          <span className="font-bold text-white/90">{product.rating || '5.0'}</span>
          <span className="text-white/30 text-xs font-medium tracking-wider uppercase ml-1">Rating</span>
        </div>
      </div>

      <p className="text-white/70 text-lg leading-relaxed mb-8">
        {product.description || 'Premium selection, crafted for the finest taste. Experience the luxury of pure quality.'}
      </p>

      {/* Variant Selector */}
      {variants.length > 0 && (
        <div className="mb-8">
          <h3 className="text-sm font-bold text-white/50 uppercase tracking-widest mb-4">Select Size</h3>
          <div className="flex flex-wrap gap-3">
            {variants.map((v: ProductVariant) => (
              <button
                key={v.id}
                onClick={() => setSelectedVariant(v)}
                className={`px-6 py-3 rounded-2xl font-bold transition-all border ${selectedVariant?.id === v.id
                    ? 'bg-red-500 border-red-500 text-white shadow-[0_0_20px_rgba(255,0,0,0.4)]'
                    : 'bg-white/5 border-white/10 text-white/70 hover:bg-white/10 hover:border-white/30'
                  }`}
              >
                {v.size || v.variant_name}
              </button>
            ))}
          </div>
        </div>
      )}

      {variants.length === 0 && (
        <p className="text-amber-400 text-sm font-bold mb-4">
          No sizes available for this product yet. Please check back soon.
        </p>
      )}

      
      {stock > 0 && (
        <p className="text-green-400 text-sm font-bold mb-4">{stock} in stock</p>
      )}
      {stock === 0 && variants.length > 0 && (
        <p className="text-red-400 text-sm font-bold mb-4">Out of stock</p>
      )}

      <div className="flex flex-col sm:flex-row gap-4 mt-4">
        <div className="flex items-center justify-between border border-white/20 rounded-full px-6 py-4 w-full sm:w-40 bg-black/40">
          <button
            onClick={() => setQuantity(Math.max(1, quantity - 1))}
            className="text-white/50 hover:text-white text-xl font-bold transition"
          >
            -
          </button>
          <span className="font-bold text-lg">{quantity}</span>
          <button
            onClick={() => setQuantity(quantity + 1)}
            className="text-white/50 hover:text-white text-xl font-bold transition"
          >
            +
          </button>
        </div>

        <AddToCartButton
          variantId={canAddToCart ? selectedVariant?.id : undefined}
          quantity={quantity}
          price={price}
          showPrice={canAddToCart && price > 0}
          size="lg"
          className="flex-1"
          label={canAddToCart ? 'Add To Cart' : variants.length === 0 ? 'Unavailable' : 'Out of Stock'}
        />

        <button className="w-16 h-16 shrink-0 rounded-full border border-white/20 flex items-center justify-center hover:bg-white/10 transition-all hover:text-red-500">
          ♡
        </button>
      </div>

      <div className="mt-12 flex flex-col gap-4 text-sm text-white/50">
        <div className="flex items-center gap-3">
          <span className="text-green-500">✓</span> Free delivery in Amsterdam for orders over €100
        </div>
        <div className="flex items-center gap-3">
          <span className="text-green-500">✓</span> Premium secure packaging
        </div>
        <div className="flex items-center gap-3">
          <span className="text-green-500">✓</span> 100% authentic products
        </div>
      </div>
    </div>
  );
}
