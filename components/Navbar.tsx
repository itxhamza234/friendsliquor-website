'use client'

import { useState } from 'react'
import Link from 'next/link'
import { useAuth } from '@/providers/AuthProvider'
import { useCart } from '@/providers/CartProvider'

type NavCategory = { name: string; slug: string }
type NavPremium = { name: string; slug: string }

type NavbarProps = {
  categories: NavCategory[]
  premiumProducts: NavPremium[]
}

export default function Navbar({ categories, premiumProducts }: NavbarProps) {
  const { user, loading, displayName } = useAuth()
  const { cartCount } = useCart()
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)

  const firstName = displayName?.split(' ')[0] || 'User'

  return (
    <header className="sticky top-0 z-50 backdrop-blur-xl bg-black/60 border-b border-white/10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 py-4 flex items-center justify-between">
        <Link
          href="/"
          className="text-xl sm:text-2xl md:text-3xl font-black tracking-wide z-10 relative"
        >
          Friend&apos;s <span className="text-red-500">Liquor</span> Store
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden lg:flex gap-4 xl:gap-8 text-white/70 h-full items-center">
          <Link href="/" className="hover:text-red-500 transition h-full flex items-center text-sm">
            Home
          </Link>

          {/* Shop mega menu */}
          <div className="group h-full flex items-center">
            <Link href="/shop" className="hover:text-red-500 transition py-4 text-sm">
              Shop
            </Link>
            <div className="absolute top-full left-0 w-full bg-black/95 backdrop-blur-3xl border-b border-white/10 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300">
              <div className="max-w-7xl mx-auto px-6 py-12 grid grid-cols-2 gap-12">
                <div className="border-r border-white/10 pr-8">
                  <h4 className="text-lg font-bold text-white mb-6 uppercase tracking-wider">
                    Categories
                  </h4>
                  <div className="flex flex-col gap-3">
                    {categories.slice(0, 5).map((cat) => (
                      <Link
                        key={cat.slug}
                        href={`/shop?category=${cat.slug}`}
                        className="text-white/60 hover:text-red-500 transition"
                      >
                        {cat.name}
                      </Link>
                    ))}
                    <Link
                      href="/shop"
                      className="text-red-500 font-bold text-sm mt-2 hover:underline"
                    >
                      View All Categories →
                    </Link>
                  </div>
                </div>

                <div className="pl-4">
                  <h4 className="text-lg font-bold text-yellow-400 mb-6 uppercase tracking-wider">
                    Premium Drinks
                  </h4>
                  <div className="flex flex-col gap-3">
                    {premiumProducts.map((p) => (
                      <Link
                        key={p.slug}
                        href={`/product/${p.slug}`}
                        className="text-white/60 hover:text-yellow-400 transition line-clamp-1"
                      >
                        {p.name}
                      </Link>
                    ))}
                    <Link
                      href="/premium-drinks"
                      className="text-yellow-400 font-bold text-sm mt-4 pt-3 border-t border-white/10 hover:underline"
                    >
                      View All Premium Drinks
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="group h-full flex items-center">
            <Link
              href="/premium-drinks"
              className="text-yellow-400 font-bold tracking-widest uppercase text-xs sm:text-sm hover:text-white transition py-4"
            >
              Premium Drinks
            </Link>
            <div className="absolute top-full left-1/2 -translate-x-1/2 min-w-[280px] bg-black/95 backdrop-blur-3xl border border-white/10 rounded-b-2xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 shadow-xl">
              <div className="p-6 flex flex-col gap-3">
                {premiumProducts.map((p) => (
                  <Link
                    key={p.slug}
                    href={`/product/${p.slug}`}
                    className="text-white/70 hover:text-yellow-400 transition text-sm"
                  >
                    {p.name}
                  </Link>
                ))}
                <Link
                  href="/premium-drinks"
                  className="text-yellow-400 font-bold text-sm mt-2 pt-3 border-t border-white/10"
                >
                  View All Premium Drinks
                </Link>
              </div>
            </div>
          </div>

          <Link href="/contact" className="hover:text-red-500 transition text-sm">
            Contact
          </Link>
        </nav>

        <div className="flex gap-2 sm:gap-3 md:gap-4 items-center z-10 relative">
          {/* Mobile Menu Button */}
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="lg:hidden p-2 text-white/70 hover:text-white transition"
          >
            <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              {mobileMenuOpen ? (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              ) : (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </button>

          {!loading && user ? (
            <div className="hidden sm:flex items-center gap-3">
              <Link href="/profile" className="text-white/80 text-sm hover:text-white">
                Hi, <span className="font-bold text-white">{firstName}</span>
              </Link>
              <form action="/auth/signout" method="post">
                <button type="submit" className="text-white/60 hover:text-white transition text-sm">
                  Log out
                </button>
              </form>
            </div>
          ) : (
            !loading && (
              <Link
                href="/auth"
                className="hidden sm:block text-white/80 hover:text-white transition text-sm font-medium"
              >
                Log in
              </Link>
            )
          )}

          <Link
            href="/cart"
            className="px-3 sm:px-4 py-2 rounded-full border border-white/20 bg-white/5 hover:bg-red-500 transition-all flex items-center gap-2"
          >
            <span className="hidden sm:inline text-sm">Cart</span>
            <span className="relative inline-flex">
              <span aria-hidden className="text-lg">🛒</span>
              {cartCount > 0 && (
                <span className="absolute -top-2 -right-3 bg-red-500 text-white text-[10px] font-bold min-w-[18px] h-[18px] rounded-full flex items-center justify-center px-1">
                  {cartCount > 99 ? '99+' : cartCount}
                </span>
              )}
            </span>
          </Link>
          <Link
            href="/checkout"
            className="hidden sm:inline-block px-3 sm:px-4 py-2 rounded-full bg-red-500 hover:bg-red-600 transition-all shadow-[0_0_30px_rgba(255,0,0,0.5)] text-xs sm:text-sm font-bold"
          >
            Checkout
          </Link>
        </div>
      </div>

      {/* Mobile Menu */}
      {mobileMenuOpen && (
        <div className="lg:hidden bg-black/95 backdrop-blur-xl border-b border-white/10 max-h-[80vh] overflow-y-auto">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 py-6 flex flex-col gap-4">
            <Link
              href="/"
              onClick={() => setMobileMenuOpen(false)}
              className="text-white/70 hover:text-red-500 transition py-2 text-lg"
            >
              Home
            </Link>
            <Link
              href="/shop"
              onClick={() => setMobileMenuOpen(false)}
              className="text-white/70 hover:text-red-500 transition py-2 text-lg"
            >
              Shop
            </Link>

            {/* Categories — sirf 5 + View All */}
            <div className="border-t border-white/10 pt-4">
              <p className="text-white/40 text-xs uppercase tracking-widest mb-3">Categories</p>
              <div className="flex flex-col gap-2">
                {categories.slice(0, 5).map((cat) => (
                  <Link
                    key={cat.slug}
                    href={`/shop?category=${cat.slug}`}
                    onClick={() => setMobileMenuOpen(false)}
                    className="text-white/60 hover:text-red-500 transition py-1 text-base"
                  >
                    {cat.name}
                  </Link>
                ))}
                <Link
                  href="/shop"
                  onClick={() => setMobileMenuOpen(false)}
                  className="text-red-500 font-bold text-sm mt-1 hover:underline"
                >
                  View All Categories →
                </Link>
              </div>
            </div>

            <Link
              href="/premium-drinks"
              onClick={() => setMobileMenuOpen(false)}
              className="text-yellow-400 hover:text-yellow-300 transition py-2 text-lg font-bold"
            >
              Premium Drinks
            </Link>
            <Link
              href="/contact"
              onClick={() => setMobileMenuOpen(false)}
              className="text-white/70 hover:text-red-500 transition py-2 text-lg"
            >
              Contact
            </Link>

            <div className="border-t border-white/10 pt-4 mt-2">
              {!loading && user ? (
                <div className="flex flex-col gap-3">
                  <Link
                    href="/profile"
                    onClick={() => setMobileMenuOpen(false)}
                    className="text-white/80 hover:text-white transition py-2"
                  >
                    Profile
                  </Link>
                  <form action="/auth/signout" method="post">
                    <button
                      type="submit"
                      className="text-white/60 hover:text-white transition py-2 text-left w-full"
                    >
                      Log out
                    </button>
                  </form>
                </div>
              ) : (
                !loading && (
                  <Link
                    href="/auth"
                    onClick={() => setMobileMenuOpen(false)}
                    className="text-white/80 hover:text-white transition py-2 text-lg font-medium"
                  >
                    Log in
                  </Link>
                )
              )}
            </div>
          </div>
        </div>
      )}
    </header>
  )
}