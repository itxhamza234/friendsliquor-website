'use client'

import { useState } from 'react'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('')
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [message, setMessage] = useState('')

  const handleReset = async (e: React.FormEvent) => {
    e.preventDefault()
    setStatus('loading')

    const supabase = createClient()

    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/auth/callback?next=/profile/update-password`,
    })

    if (error) {
      setStatus('error')
      setMessage(error.message)
    } else {
      setStatus('success')
      setMessage('Password reset link has been sent to your email.')
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center px-6 pt-20">
      <div className="w-full max-w-md bg-white/5 border border-white/10 p-10 rounded-[40px] backdrop-blur-xl shadow-[0_0_50px_rgba(0,0,0,0.5)]">
        <h2 className="text-4xl font-black mb-2 text-center">Reset <span className="text-red-500">Password</span></h2>
        <p className="text-center text-white/50 mb-8">Enter your email to receive a reset link</p>

        {status === 'success' ? (
          <div className="text-center">
            <div className="w-16 h-16 rounded-full bg-green-500/20 border border-green-500 flex items-center justify-center mx-auto mb-6 text-2xl text-green-500">✓</div>
            <p className="text-white/80 mb-8">{message}</p>
            <Link href="/login" className="block w-full py-4 rounded-full bg-white/10 hover:bg-white/20 transition-all font-bold text-center">
              Return to Login
            </Link>
          </div>
        ) : (
          <form onSubmit={handleReset} className="space-y-6">
            <div>
              <label className="block text-sm font-bold text-white/70 mb-2">Email Address</label>
              <input
                type="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full bg-black/50 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-red-500 transition-colors"
                placeholder="Enter your email"
              />
            </div>

            {status === 'error' && (
              <div className="p-4 rounded-2xl bg-red-500/10 border border-red-500/50 text-red-500 text-sm">
                {message}
              </div>
            )}

            <button 
              type="submit" 
              disabled={status === 'loading'}
              className="w-full py-4 rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold text-lg shadow-[0_0_30px_rgba(255,0,0,0.3)] disabled:opacity-50"
            >
              {status === 'loading' ? 'Sending...' : 'Send Reset Link'}
            </button>
            
            <p className="text-center text-white/50 pt-4">
              Remember your password? <Link href="/login" className="text-white font-bold hover:text-red-500 transition">Log in</Link>
            </p>
          </form>
        )}
      </div>
    </div>
  )
}
