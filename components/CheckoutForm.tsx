'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/providers/AuthProvider';
import { useCart } from '@/providers/CartProvider';
import Link from 'next/link';

export default function CheckoutForm() {
  const router = useRouter();
  const { user } = useAuth();
  const { cartItems, cartTotal } = useCart();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [address, setAddress] = useState('');
  const [city, setCity] = useState('Amsterdam');
  const [postalCode, setPostalCode] = useState('');

  const handlePlaceOrder = async () => {
    if (!user) {
      router.push('/auth');
      return;
    }

    if (cartItems.length === 0) {
      setError('Your cart is empty.');
      return;
    }

    setLoading(true);
    setError('');

    try {
      const res = await fetch('/api/checkout/place-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          firstName,
          lastName,
          email: email || user.email,
          address,
          city,
          postalCode,
          items: cartItems,
        }),
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.error || 'Order failed');

      router.push('/profile?order=success');
      router.refresh();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Order failed');
    } finally {
      setLoading(false);
    }
  };

  if (!user) {
    return (
      <div className="text-center py-12 bg-white/5 rounded-3xl border border-white/10">
        <p className="text-white/70 mb-4">Please log in to complete your order.</p>
        <Link
          href="/auth"
          className="inline-block px-8 py-3 rounded-full bg-red-500 hover:bg-red-600 font-bold"
        >
          Log in
        </Link>
      </div>
    );
  }

  return (
    <>
      {error && (
        <div className="mb-6 p-4 bg-red-500/10 border border-red-500/30 text-red-400 rounded-xl">
          {error}
        </div>
      )}

      <div className="bg-white/5 border border-white/10 rounded-3xl p-8 backdrop-blur-md">
        <h3 className="font-bold text-lg mb-6 uppercase tracking-wider text-white/70">
          Delivery Address
        </h3>
        <div className="grid sm:grid-cols-2 gap-6">
          <div className="col-span-2 sm:col-span-1 flex flex-col gap-2">
            <label className="text-xs font-bold text-white/50 uppercase">First Name *</label>
            <input
              type="text"
              value={firstName}
              onChange={(e) => setFirstName(e.target.value)}
              required
              className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white"
            />
          </div>
          <div className="col-span-2 sm:col-span-1 flex flex-col gap-2">
            <label className="text-xs font-bold text-white/50 uppercase">Last Name *</label>
            <input
              type="text"
              value={lastName}
              onChange={(e) => setLastName(e.target.value)}
              required
              className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white"
            />
          </div>
          <div className="col-span-2 flex flex-col gap-2">
            <label className="text-xs font-bold text-white/50 uppercase">Email</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder={user.email || ''}
              className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white"
            />
          </div>
          <div className="col-span-2 flex flex-col gap-2">
            <label className="text-xs font-bold text-white/50 uppercase">Address *</label>
            <input
              type="text"
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              required
              className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white"
            />
          </div>
          <div className="col-span-2 sm:col-span-1 flex flex-col gap-2">
            <label className="text-xs font-bold text-white/50 uppercase">City</label>
            <input
              type="text"
              value={city}
              onChange={(e) => setCity(e.target.value)}
              className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white"
            />
          </div>
          <div className="col-span-2 sm:col-span-1 flex flex-col gap-2">
            <label className="text-xs font-bold text-white/50 uppercase">Postal Code</label>
            <input
              type="text"
              value={postalCode}
              onChange={(e) => setPostalCode(e.target.value)}
              className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 text-white"
            />
          </div>
        </div>
      </div>

      <button
        type="button"
        onClick={handlePlaceOrder}
        disabled={loading}
        className="w-full py-5 rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold text-xl shadow-[0_0_50px_rgba(255,0,0,0.5)] flex items-center justify-center gap-3 disabled:opacity-50 mt-8"
      >
        {loading ? 'Placing order…' : `Place order €${cartTotal.toFixed(2)}`}
        {!loading && <span>→</span>}
      </button>
      <p className="text-center text-white/40 text-sm mt-4">
        Order will appear in the admin dashboard within 30 seconds.
      </p>
    </>
  );
}
