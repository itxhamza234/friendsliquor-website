'use client'

import Link from 'next/link'
import { useCart } from '@/providers/CartProvider'

export default function CartPageClient() {
  const { cartItems, loading, updateQuantity, removeFromCart, cartTotal } = useCart()

  const shippingCost = cartTotal >= 100 ? 0 : 5.99
  const orderTotal = cartTotal + shippingCost

  if (loading) {
    return (
      <div className="w-full pb-24 pt-12">
        <div className="max-w-7xl mx-auto px-4 text-center text-white/50 py-24">
          Loading your cart...
        </div>
      </div>
    )
  }

  return (
    <div className="w-full pb-24 pt-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6">
        <h1 className="text-4xl sm:text-5xl font-black mb-8 sm:mb-12 text-white">
          Your <span className="text-red-500">Cart</span>
        </h1>

        {cartItems.length === 0 ? (
          <div className="text-center py-24 bg-white/5 border border-white/10 rounded-[30px]">
            <p className="text-white/60 text-lg mb-6">Your cart is empty.</p>
            <Link
              href="/shop"
              className="inline-block px-8 py-4 rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold text-white"
            >
              Start Shopping
            </Link>
          </div>
        ) : (
          <div className="flex flex-col lg:flex-row gap-8 lg:gap-12">
            {/* Cart Items */}
            <div className="flex-1 min-w-0">
              <div className="flex flex-col gap-4 sm:gap-6">
                {cartItems.map((item) => (
                  <div
                    key={item.id}
                    className="bg-white/5 border border-white/10 rounded-2xl sm:rounded-3xl p-4 sm:p-6 flex items-start gap-4 relative group backdrop-blur-md"
                  >
                    {/* Product Image */}
                    <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-xl overflow-hidden bg-black/50 flex items-center justify-center p-2 flex-shrink-0">
                      <img
                        src={
                          item.image_url ||
                          'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=800'
                        }
                        alt={item.product_name}
                        className="h-full w-auto object-contain"
                      />
                    </div>

                    {/* Product Info + Controls */}
                    <div className="flex-1 min-w-0 flex flex-col gap-3">
                      <div className="min-w-0">
                        <p className="text-red-500 text-xs font-bold uppercase tracking-wider mb-1">
                          {item.category_name || 'Luxury Selection'}
                        </p>
                        <Link
                          href={`/product/${item.product_slug}`}
                          className="text-white text-base sm:text-lg font-bold hover:text-red-500 transition break-words leading-snug block pr-6"
                        >
                          {item.brand ? `${item.brand} ` : ''}
                          {item.product_name}
                        </Link>
                        <p className="text-white/50 text-sm mt-1">{item.size}</p>
                        <p className="text-yellow-400 font-bold mt-1">
                          €{item.price.toFixed(2)}
                        </p>
                      </div>

                      {/* Quantity + Line Total */}
                      <div className="flex items-center justify-between gap-3 flex-wrap pt-1">
                        <div className="flex items-center justify-between border border-white/20 rounded-full px-3 py-1.5 w-24 sm:w-28 bg-black/40 flex-shrink-0">
                          <button
                            type="button"
                            onClick={() =>
                              updateQuantity(item.product_variant_id, item.quantity - 1)
                            }
                            className="text-white/50 hover:text-white font-bold transition px-1"
                          >
                            -
                          </button>
                          <span className="font-bold text-sm text-white">{item.quantity}</span>
                          <button
                            type="button"
                            onClick={() =>
                              updateQuantity(item.product_variant_id, item.quantity + 1)
                            }
                            className="text-white/50 hover:text-white font-bold transition px-1"
                          >
                            +
                          </button>
                        </div>

                        <div className="text-lg font-black text-white ml-auto">
                          €{item.lineTotal.toFixed(2)}
                        </div>
                      </div>
                    </div>

                    {/* Remove Button */}
                    <button
                      type="button"
                      onClick={() => removeFromCart(item.product_variant_id)}
                      className="absolute top-3 right-3 sm:-top-3 sm:-right-3 w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-red-500 hover:bg-red-600 flex items-center justify-center font-bold text-white text-xs sm:text-sm shadow-lg opacity-100 sm:opacity-0 sm:group-hover:opacity-100 transition-opacity z-10"
                      aria-label="Remove item"
                    >
                      ✕
                    </button>
                  </div>
                ))}
              </div>
            </div>

            {/* Order Summary */}
            <div className="w-full lg:w-[400px] flex-shrink-0">
              <div className="bg-white/5 border border-white/10 rounded-[24px] sm:rounded-[30px] p-6 sm:p-8 lg:sticky lg:top-[100px] backdrop-blur-md">
                <h3 className="text-2xl font-black mb-6 border-b border-white/10 pb-6 text-white">
                  Order Summary
                </h3>

                <div className="flex flex-col gap-4 text-white/70 mb-8">
                  <div className="flex justify-between items-center">
                    <span>Subtotal</span>
                    <span className="text-white font-bold">€{cartTotal.toFixed(2)}</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span>Shipping</span>
                    {shippingCost === 0 ? (
                      <span className="text-green-400 font-bold">Free</span>
                    ) : (
                      <span className="text-white font-bold">€{shippingCost.toFixed(2)}</span>
                    )}
                  </div>
                  {shippingCost > 0 && (
                    <p className="text-xs text-white/40">
                      Free shipping on orders over €100
                    </p>
                  )}
                </div>

                <div className="flex justify-between items-center border-t border-white/10 pt-6 mb-8">
                  <span className="text-lg text-white font-bold">Total</span>
                  <span className="text-3xl sm:text-4xl text-yellow-400 font-black">
                    €{orderTotal.toFixed(2)}
                  </span>
                </div>

                <div className="flex flex-col gap-3">
                  <Link
                    href="/checkout"
                    className="w-full block text-center py-4 sm:py-5 rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold text-white text-lg shadow-[0_0_40px_rgba(255,0,0,0.4)]"
                  >
                    Proceed to Checkout
                  </Link>
                  <Link
                    href="/shop"
                    className="w-full block text-center py-4 sm:py-5 rounded-full border border-white/20 bg-transparent hover:bg-white/5 transition-all text-white font-bold text-lg"
                  >
                    Continue Shopping
                  </Link>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}