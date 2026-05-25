import { NextResponse } from 'next/server'
import { headers } from 'next/headers'
import { createClient } from '@supabase/supabase-js'
import Stripe from 'stripe'
import { Resend } from 'resend'

const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2024-12-18-preview' as any,
})

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
    return NextResponse.json({ error: `Webhook Error: ${err.message}` }, { status: 400 })
  }

  if (event.type === 'checkout.session.completed') {
    const session = event.data.object as Stripe.Checkout.Session
    const orderId = session.metadata?.orderId

    if (orderId) {
      const { data: orderData } = await supabaseAdmin
        .from('orders')
        .select('shipping_address')
        .eq('id', orderId)
        .single()

      const { data: orderItems } = await supabaseAdmin
        .from('order_items')
        .select('product_name, quantity, price, size')
        .eq('order_id', orderId)

      const shipping = orderData?.shipping_address || {}
      const customerName = `${shipping.firstName || ''} ${shipping.lastName || ''}`.trim() || 'N/A'
      const customerEmail = shipping.email || session.customer_details?.email || 'N/A'
      const customerPhone = session.customer_details?.phone || 'N/A'
      const customerAddress = `${shipping.address || ''}, ${shipping.city || ''}, ${shipping.postalCode || ''}`.trim()
      const amountPaid = `€${((session.amount_total || 0) / 100).toFixed(2)}`

      const itemsHtml = orderItems && orderItems.length > 0
        ? orderItems.map((item: any) => `
            <tr>
              <td style="padding:8px;border-bottom:1px solid #eee;">${item.product_name || 'Product'}</td>
              <td style="padding:8px;border-bottom:1px solid #eee;text-align:center;">${item.size || '-'}</td>
              <td style="padding:8px;border-bottom:1px solid #eee;text-align:center;">${item.quantity}</td>
              <td style="padding:8px;border-bottom:1px solid #eee;text-align:right;">€${Number(item.price).toFixed(2)}</td>
            </tr>
          `).join('')
        : '<tr><td colspan="4" style="padding:8px;">No items found</td></tr>'

      const { error: updateError } = await supabaseAdmin
        .from('orders')
        .update({
          payment_status: 'completed',
          order_status: 'processing',
          stripe_payment_id: session.payment_intent as string,
          customer_phone: customerPhone,
        })
        .eq('id', orderId)

      if (updateError) {
        console.error('❌ Supabase Update Error:', updateError.message)
        return NextResponse.json({ error: 'Database update failed' }, { status: 500 })
      }

      console.log(`✅ Order ${orderId} marked as PAID!`)

      try {
        // CUSTOMER EMAIL
        await resend.emails.send({
          from: "Friend's Liquor Store <orders@friendsliquorstore.nl>",
          to: customerEmail !== 'N/A' ? customerEmail : 'friendsliquorstore@gmail.com',
          subject: '✅ Order Confirmed - Friends Liquor Store',
          html: `
            <div style="font-family:Arial;max-width:600px;margin:0 auto;padding:20px;background:#f9f9f9;">
              <div style="background:#000;padding:20px;text-align:center;border-radius:8px 8px 0 0;">
                <h1 style="color:#fff;margin:0;">Friend's <span style="color:#e53e3e;">Liquor</span> Store</h1>
              </div>
              <div style="background:#fff;padding:30px;border-radius:0 0 8px 8px;">
                <h2 style="color:#333;">Payment Successful 🎉</h2>
                <p style="color:#666;">Thank you for your order, <strong>${customerName}</strong>!</p>

                <div style="background:#f5f5f5;padding:15px;border-radius:8px;margin:20px 0;">
                  <p style="margin:5px 0;"><strong>Order ID:</strong> ${orderId}</p>
                  <p style="margin:5px 0;"><strong>Amount Paid:</strong> ${amountPaid}</p>
                  <p style="margin:5px 0;"><strong>Delivery Address:</strong> ${customerAddress}</p>
                  <p style="margin:5px 0;"><strong>Phone:</strong> ${customerPhone}</p>
                </div>

                <h3 style="color:#333;">Order Items:</h3>
                <table style="width:100%;border-collapse:collapse;">
                  <thead>
                    <tr style="background:#f5f5f5;">
                      <th style="padding:8px;text-align:left;">Product</th>
                      <th style="padding:8px;text-align:center;">Size</th>
                      <th style="padding:8px;text-align:center;">Qty</th>
                      <th style="padding:8px;text-align:right;">Price</th>
                    </tr>
                  </thead>
                  <tbody>${itemsHtml}</tbody>
                  <tfoot>
                    <tr style="background:#f5f5f5;">
                      <td colspan="3" style="padding:8px;font-weight:bold;">Total</td>
                      <td style="padding:8px;text-align:right;font-weight:bold;">${amountPaid}</td>
                    </tr>
                  </tfoot>
                </table>

                <p style="color:#666;margin-top:20px;">Your order is being processed and will be delivered soon.</p>
                <p style="color:#999;font-size:12px;">Friends Liquor Store — Amsterdam</p>
              </div>
            </div>
          `,
        })

        // ADMIN EMAIL
        await resend.emails.send({
          from: 'Store Alert <noreply@friendsliquorstore.nl>',
          to: 'friendsliquorstore@gmail.com',
          subject: `🛒 New Order #${orderId.slice(0, 8)} — ${amountPaid}`,
          html: `
            <div style="font-family:Arial;max-width:600px;margin:0 auto;padding:20px;">
              <h2 style="color:#e53e3e;">New Order Received 🛒</h2>

              <div style="background:#f5f5f5;padding:15px;border-radius:8px;margin:20px 0;">
                <p style="margin:5px 0;"><strong>Order ID:</strong> ${orderId}</p>
                <p style="margin:5px 0;"><strong>Name:</strong> ${customerName}</p>
                <p style="margin:5px 0;"><strong>Email:</strong> ${customerEmail}</p>
                <p style="margin:5px 0;"><strong>Phone:</strong> ${customerPhone}</p>
                <p style="margin:5px 0;"><strong>Address:</strong> ${customerAddress}</p>
                <p style="margin:5px 0;"><strong>Total:</strong> ${amountPaid}</p>
              </div>

              <h3>Order Items:</h3>
              <table style="width:100%;border-collapse:collapse;">
                <thead>
                  <tr style="background:#f5f5f5;">
                    <th style="padding:8px;text-align:left;">Product</th>
                    <th style="padding:8px;text-align:center;">Size</th>
                    <th style="padding:8px;text-align:center;">Qty</th>
                    <th style="padding:8px;text-align:right;">Price</th>
                  </tr>
                </thead>
                <tbody>${itemsHtml}</tbody>
                <tfoot>
                  <tr style="background:#f5f5f5;">
                    <td colspan="3" style="padding:8px;font-weight:bold;">Total</td>
                    <td style="padding:8px;text-align:right;font-weight:bold;">${amountPaid}</td>
                  </tr>
                </tfoot>
              </table>
            </div>
          `,
        })

        console.log('✅ Emails sent successfully')
      } catch (emailError) {
        console.error('❌ Email Error:', JSON.stringify(emailError, null, 2))
      }
    }
  }

  return NextResponse.json({ received: true }, { status: 200 })
}