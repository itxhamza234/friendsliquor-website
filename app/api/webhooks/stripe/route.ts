import { NextResponse } from 'next/server'
import { headers } from 'next/headers'
import { createClient } from '@supabase/supabase-js'
import Stripe from 'stripe'

// Supabase Admin Client (Bypass RLS to update order status)
const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY! // `.env.local` mein yeh key honi chahiye
)

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-12-18-preview' as any,
})

export async function POST(req: Request) {
  const body = await req.text()
  const headersList = await headers()
  const signature = headersList.get('stripe-signature') as string

  let event: Stripe.Event

  try {
    event = stripe.webhooks.constructEvent(
      body,
      signature,
      process.env.STRIPE_WEBHOOK_SECRET!
    )
  } catch (err: any) {
    console.error(`❌ Webhook Error: ${err.message}`)
    return NextResponse.json({ error: `Webhook Error: ${err.message}` }, { status: 400 })
  }

  // Handle the event
  if (event.type === 'checkout.session.completed') {
    const session = event.data.object as Stripe.Checkout.Session
    const orderId = session.metadata?.orderId

    if (orderId) {
      // 1. Update order status to paid in Supabase
      const { error: updateError } = await supabaseAdmin
        .from('orders')
        .update({
          payment_status: 'completed',  // 'paid' → 'completed'
          order_status: 'processing',
          stripe_payment_id: session.payment_intent as string
        })
        .eq('id', orderId)

      if (updateError) {
        console.error('❌ Supabase Order Update Error:', updateError.message)
        return NextResponse.json({ error: 'Database update failed' }, { status: 500 })
      }

      console.log(`✅ Order ${orderId} successfully marked as PAID!`)
    }
  }

  return NextResponse.json({ received: true }, { status: 200 })
}