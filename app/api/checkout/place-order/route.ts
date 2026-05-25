import { createClient } from '@/lib/supabase/server'
import { NextRequest, NextResponse } from 'next/server'
import { placeOrder, type DeliveryAddress } from '@/lib/api/orders'
import { enrichCartItems } from '@/lib/cart/enrichCartItems'
import type { CartLineItem } from '@/types/cart'
import Stripe from 'stripe'

const FREE_ITEM_VARIANT_ID = '2910d511-cb8a-436d-8028-8cc1b9ce89d2'
const FREE_ITEM_QUANTITY = 2
const FREE_ITEM_THRESHOLD = 100
const SHIPPING_THRESHOLD = 100
const SHIPPING_COST = 5.99

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

    const {
      firstName,
      lastName,
      email,
      address,
      city,
      postalCode,
      items,
    } = body

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
      phone: (body as any).phone || undefined,
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

    // ─────────────────────────────────────────────
    // FREE ITEM LOGIC
    // ─────────────────────────────────────────────

    const realItems = cartItems.filter((i) => !i.isFreeItem)

    const realTotal = realItems.reduce(
      (sum, i) => sum + i.lineTotal,
      0
    )

    const freeItemEligible = realTotal >= FREE_ITEM_THRESHOLD

    let orderItems = realItems.map((item) => {
      if (
        freeItemEligible &&
        item.product_variant_id === FREE_ITEM_VARIANT_ID
      ) {
        return {
          ...item,
          quantity: item.quantity + FREE_ITEM_QUANTITY,
          lineTotal: item.lineTotal,
        }
      }

      return item
    })

    const alreadyHasHeineken = orderItems.some(
      (i) => i.product_variant_id === FREE_ITEM_VARIANT_ID
    )

    if (freeItemEligible && !alreadyHasHeineken) {
      orderItems = [
        ...orderItems,
        {
          id: 'free-heineken-250ml',
          product_id: 'free-heineken-250ml',
          product_variant_id: FREE_ITEM_VARIANT_ID,
          product_name: 'Can/Bottle',
          brand: 'Heineken',
          category_name: 'Beer',
          price: 0,
          quantity: FREE_ITEM_QUANTITY,
          lineTotal: 0,
          size: '250ml',
          image_url: null,
          product_slug: 'heineken',
          isFreeItem: true,
        },
      ]
    }

    // ─────────────────────────────────────────────
    // SHIPPING LOGIC
    // ─────────────────────────────────────────────

    const shippingCost = realTotal >= SHIPPING_THRESHOLD ? 0 : SHIPPING_COST
    const orderTotal = realTotal + shippingCost

    // ─────────────────────────────────────────────
    // PLACE ORDER
    // ─────────────────────────────────────────────

    const order = await placeOrder(
      supabase,
      user.id,
      orderItems,
      deliveryAddress as DeliveryAddress,
      undefined
    )

    const siteUrl =
      process.env.NEXT_PUBLIC_SITE_URL?.replace(/\/$/, '') ||
      'https://friendsliquorstore.nl'

    // ─────────────────────────────────────────────
    // BEAUTIFUL WHATSAPP MESSAGE
    // ─────────────────────────────────────────────

    const orderLines = orderItems
      .map((item, index) => {
        const itemName =
          item.brand && item.product_name !== item.brand
            ? `${item.brand} - ${item.product_name}`
            : item.product_name
        const freeTag = item.isFreeItem ? ' (FREE 🎁)' : ''
        return `${index + 1}. ${itemName}${freeTag}%0AQty: ${item.quantity}   Amount: €${item.lineTotal.toFixed(2)}`
      })
      .join('%0A%0A')

    const whatsappMessage =
      '🍾 NEW ORDER RECEIVED 🍾' +
      '%0A%0A' +
      '🆔 Order ID:%0A' + order.id +
      '%0A%0A' +
      '👤 Customer:%0A' +
      firstName + ' ' + lastName + '%0A' +
      (deliveryAddress.email || 'No email') +
      '%0A%0A' +
      '📍 Address:%0A' +
      address + '%0A' +
      postalCode + ', ' + city +
      '%0A%0A' +
      '🛒 Items:%0A' +
      orderLines +
      '%0A%0A' +
      '🚚 Shipping: ' + (shippingCost === 0 ? 'Free' : '€' + shippingCost.toFixed(2)) + '%0A' +
      '💳 Total: €' + orderTotal.toFixed(2) + '%0A' +
      '✅ Paid via Stripe' +
      '%0A%0A' +
      '🕒 ' + new Date().toLocaleString('nl-NL', { timeZone: 'Europe/Amsterdam' }) +
      '%0A%0A' +
      '🍷 Friends Liquor Store'

    // WHATSAPP NUMBER
    const whatsappLink =
      `https://wa.me/31686497222?text=${encodeURIComponent(whatsappMessage)}`

    // ─────────────────────────────────────────────
    // STRIPE LINE ITEMS
    // ─────────────────────────────────────────────

    const lineItems = [
      ...orderItems.map((item) => ({
        price_data: {
          currency: 'eur',
          product_data: {
            name: item.isFreeItem
              ? `🎁 FREE: ${item.brand} ${item.size} (x${item.quantity})`
              : item.product_name ||
                `Product ${item.product_variant_id}`,
          },
          unit_amount: item.isFreeItem
            ? 0
            : Math.max(1, Math.round(item.price * 100)),
        },
        quantity: item.isFreeItem ? 1 : item.quantity,
      })),
      // Shipping line item
      ...(shippingCost > 0
        ? [
            {
              price_data: {
                currency: 'eur',
                product_data: {
                  name: '🚚 Shipping',
                },
                unit_amount: Math.round(shippingCost * 100),
              },
              quantity: 1,
            },
          ]
        : []),
    ]

    const stripe = getStripe()

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card', 'ideal'],

      phone_number_collection: {
        enabled: true,
      },

      line_items: lineItems,

      mode: 'payment',

      customer_creation: 'always',

      customer_email:
        deliveryAddress.email || user.email || undefined,

      success_url:
        `${siteUrl}/profile?order=success` +
        `&session_id={CHECKOUT_SESSION_ID}` +
        `&orderId=${order.id}` +
        `&wa=${encodeURIComponent(whatsappLink)}`,

      cancel_url: `${siteUrl}/checkout/payment`,

      metadata: {
        orderId: order.id,
        userId: user.id,
        customerName: `${firstName} ${lastName}`,
        freeItemIncluded: freeItemEligible ? 'yes' : 'no',
      },
    })

    await (supabase as any)
      .from('orders')
      .update({
        stripe_session_id: session.id,
      })
      .eq('id', order.id)

    return NextResponse.json({
      success: true,
      orderId: order.id,
      url: session.url,
    })

  } catch (err) {
    console.error('Place order error:', err)

    const message =
      err instanceof Error
        ? err.message
        : typeof err === 'object' &&
          err &&
          'message' in err
          ? String((err as { message: unknown }).message)
          : 'Failed to place order'

    return NextResponse.json(
      { error: message },
      { status: 400 }
    )
  }
}