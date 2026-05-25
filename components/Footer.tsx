import Link from 'next/link'

type FooterCategory = { name: string; slug: string }

export default function Footer({
  categories,
}: {
  categories: FooterCategory[]
}) {
  return (
    <footer className="border-t border-white/10 py-16 px-6 bg-black/80 backdrop-blur-xl relative z-10">
      <div className="max-w-7xl mx-auto grid md:grid-cols-3 gap-12">
        <div>
          <h4 className="text-3xl font-black mb-5">
            Friend&apos;s <span className="text-red-500">Liquor</span>
          </h4>
          <p className="text-white/60 leading-relaxed">
            Premium luxury alcohol delivery in Amsterdam. Curating the world&apos;s
            finest spirits for your enjoyment.
          </p>
        </div>

        <div>
          <h5 className="font-bold text-xl mb-6 tracking-wide uppercase">
            Categories
          </h5>
          <div className="flex flex-col space-y-3 text-white/60">
            {categories.slice(0, 8).map((cat) => (
              <Link
                key={cat.slug}
                href={`/shop?category=${cat.slug}`} 
                className="hover:text-red-500 transition w-fit"
              >
                {cat.name}
              </Link>
            ))}
            <Link href="/shop" className="text-red-500 font-bold hover:underline w-fit">
              View All Categories
            </Link>
          </div>
        </div>

        <div>
          <h5 className="font-bold text-xl mb-6 tracking-wide uppercase">
            Locations
          </h5>
          <div className="space-y-4 text-white/60">
            <div>
              <p className="text-white font-semibold">Store 1</p>
              <p>Nieuwezijds Voorburgwal 86, Amsterdam</p>
            </div>
            <div>
              <p className="text-white font-semibold">Store 2</p>
              <p>Spuistraat 47A, Amsterdam</p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto mt-16 pt-8 border-t border-white/10 flex flex-col md:flex-row justify-between text-white/40 text-sm gap-4">
        <p>© 2026 Friend&apos;s Liquor Store. All rights reserved.</p>
        <div className="flex flex-wrap gap-6">
          <Link href="/privacy-policy" className="hover:text-white transition">
            Privacy Policy
          </Link>
          <Link href="/terms-of-service" className="hover:text-white transition">
            Terms of Service
          </Link>
          <Link href="/refund-policy" className="hover:text-white transition">
            Refund Policy
          </Link>
        </div>
      </div>
    </footer>
  )
}
