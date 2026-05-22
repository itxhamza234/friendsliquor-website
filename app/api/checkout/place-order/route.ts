import { createClient } from '@/lib/supabase/server'
import { NextRequest, NextResponse } from 'next/server'
import { placeOrder, type DeliveryAddress } from '@/lib/api/orders'
import { enrichCartItems } from '@/lib/cart/enrichCartItems'
import type { CartLineItem } from '@/types/cart'
import Stripe from 'stripe'

function getStripe() {
  const key = process.env.STRIPE_SECRET_KEY
  if (!key) {
    throw new Error('STRIPE_SECRET_KEY is not set in .env.local')
  }
  return new Stripe(key)
}

function isCartLineItem(value: unknown): value is CartLineItem {
  if (!value || typeof value !== 'object') return false
  const item = value as CartLineItem
  return (
    typeof item.product_variant_id === 'string' &&
    typeof item.quantity === 'number' &&
    typeof item.price === 'number'
  )
}

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json(
        { error: 'Please log in to place an order.' },
        { status: 401 }
      )
    }

    const body = await request.json()
    const { firstName, lastName, email, address, city, postalCode, items } = body

    if (!firstName || !lastName || !address) {
      return NextResponse.json(
        { error: 'Please fill in all required fields.' },
        { status: 400 }
      )
    }

    const deliveryAddress: DeliveryAddress & { email?: string } = {
      firstName,
      lastName,
      address,
      city: city || 'Amsterdam',
      postalCode: postalCode || '',
      email: email || user.email || undefined,
    }

    let cartItems: CartLineItem[] = Array.isArray(items)
      ? items.filter(isCartLineItem)
      : []

    if (cartItems.length === 0) {
      const { data: cartRows, error: cartError } = await supabase
        .from('cart')
        .select('id, product_variant_id, quantity')
        .eq('user_id', user.id)

      if (cartError) throw cartError

      if (!cartRows?.length) {
        return NextResponse.json(
          { error: 'Your cart is empty.' },
          { status: 400 }
        )
      }

      cartItems = await enrichCartItems(supabase, cartRows)
    }

    // Aapka purana order creation code (Is se order database mein save ho jayega)
    const order = await placeOrder(
      supabase,
      user.id,
      cartItems,
      deliveryAddress as DeliveryAddress,
      undefined
    )

    // Stripe Checkout session
    const siteUrl =
      process.env.NEXT_PUBLIC_SITE_URL?.replace(/\/$/, '') ||
      'https://friendsliquorstore.nl'

    const lineItems = cartItems.map((item) => ({
      price_data: {
        currency: 'eur',
        product_data: {
          name: item.product_name || `Product ${item.product_variant_id}`,
        },
        unit_amount: Math.max(1, Math.round(item.price * 100)),
      },
      quantity: item.quantity,
    }))

    const stripe = getStripe()
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card', 'ideal'],
      line_items: lineItems,
      mode: 'payment',
      customer_creation: 'always',
      customer_email: deliveryAddress.email || user.email || undefined,
      success_url: `${siteUrl}/profile?order=success&session_id={CHECKOUT_SESSION_ID}&orderId=${order.id}`,
      cancel_url: `${siteUrl}/checkout/payment`,
      // Metadata mein order ki information taake Stripe Dashboard par nazar aaye
      metadata: {
        orderId: order.id,
        userId: user.id,
        customerName: `${firstName} ${lastName}`,
      },
    })

    await (supabase as any)
      .from('orders')
      .update({ stripe_session_id: session.id })
      .eq('id', order.id)
    return NextResponse.json({ success: true, orderId: order.id, url: session.url })

  } catch (err) {
    console.error('Place order error:', err)
    const message =
      err instanceof Error
        ? err.message
        : typeof err === 'object' && err && 'message' in err
          ? String((err as { message: unknown }).message)
          : 'Failed to place order'
    return NextResponse.json({ error: message }, { status: 400 })
  }
}