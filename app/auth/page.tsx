'use client'

import { useState } from 'react'
import { motion, AnimatePresence, Variants } from 'framer-motion'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { ensureUserProfile } from '@/lib/auth/ensureUserProfile'
import { useAuth } from '@/providers/AuthProvider'

export default function AuthPage() {
  const [isLogin, setIsLogin] = useState(true)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState<string | null>(null)
  
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [fullName, setFullName] = useState('')

  const router = useRouter()
  const supabase = createClient()
  const { refreshProfile } = useAuth()

  const handleAuth = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError(null)
    setSuccess(null)

    if (isLogin) {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      })
      if (error) {
        setError(error.message)
        setLoading(false)
        return
      }

      if (data.user) {
        await ensureUserProfile(supabase, data.user, data.user.user_metadata?.full_name as string)
        await refreshProfile()
      }

      router.push('/')
      router.refresh()
      setLoading(false)
    } else {
      if (password.length < 6) {
        setError('Password must be at least 6 characters long')
        setLoading(false)
        return
      }

      const { data: existingUser } = await supabase
        .from('users')
        .select('email')
        .eq('email', email)
        .single()

      if (existingUser) {
        setError('An account with this email already exists')
        setLoading(false)
        return
      }

      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: { full_name: fullName },
        },
      })

      if (error) {
        setError(error.message)
        setLoading(false)
        return
      }

      if (data.user) {
        await ensureUserProfile(supabase, data.user, fullName)
      }

      if (data.session) {
        await supabase.auth.signOut()
      }

      setPassword('')
      setFullName('')
      setIsLogin(true)
      setSuccess('Account created! Your details are saved. Please sign in below.')
      setLoading(false)
    }
  }

  const formVariants: Variants = {
    hidden: { opacity: 0, y: 20 },
    visible: { opacity: 1, y: 0, transition: { duration: 0.4, ease: 'easeOut' } },
    exit: { opacity: 0, y: -20, transition: { duration: 0.3 } },
  }

  return (
    <div className="min-h-screen bg-black flex items-center justify-center p-4 sm:p-6 relative overflow-hidden">
      {/* Background */}
      <div className="absolute inset-0 z-0">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-red-500/20 rounded-full blur-[120px]" />
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-yellow-500/10 rounded-full blur-[120px]" />
      </div>

      <div className="relative z-10 w-full max-w-md md:max-w-4xl">
        
        {/* ─── MOBILE LAYOUT ─── */}
        <div className="md:hidden bg-white/5 border border-white/10 rounded-[30px] backdrop-blur-2xl overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.8)] p-8">
          <AnimatePresence mode="wait">
            {isLogin ? (
              <motion.div
                key="mobile-login"
                variants={formVariants}
                initial="hidden"
                animate="visible"
                exit="exit"
              >
                <h2 className="text-4xl font-black mb-2">
                  Sign <span className="text-red-500">In</span>
                </h2>
                <p className="text-white/50 mb-8">Enter your credentials to access your account.</p>

                <form onSubmit={handleAuth} className="space-y-5" noValidate>
                  <input
                    type="email"
                    placeholder="Email Address"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    autoComplete="off"
                    className="w-full bg-black/40 border border-white/10 rounded-2xl px-5 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                  />
                  <input
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    autoComplete="new-password"
                    className="w-full bg-black/40 border border-white/10 rounded-2xl px-5 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                  />

                  <div className="flex justify-end">
                    <Link href="/forgot-password" className="text-sm text-white/50 hover:text-red-500 transition-colors">
                      Forgot Password?
                    </Link>
                  </div>

                  {success && (
                    <p className="text-green-400 text-sm text-center bg-green-500/10 p-3 rounded-lg border border-green-500/20">
                      {success}
                    </p>
                  )}
                  {error && (
                    <p className="text-red-500 text-sm text-center bg-red-500/10 p-3 rounded-lg border border-red-500/20">
                      {error}
                    </p>
                  )}

                  <button
                    type="submit"
                    disabled={loading}
                    className="w-full py-4 rounded-full bg-gradient-to-r from-red-600 to-red-500 hover:from-red-500 hover:to-red-400 font-bold shadow-[0_0_30px_rgba(255,0,0,0.4)] transition-all disabled:opacity-50"
                  >
                    {loading ? 'Authenticating...' : 'Sign In'}
                  </button>
                </form>

                <p className="text-center mt-8 text-white/50">
                  Don&apos;t have an account?{' '}
                  <button
                    onClick={() => { setIsLogin(false); setSuccess(null); setError(null) }}
                    className="text-red-500 font-bold hover:underline"
                  >
                    Sign Up
                  </button>
                </p>
              </motion.div>
            ) : (
              <motion.div
                key="mobile-signup"
                variants={formVariants}
                initial="hidden"
                animate="visible"
                exit="exit"
              >
                <h2 className="text-4xl font-black mb-2">
                  Create <span className="text-red-500">Account</span>
                </h2>
                <p className="text-white/50 mb-8">Join our exclusive liquor reserve.</p>

                <form onSubmit={handleAuth} className="space-y-5" noValidate>
                  <input
                    type="text"
                    placeholder="Full Name"
                    value={fullName}
                    onChange={(e) => setFullName(e.target.value)}
                    required
                    autoComplete="off"
                    className="w-full bg-black/40 border border-white/10 rounded-2xl px-5 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                  />
                  <input
                    type="email"
                    placeholder="Email Address"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    autoComplete="off"
                    className="w-full bg-black/40 border border-white/10 rounded-2xl px-5 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                  />
                  <input
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    autoComplete="new-password"
                    className="w-full bg-black/40 border border-white/10 rounded-2xl px-5 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                  />

                  {error && (
                    <p className="text-red-500 text-sm text-center bg-red-500/10 p-3 rounded-lg border border-red-500/20">
                      {error}
                    </p>
                  )}

                  <button
                    type="submit"
                    disabled={loading}
                    className="w-full py-4 rounded-full bg-gradient-to-r from-red-600 to-red-500 hover:from-red-500 hover:to-red-400 font-bold shadow-[0_0_30px_rgba(255,0,0,0.4)] transition-all disabled:opacity-50"
                  >
                    {loading ? 'Creating Account...' : 'Sign Up'}
                  </button>
                  <p className="text-white/40 text-xs text-center">
                    After signup you will be asked to sign in on this page.
                  </p>
                </form>

                <p className="text-center mt-8 text-white/50">
                  Already have an account?{' '}
                  <button
                    onClick={() => { setIsLogin(true); setError(null) }}
                    className="text-red-500 font-bold hover:underline"
                  >
                    Sign In
                  </button>
                </p>
              </motion.div>
            )}
          </AnimatePresence>
        </div>

        {/* ─── DESKTOP LAYOUT ─── */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.8 }}
          className="hidden md:flex min-h-[600px] bg-white/5 border border-white/10 rounded-[40px] backdrop-blur-2xl overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.8)]"
        >
          {/* Sliding Overlay Panel */}
          <motion.div
            initial={false}
            animate={{
              x: isLogin ? '100%' : '0%',
              borderTopLeftRadius: isLogin ? '0px' : '40px',
              borderBottomLeftRadius: isLogin ? '0px' : '40px',
              borderTopRightRadius: isLogin ? '40px' : '0px',
              borderBottomRightRadius: isLogin ? '40px' : '0px',
            }}
            transition={{ type: 'spring', stiffness: 80, damping: 20 }}
            className="absolute top-0 left-0 w-1/2 h-full z-20 flex flex-col items-center justify-center p-12 text-center bg-gradient-to-br from-black via-[#1a0505] to-red-950 border-r border-white/10"
          >
            <AnimatePresence mode="wait">
              <motion.div
                key={isLogin ? 'login-overlay' : 'signup-overlay'}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -20 }}
                transition={{ duration: 0.4 }}
              >
                <h2 className="text-4xl font-black mb-6">
                  {isLogin ? 'New Here?' : 'Welcome Back!'}
                </h2>
                <p className="text-white/60 mb-8 text-lg">
                  {isLogin
                    ? 'Join our exclusive reserve to access premium liquor, priority delivery, and VIP events.'
                    : 'To keep connected with us please login with your personal info.'}
                </p>
                <button
                  onClick={() => { setIsLogin(!isLogin); setError(null); setSuccess(null) }}
                  className="px-10 py-4 rounded-full border-2 border-red-500 text-white font-bold hover:bg-red-500/10 transition-colors shadow-[0_0_30px_rgba(255,0,0,0.2)]"
                >
                  {isLogin ? 'Sign Up' : 'Sign In'}
                </button>
              </motion.div>
            </AnimatePresence>
          </motion.div>

          {/* Login Form */}
          <div className="w-1/2 p-16 flex flex-col justify-center relative z-10">
            <AnimatePresence mode="wait">
              {isLogin && (
                <motion.div
                  key="desktop-login"
                  variants={formVariants}
                  initial="hidden"
                  animate="visible"
                  exit="exit"
                  className="w-full max-w-sm mx-auto"
                >
                  <h2 className="text-4xl font-black mb-2">Sign <span className="text-red-500">In</span></h2>
                  <p className="text-white/50 mb-10">Enter your credentials to access your account.</p>

                  <form onSubmit={handleAuth} className="space-y-6" noValidate>
                    <input
                      type="email"
                      placeholder="Email Address"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                      autoComplete="off"
                      className="w-full bg-black/40 border border-white/10 rounded-2xl px-6 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                    />
                    <input
                      type="password"
                      placeholder="Password"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      autoComplete="new-password"
                      className="w-full bg-black/40 border border-white/10 rounded-2xl px-6 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                    />
                    <div className="flex justify-end">
                      <Link href="/forgot-password" className="text-sm text-white/50 hover:text-red-500 transition-colors">
                        Forgot Password?
                      </Link>
                    </div>

                    {success && (
                      <p className="text-green-400 text-sm text-center bg-green-500/10 p-3 rounded-lg border border-green-500/20">
                        {success}
                      </p>
                    )}
                    {error && (
                      <p className="text-red-500 text-sm text-center bg-red-500/10 p-3 rounded-lg border border-red-500/20">
                        {error}
                      </p>
                    )}

                    <button
                      type="submit"
                      disabled={loading}
                      className="w-full py-4 rounded-full bg-gradient-to-r from-red-600 to-red-500 hover:from-red-500 hover:to-red-400 font-bold shadow-[0_0_30px_rgba(255,0,0,0.4)] transition-all disabled:opacity-50"
                    >
                      {loading ? 'Authenticating...' : 'Sign In'}
                    </button>
                  </form>
                </motion.div>
              )}
            </AnimatePresence>
          </div>

          {/* Signup Form */}
          <div className="w-1/2 p-16 flex flex-col justify-center relative z-10">
            <AnimatePresence mode="wait">
              {!isLogin && (
                <motion.div
                  key="desktop-signup"
                  variants={formVariants}
                  initial="hidden"
                  animate="visible"
                  exit="exit"
                  className="w-full max-w-sm mx-auto"
                >
                  <h2 className="text-4xl font-black mb-2">Create <span className="text-red-500">Account</span></h2>
                  <p className="text-white/50 mb-10">Join our exclusive liquor reserve.</p>

                  <form onSubmit={handleAuth} className="space-y-6" noValidate>
                    <input
                      type="text"
                      placeholder="Full Name"
                      value={fullName}
                      onChange={(e) => setFullName(e.target.value)}
                      required
                      autoComplete="off"
                      className="w-full bg-black/40 border border-white/10 rounded-2xl px-6 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                    />
                    <input
                      type="email"
                      placeholder="Email Address"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                      autoComplete="off"
                      className="w-full bg-black/40 border border-white/10 rounded-2xl px-6 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                    />
                    <input
                      type="password"
                      placeholder="Password"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      autoComplete="new-password"
                      className="w-full bg-black/40 border border-white/10 rounded-2xl px-6 py-4 text-white placeholder:text-white/30 focus:outline-none focus:border-red-500 transition-colors"
                    />

                    {error && (
                      <p className="text-red-500 text-sm text-center bg-red-500/10 p-3 rounded-lg border border-red-500/20">
                        {error}
                      </p>
                    )}

                    <button
                      type="submit"
                      disabled={loading}
                      className="w-full py-4 rounded-full bg-gradient-to-r from-red-600 to-red-500 hover:from-red-500 hover:to-red-400 font-bold shadow-[0_0_30px_rgba(255,0,0,0.4)] transition-all disabled:opacity-50"
                    >
                      {loading ? 'Creating Account...' : 'Sign Up'}
                    </button>
                    <p className="text-white/40 text-xs text-center">
                      After signup you will be asked to sign in on this page.
                    </p>
                  </form>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        </motion.div>
      </div>
    </div>
  )
}