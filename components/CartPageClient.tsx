'use client'

import Link from 'next/link'
import { useCart } from '@/providers/CartProvider'

export default function CartPageClient() {
  const { cartItems, loading, updateQuantity, removeFromCart, cartTotal } = useCart()

  if (loading) {
    return (
      <div className="w-full pb-24 pt-12">
        <div className="max-w-7xl mx-auto px-6 text-center text-white/50 py-24">
          Loading your cart...
        </div>
      </div>
    )
  }

  return (
    <div className="w-full pb-24 pt-12">
      <div className="max-w-7xl mx-auto px-6">
        <h1 className="text-5xl font-black mb-12">
          Your <span className="text-red-500">Cart</span>
        </h1>

        {cartItems.length === 0 ? (
          <div className="text-center py-24 bg-white/5 border border-white/10 rounded-[30px]">
            <p className="text-white/60 text-lg mb-6">Your cart is empty.</p>
            <Link
              href="/shop"
              className="inline-block px-8 py-4 rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold"
            >
              Start Shopping
            </Link>
          </div>
        ) : (
          <div className="flex flex-col lg:flex-row gap-12">
            <div className="flex-1">
              <div className="flex flex-col gap-6">
                {cartItems.map((item) => (
                  <div
                    key={item.id}
                    className="bg-white/5 border border-white/10 rounded-3xl p-6 flex items-center gap-6 relative group backdrop-blur-md"
                  >
                    <div className="w-24 h-24 rounded-xl overflow-hidden bg-black/50 flex items-center justify-center p-2 flex-shrink-0">
                      <img
                        src={
                          item.image_url ||
                          'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=800'
                        }
                        alt={item.product_name}
                        className="h-full w-auto object-contain"
                      />
                    </div>

                    <div className="flex-1 flex flex-col md:flex-row md:items-center justify-between gap-4">
                      <div>
                        <p className="text-red-500 text-xs font-bold uppercase tracking-wider mb-1">
                          {item.category_name || 'Luxury Selection'}
                        </p>
                        <Link
                          href={`/product/${item.product_slug}`}
                          className="text-xl font-bold line-clamp-1 hover:text-red-500 transition"
                        >
                          {item.brand ? `${item.brand} ` : ''}
                          {item.product_name}
                        </Link>
                        <p className="text-white/50 text-sm mt-1">{item.size}</p>
                        <p className="text-yellow-400 font-bold mt-1">
                          €{item.price.toFixed(2)}
                        </p>
                      </div>

                      <div className="flex items-center gap-6">
                        <div className="flex items-center justify-between border border-white/20 rounded-full px-4 py-2 w-32 bg-black/40">
                          <button
                            type="button"
                            onClick={() =>
                              updateQuantity(
                                item.product_variant_id,
                                item.quantity - 1
                              )
                            }
                            className="text-white/50 hover:text-white font-bold transition"
                          >
                            -
                          </button>
                          <span className="font-bold text-sm">{item.quantity}</span>
                          <button
                            type="button"
                            onClick={() =>
                              updateQuantity(
                                item.product_variant_id,
                                item.quantity + 1
                              )
                            }
                            className="text-white/50 hover:text-white font-bold transition"
                          >
                            +
                          </button>
                        </div>

                        <div className="text-xl font-black min-w-[100px] text-right">
                          €{item.lineTotal.toFixed(2)}
                        </div>
                      </div>
                    </div>

                    <button
                      type="button"
                      onClick={() => removeFromCart(item.product_variant_id)}
                      className="absolute -top-3 -right-3 w-8 h-8 rounded-full bg-red-500 hover:bg-red-600 flex items-center justify-center font-bold text-sm shadow-lg opacity-0 group-hover:opacity-100 transition-opacity"
                      aria-label="Remove item"
                    >
                      ✕
                    </button>
                  </div>
                ))}
              </div>
            </div>

            <div className="w-full lg:w-[400px] flex-shrink-0">
              <div className="bg-white/5 border border-white/10 rounded-[30px] p-8 sticky top-[100px] backdrop-blur-md">
                <h3 className="text-2xl font-black mb-6 border-b border-white/10 pb-6">
                  Order Summary
                </h3>

                <div className="flex flex-col gap-4 text-white/70 mb-8">
                  <div className="flex justify-between">
                    <span>Subtotal</span>
                    <span className="text-white font-bold">€{cartTotal.toFixed(2)}</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Shipping</span>
                    <span className="text-green-400 font-bold">Free</span>
                  </div>
                </div>

                <div className="flex justify-between items-end border-t border-white/10 pt-6 mb-8">
                  <span className="text-lg font-bold">Total</span>
                  <span className="text-4xl text-yellow-400 font-black">
                    €{cartTotal.toFixed(2)}
                  </span>
                </div>

                <Link
                  href="/checkout"
                  className="w-full block text-center py-5 rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold text-lg shadow-[0_0_40px_rgba(255,0,0,0.4)] mb-4"
                >
                  Proceed to Checkout
                </Link>
                <Link
                  href="/shop"
                  className="w-full block text-center py-5 rounded-full border border-white/20 bg-transparent hover:bg-white/5 transition-all font-bold text-lg"
                >
                  Continue Shopping
                </Link>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
