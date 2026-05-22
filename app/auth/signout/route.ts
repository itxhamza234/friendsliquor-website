import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

export async function POST(request: Request) {
  const supabase = await createClient()

  // Check if we have a session
  const {
    data: { session },
  } = await supabase.auth.getSession()

  if (session) {
    // Clear cart from database before signing out
    const { error: cartError } = await supabase
      .from('cart')
      .delete()
      .eq('user_id', session.user.id)

    if (cartError) {
      console.error('Error clearing cart on logout:', cartError)
    }

    // Sign out
    const { error: signOutError } = await supabase.auth.signOut()

    if (signOutError) {
      console.error('Error signing out:', signOutError)
    }
  }

  // Create response and set cookie to clear localStorage
  const response = NextResponse.redirect(new URL('/', request.url), {
    status: 302,
  })

  // Set cookie to signal client to clear localStorage cart
  response.cookies.set('clear-cart', 'true', {
    path: '/',
    maxAge: 60,
    httpOnly: false,
  })

  return response
}
