import Link from 'next/link'
import type { ReactNode } from 'react'

type PolicySection = {
  title: string
  content: ReactNode
}

export default function PolicyLayout({
  title,
  subtitle,
  lastUpdated = 'March 2026',
  sections,
}: {
  title: string
  subtitle?: string
  lastUpdated?: string
  sections: PolicySection[]
}) {
  return (
    <div className="w-full pt-28 pb-24 px-6 min-h-screen">
      <div className="max-w-4xl mx-auto">
        <nav className="text-sm text-white/50 mb-10 flex flex-wrap gap-2 items-center">
          <Link href="/" className="hover:text-red-500 transition">
            Home
          </Link>
          <span>/</span>
          <span className="text-white/80">{title}</span>
        </nav>

        <header className="mb-12 rounded-[32px] border border-white/10 bg-gradient-to-br from-red-950/40 via-black/80 to-black p-8 md:p-12 relative overflow-hidden">
          <div className="absolute top-0 right-0 w-64 h-64 bg-red-500/10 blur-[80px] rounded-full pointer-events-none" />
          <p className="text-red-500 text-xs font-bold uppercase tracking-[4px] mb-3 relative">
            Legal
          </p>
          <h1 className="text-4xl md:text-5xl font-black mb-4 relative">{title}</h1>
          {subtitle && (
            <p className="text-white/60 text-lg max-w-2xl relative">{subtitle}</p>
          )}
          <p className="text-white/40 text-sm mt-6 relative">Last updated: {lastUpdated}</p>
        </header>

        <div className="space-y-6">
          {sections.map((section, index) => (
            <section
              key={section.title}
              className="rounded-2xl border border-white/10 bg-white/[0.03] p-6 md:p-8 hover:border-white/20 transition-colors"
            >
              <div className="flex gap-4 items-start">
                <span className="flex-shrink-0 w-10 h-10 rounded-full bg-red-500/15 border border-red-500/30 flex items-center justify-center text-red-400 font-black text-sm">
                  {index + 1}
                </span>
                <div className="flex-1 min-w-0">
                  <h2 className="text-xl font-bold text-white mb-3">{section.title}</h2>
                  <div className="text-white/65 leading-relaxed space-y-3 text-[15px]">
                    {section.content}
                  </div>
                </div>
              </div>
            </section>
          ))}
        </div>

        <footer className="mt-12 pt-8 border-t border-white/10 flex flex-wrap gap-6 text-sm text-white/50">
          <Link href="/privacy-policy" className="hover:text-red-500 transition">
            Privacy Policy
          </Link>
          <Link href="/terms-of-service" className="hover:text-red-500 transition">
            Terms of Service
          </Link>
          <Link href="/refund-policy" className="hover:text-red-500 transition">
            Refund Policy
          </Link>
          <Link href="/contact" className="hover:text-red-500 transition">
            Contact Us
          </Link>
        </footer>
      </div>
    </div>
  )
}
