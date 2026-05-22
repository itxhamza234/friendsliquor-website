'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { useCart } from '@/providers/CartProvider'
import { useAuth } from '@/providers/AuthProvider'
import { useValidDelivery } from '@/lib/checkout/useDeliveryStorage'

export default function CheckoutPaymentClient() {
  const { cartItems, cartTotal, loading } = useCart()
  const { user } = useAuth()
  const router = useRouter()
  const delivery = useValidDelivery()

  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    if (!user) {
      router.replace('/auth')
      return
    }
    if (delivery === null) {
      router.replace('/checkout')
    }
  }, [user, delivery, router])

  // STRIPE CHECKOUT ROUTE INTEGRATION
  const handlePay = async () => {
    if (!user || !delivery) return
    if (cartItems.length === 0) {
      setError('Your cart is empty.')
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      // Backend api route ko hit karein jahan Stripe session create ho raha hai
      const res = await fetch('/api/checkout/place-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          firstName: delivery.firstName,
          lastName: delivery.lastName,
          email: user.email,
          address: delivery.address,
          city: delivery.city,
          postalCode: delivery.postalCode,
          items: cartItems,
        }),
      })

      const result = await res.json()
      if (!res.ok) throw new Error(result.error || 'Failed to initiate payment')

      // Agar Stripe Checkout URL mil jaye to wahan redirect kar dein
      if (result.success && result.url) {
        window.location.href = result.url
      } else {
        throw new Error('Stripe session URL not found.')
      }

    } catch (err) {
      setError(err instanceof Error ? err.message : 'Payment initiation failed. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  if (!user || delivery === null) {
    return (
      <div className="w-full pb-24 pt-12 text-center text-white/50">
        Redirecting...
      </div>
    )
  }

  if (loading) {
    return (
      <div className="w-full pb-24 pt-12 text-center text-white/50">
        Loading payment...
      </div>
    )
  }

  if (cartItems.length === 0) {
    return (
      <div className="w-full pb-24 pt-12 text-center">
        <p className="text-white/60 mb-6">No items to pay for.</p>
        <Link href="/shop" className="text-red-500 font-bold hover:underline">
          Continue shopping
        </Link>
      </div>
    )
  }

  return (
    <div className="w-full pb-24 pt-12">
      <div className="max-w-7xl mx-auto px-6">
        <div className="mb-12 border-b border-white/10 pb-6">
          <p className="text-white/50 text-sm mb-2">Step 2 of 2</p>
          <h1 className="text-4xl font-black">
            Payment <span className="text-red-500">Method</span>
          </h1>
          <p className="text-white/50 mt-2">
            Deliver to: {delivery.address}, {delivery.postalCode} {delivery.city}
          </p>
        </div>

        <div className="flex flex-col lg:flex-row gap-12">
          <div className="flex-1 space-y-6">
            <div className="bg-white/5 border border-white/10 rounded-3xl p-8 text-center py-12">
              <h3 className="font-bold mb-4 text-white/70 uppercase tracking-wider text-xl">
                Secure Stripe Checkout
              </h3>
              <p className="text-white/60 max-w-md mx-auto mb-6 text-sm">
                By clicking below, you will be redirected to Stripe officially secured sandbox checkout system to safely process your payment using IDEAL or Credit Card.
              </p>
              <div className="flex justify-center gap-4 text-white/40 text-sm">
                <span>🔒 SSL Encrypted</span>
                <span>•</span>
                <span>💳 Card / IDEAL</span>
              </div>
            </div>

            {error && (
              <p className="text-red-400 text-sm font-bold bg-red-500/10 border border-red-500/20 rounded-xl px-4 py-3">
                {error}
              </p>
            )}

            <button
              type="button"
              onClick={handlePay}
              disabled={submitting}
              className="w-full py-5 rounded-full bg-red-500 hover:bg-red-600 font-bold text-xl shadow-[0_0_50px_rgba(255,0,0,0.5)] disabled:opacity-60 transition-all"
            >
              {submitting ? 'Redirecting to Stripe...' : `Proceed to Payment €${cartTotal.toFixed(2)}`}
            </button>

            <Link href="/checkout" className="block text-center text-white/50 hover:text-white text-sm pt-2">
              ← Back to delivery details
            </Link>
          </div>

          <div className="w-full lg:w-[400px]">
            <div className="bg-black/40 border border-white/10 rounded-[30px] p-8 sticky top-[120px]">
              <h3 className="text-xl font-black mb-6">Order Summary</h3>
              {cartItems.map((item) => (
                <div key={item.id} className="flex justify-between text-sm mb-3 text-white/80">
                  <span className="line-clamp-1 flex-1 pr-2">
                    {item.quantity}× {item.product_name}
                  </span>
                  <span className="text-yellow-400">€{item.lineTotal.toFixed(2)}</span>
                </div>
              ))}
              <div className="border-t border-white/10 mt-6 pt-6 flex justify-between">
                <span className="font-bold">Total</span>
                <span className="text-2xl font-black text-yellow-400">
                  €{cartTotal.toFixed(2)}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}