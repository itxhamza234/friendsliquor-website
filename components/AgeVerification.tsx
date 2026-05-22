'use client'

import { useEffect, useState } from 'react'

export default function AgeVerification() {
  const [visible, setVisible] = useState(false)
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
    setVisible(true)
    document.body.style.overflow = 'hidden'
  }, [])

  const close = () => {
    setVisible(false)
    document.body.style.overflow = ''
  }

  const handleEnter = () => {
    close()
  }

  const handleExit = () => {
    window.location.href = 'https://www.google.com'
  }

  if (!mounted || !visible) return null

  return (
    <div
      className="fixed inset-0 z-[200] flex items-center justify-center p-4 bg-black/95 backdrop-blur-xl"
      role="dialog"
      aria-modal="true"
      aria-labelledby="age-verify-title"
    >
      {/* Background Effects */}
      <div className="absolute inset-0">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-red-500/20 rounded-full blur-[120px]" />
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-yellow-500/10 rounded-full blur-[120px]" />
      </div>

      <div className="relative w-full max-w-2xl rounded-[40px] border border-white/10 bg-white/5 backdrop-blur-2xl overflow-hidden shadow-[0_0_80px_rgba(255,0,0,0.4)]">
        
        <div className="relative h-64 bg-gradient-to-br from-red-900/50 to-black overflow-hidden flex items-center justify-center">
          <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent" />

          <div className="relative z-10 text-center">
            <h1 className="text-5xl font-black text-white mb-2">
              AGE VERIFICATION
            </h1>

            <p className="text-white/60 text-lg">
              Friends Liquor Store
            </p>
          </div>
        </div>

        <div className="p-12 text-center">
          <div className="mb-8">
            <div className="text-6xl mb-4">🔞</div>

            <h2
              id="age-verify-title"
              className="text-3xl font-bold text-white mb-4"
            >
              Are you 18 years or older?
            </h2>

            <p className="text-white/60 text-lg max-w-md mx-auto">
              You must be of legal drinking age to enter this site.
              Please verify your age before proceeding.
            </p>
          </div>

          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <button
              type="button"
              onClick={handleEnter}
              className="px-12 py-4 rounded-full bg-gradient-to-r from-red-600 to-red-500 hover:from-red-500 hover:to-red-400 text-white font-bold text-lg shadow-[0_0_30px_rgba(255,0,0,0.4)] transition-all"
            >
              Yes, I am 18+
            </button>

            <button
              type="button"
              onClick={handleExit}
              className="px-12 py-4 rounded-full bg-white/10 border border-white/20 hover:bg-white/20 text-white font-bold text-lg transition-all"
            >
              No, I am under 18
            </button>
          </div>

          <p className="text-white/30 text-xs mt-8">
            By entering this site, you agree to our Terms of Service and Privacy Policy.
          </p>

          <p className="text-white/20 text-[10px] mt-2 uppercase tracking-widest">
            Drink responsibly
          </p>
        </div>
      </div>
    </div>
  )
}