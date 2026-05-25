'use client'

import { useState } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { useCart } from '@/providers/CartProvider'
import { useAuth } from '@/providers/AuthProvider'
import { CartLineItem } from '@/types/cart'
import { saveDelivery } from '@/lib/checkout/deliveryStorage'
import { useSavedDelivery } from '@/lib/checkout/useDeliveryStorage'
import type { DeliveryAddress } from '@/lib/api/orders'

export default function CheckoutPageClient() {
  const { cartItems, cartTotal, loading } = useCart()
  const { user } = useAuth()
  const router = useRouter()
  const saved = useSavedDelivery()

  const handleProceedToPayment = (delivery: DeliveryAddress) => {
    if (!user) {
      router.push('/auth')
      return
    }
    if (cartItems.length === 0) return
    saveDelivery(delivery)
    router.push('/checkout/payment')
  }

  if (loading) {
    return (
      <div className="w-full pb-24 pt-12 text-center text-white/50">
        Loading checkout...
      </div>
    )
  }

  if (cartItems.length === 0) {
    return (
      <div className="w-full pb-24 pt-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 text-center py-16 sm:py-24">
          <h1 className="text-3xl sm:text-4xl font-black mb-4">Your cart is empty</h1>
          <Link href="/shop" className="inline-block px-8 py-4 rounded-full bg-red-500 hover:bg-red-600 font-bold">
            Go to Shop
          </Link>
        </div>
      </div>
    )
  }

  const formKey = `${saved.firstName}|${saved.lastName}|${saved.address}|${saved.postalCode}`

  return (
    <div className="w-full pb-16 sm:pb-24 pt-8 sm:pt-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6">
        <div className="mb-8 sm:mb-12 border-b border-white/10 pb-4 sm:pb-6">
          <p className="text-white/50 text-xs sm:text-sm mb-2">Step 1 of 2</p>
          <h1 className="text-3xl sm:text-4xl font-black">
            Delivery <span className="text-red-500">Details</span>
          </h1>
        </div>
        <div className="flex flex-col lg:flex-row gap-8 lg:gap-12">
          <DeliveryForm key={formKey} initial={saved} onProceed={handleProceedToPayment} />
          <CheckoutSummary cartItems={cartItems} cartTotal={cartTotal} />
        </div>
      </div>
    </div>
  )
}

function DeliveryForm({
  initial,
  onProceed,
}: {
  initial: DeliveryAddress
  onProceed: (delivery: DeliveryAddress) => void
}) {
  const [firstName, setFirstName] = useState(initial.firstName)
  const [lastName, setLastName] = useState(initial.lastName)
  const [address, setAddress] = useState(initial.address)
  const [city, setCity] = useState(initial.city)
  const [postalCode, setPostalCode] = useState(initial.postalCode)
  const [phone, setPhone] = useState((initial as any).phone || '')
  const [error, setError] = useState<string | null>(null)

  const handleProceed = () => {
    if (!firstName.trim() || !lastName.trim() || !address.trim() || !postalCode.trim() || !phone.trim()) {
      setError('Please fill in all delivery fields including phone number.')
      return
    }
    setError(null)
    onProceed({
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      address: address.trim(),
      city: city.trim(),
      postalCode: postalCode.trim(),
      phone: phone.trim(),
    } as any)
  }

  const inputClass = "w-full bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white text-sm sm:text-base placeholder:text-white/20 transition"
  const labelClass = "text-xs font-bold text-white/50 uppercase tracking-wider"

  return (
    <div className="flex-1 space-y-6">
      <div className="bg-white/5 border border-white/10 rounded-2xl sm:rounded-3xl p-5 sm:p-8 backdrop-blur-md">
        <h3 className="font-bold text-base sm:text-lg mb-5 sm:mb-6 uppercase tracking-wider text-white/70">
          Delivery Address
        </h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6">

          {/* First Name */}
          <div className="flex flex-col gap-2">
            <label className={labelClass}>First Name</label>
            <input
              type="text"
              value={firstName}
              onChange={(e) => setFirstName(e.target.value)}
              className={inputClass}
            />
          </div>

          {/* Last Name */}
          <div className="flex flex-col gap-2">
            <label className={labelClass}>Last Name</label>
            <input
              type="text"
              value={lastName}
              onChange={(e) => setLastName(e.target.value)}
              className={inputClass}
            />
          </div>

          {/* Address */}
          <div className="col-span-1 sm:col-span-2 flex flex-col gap-2">
            <label className={labelClass}>Address</label>
            <input
              type="text"
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              placeholder="Street name and house number"
              className={inputClass}
            />
          </div>

          {/* City */}
          <div className="flex flex-col gap-2">
            <label className={labelClass}>City</label>
            <input
              type="text"
              value={city}
              onChange={(e) => setCity(e.target.value)}
              className={inputClass}
            />
          </div>

          {/* Postal Code */}
          <div className="flex flex-col gap-2">
            <label className={labelClass}>Postal Code</label>
            <input
              type="text"
              value={postalCode}
              onChange={(e) => setPostalCode(e.target.value)}
              className={inputClass}
            />
          </div>

          {/* Phone */}
          <div className="col-span-1 sm:col-span-2 flex flex-col gap-2">
            <label className={labelClass}>Phone Number</label>
            <input
              type="tel"
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
              placeholder="+31 6 12345678"
              className={inputClass}
            />
          </div>

        </div>
      </div>

      {error && (
        <p className="text-red-400 text-sm font-bold bg-red-500/10 border border-red-500/20 rounded-xl px-4 py-3">
          {error}
        </p>
      )}

      <button
        type="button"
        onClick={handleProceed}
        className="w-full py-4 sm:py-5 rounded-full bg-red-500 hover:bg-red-600 active:bg-red-700 font-bold text-lg sm:text-xl shadow-[0_0_50px_rgba(255,0,0,0.5)] transition-all"
      >
        Proceed to Payment →
      </button>
    </div>
  )
}

function CheckoutSummary({
  cartItems,
  cartTotal,
}: {
  cartItems: CartLineItem[]
  cartTotal: number
}) {
  return (
    <div className="w-full lg:w-[420px] xl:w-[450px] flex-shrink-0">
      <div className="bg-black/40 border border-white/10 rounded-2xl sm:rounded-[30px] p-5 sm:p-8 lg:sticky lg:top-[120px] backdrop-blur-md">
        <h3 className="text-xl sm:text-2xl font-black mb-4 sm:mb-6 border-b border-white/10 pb-4 sm:pb-6">
          Your Order
        </h3>
        <div className="flex flex-col gap-3 sm:gap-4 mb-6 sm:mb-8 max-h-[240px] sm:max-h-[320px] overflow-y-auto pr-1">
          {cartItems.map((item) => (
            <div key={item.id} className="flex gap-3 items-start text-sm">
              <span className="text-red-500 font-bold flex-shrink-0 pt-0.5">{item.quantity}×</span>
              <span className="flex-1 min-w-0 break-words text-white/80 leading-snug">
                {item.brand ? `${item.brand} ` : ''}
                {item.product_name}
              </span>
              <span className="text-yellow-400 font-bold flex-shrink-0 pl-2">
                €{item.lineTotal.toFixed(2)}
              </span>
            </div>
          ))}
        </div>
        <div className="flex justify-between items-center border-t border-white/10 pt-4 sm:pt-6">
          <span className="text-lg sm:text-xl font-bold">Total</span>
          <span className="text-2xl sm:text-3xl text-yellow-400 font-black">
            €{cartTotal.toFixed(2)}
          </span>
        </div>
      </div>
    </div>
  )
}