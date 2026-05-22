import { NextResponse } from 'next/server'
import { headers } from 'next/headers'
import { createClient } from '@supabase/supabase-js'
import Stripe from 'stripe'
import { Resend } from 'resend'

// Supabase Admin Client
const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

// Stripe
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-12-18-preview' as any,
})

// Resend
const resend = new Resend(process.env.RESEND_API_KEY || '')

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

    return NextResponse.json(
      { error: `Webhook Error: ${err.message}` },
      { status: 400 }
    )
  }

  // PAYMENT SUCCESS
  if (event.type === 'checkout.session.completed') {
    const session = event.data.object as Stripe.Checkout.Session

    const orderId = session.metadata?.orderId

    if (orderId) {
      // UPDATE ORDER
      const { error: updateError } = await supabaseAdmin
        .from('orders')
        .update({
          payment_status: 'completed',
          order_status: 'processing',
          stripe_payment_id: session.payment_intent as string,
        })
        .eq('id', orderId)

      if (updateError) {
        console.error(
          '❌ Supabase Order Update Error:',
          updateError.message
        )

        return NextResponse.json(
          { error: 'Database update failed' },
          { status: 500 }
        )
      }

      console.log(`✅ Order ${orderId} marked as PAID!`)

      // SEND EMAILS
      try {
        const customerEmail = session.customer_details?.email
        console.log('RESEND KEY:', process.env.RESEND_API_KEY)
        console.log('CUSTOMER EMAIL:', customerEmail)

        // CUSTOMER EMAIL
        await resend.emails.send({
          from: 'onboarding@resend.dev',
          to: customerEmail || 'friendsliquorstore@gmail.com',
          subject: '✅ Payment Successful - Friends Liquor Store',
          html: `
            <div style="font-family: Arial; padding: 20px;">
              <h2>Payment Successful 🎉</h2>

              <p>Thank you for your order!</p>

              <p>
                <strong>Order ID:</strong> ${orderId}
              </p>

              <p>
                <strong>Amount:</strong> €${(session.amount_total || 0) / 100
            }
              </p>

              <p>
                Your order is now being processed.
              </p>

              <br/>

              <p>
                Friends Liquor Store
              </p>
            </div>
          `,
        })

        // ADMIN EMAIL
        await resend.emails.send({
          from: 'onboarding@resend.dev',
          to: 'friendsliquorstore@gmail.com',
          subject: '🛒 New Order Received',
          html: `
            <div style="font-family: Arial; padding: 20px;">
              <h2>New Order Received</h2>

              <p>
                <strong>Order ID:</strong> ${orderId}
              </p>

              <p>
                <strong>Customer Email:</strong>
                ${customerEmail}
              </p>

              <p>
                <strong>Total:</strong>
                €${(session.amount_total || 0) / 100}
              </p>
            </div>
          `,
        })

        console.log('✅ Emails sent successfully')
      } catch (emailError) {
        console.error('❌ Email sending failed:', JSON.stringify(emailError, null, 2))
      }
    }
  }

  return NextResponse.json(
    { received: true },
    { status: 200 }
  )
}