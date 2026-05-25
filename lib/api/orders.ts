import { SupabaseClient } from '@supabase/supabase-js'
import { CartLineItem } from '@/types/cart'
import type { Json } from '@/types/database.types'

export type OrderWithItems = {
  id: string
  total_price: number
  order_status: string
  payment_status: string
  created_at: string
  shipping_address?: DeliveryAddress | null
  items: {
    quantity: number
    price: number
    product_name: string
    size: string
  }[]
}

export type AdminOrder = {
  id: string
  user_id: string | null
  total_price: number
  order_status: string
  payment_status: string
  shipping_address: DeliveryAddress | null
  stripe_session_id: string | null
  created_at: string
  customer_name: string
  customer_email: string
  items: OrderWithItems['items']
  payment: {
    amount: number
    method: string
    card_last_four: string | null
    status: string
  } | null
}

export type DeliveryAddress = {
  firstName: string
  lastName: string
  address: string
  city: string
  postalCode: string
  phone?: string
  email?: string
}

export type PaymentDetails = {
  method: 'card' | 'paypal' | 'apple_pay'
  cardholderName: string
  cardLastFour?: string
  expiry?: string
}

type OrderRow = {
  id: string
  user_id: string | null
  total_price?: number | null
  total_amount?: number | null
  order_status: string
  payment_status: string
  shipping_address?: Json | null
  stripe_session_id?: string | null
  created_at: string
}

export function orderTotal(row: { total_price?: number | null; total_amount?: number | null }): number {
  return Number(row.total_amount ?? row.total_price ?? 0)
}

function parseDeliveryAddress(raw: Json | null | undefined): DeliveryAddress | null {
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null
  const d = raw as Record<string, unknown>
  return {
    firstName: String(d.firstName ?? d.first_name ?? ''),
    lastName: String(d.lastName ?? d.last_name ?? ''),
    address: String(d.address ?? ''),
    city: String(d.city ?? 'Amsterdam'),
    postalCode: String(d.postalCode ?? d.postal_code ?? ''),
    email: d.email ? String(d.email) : undefined,
  }
}

export async function placeOrder(
  supabase: SupabaseClient,
  userId: string,
  items: CartLineItem[],
  deliveryAddress: DeliveryAddress,
  payment?: PaymentDetails
) {
  if (items.length === 0) {
    throw new Error('Your cart is empty')
  }

  const total = items.reduce((sum, item) => sum + item.lineTotal, 0)
  const awaitingStripe = !payment

  const { data: order, error: orderError } = await supabase
    .from('orders')
    .insert({
      user_id: userId,
      total_amount: total,
      total_price: total,
      shipping_address: deliveryAddress as Json,
      payment_status: awaitingStripe ? 'pending' : 'completed',
      order_status: awaitingStripe ? 'pending' : 'processing',
    } as Record<string, unknown>)
    .select()
    .single()

  if (orderError) throw orderError

  // Fetch variant details to get size_ml and product name
  const variantIds = items.map((item) => item.product_variant_id)
  const { data: variants } = await supabase
    .from('product_variants')
    .select('id, size_ml, product_id')
    .in('id', variantIds)

  const variantMap = new Map((variants ?? []).map((v) => [v.id, { size_ml: v.size_ml, product_id: v.product_id }]))

  // Fetch product names
  const productIds = (variants ?? []).map((v) => v.product_id)
  const { data: products } = await supabase
    .from('products')
    .select('id, name')
    .in('id', productIds)

  const productMap = new Map((products ?? []).map((p) => [p.id, p.name]))

  const orderItems = items.map((item) => {
    const variant = variantMap.get(item.product_variant_id)
    const productName = variant ? productMap.get(variant.product_id) : null
    return {
      order_id: order.id,
      product_variant_id: item.product_variant_id,
      quantity: item.quantity,
      price: item.price,
      price_at_time: item.price,
      size_ml: variant?.size_ml || null,
      product_name: productName || 'Unknown Product',
    }
  })

  const { error: itemsError } = await supabase.from('order_items').insert(orderItems)
  if (itemsError) throw itemsError

  if (payment) {
    const { error: paymentError } = await supabase.from('payments').insert({
      order_id: order.id,
      user_id: userId,
      amount: total,
      currency: 'EUR',
      payment_method: payment.method,
      cardholder_name: payment.cardholderName,
      card_last_four: payment.cardLastFour ?? null,
      status: 'completed',
      metadata: {
        expiry: payment.expiry ?? null,
        delivery: deliveryAddress,
      } as Json,
    })

    if (paymentError) throw paymentError
  }

  const { error: clearError } = await supabase.from('cart').delete().eq('user_id', userId)
  if (clearError) throw clearError

  return order
}

export async function completeOrderAfterStripe(
  supabase: SupabaseClient,
  userId: string,
  orderId: string,
  stripeSessionId?: string
) {
  const { data: order, error } = await supabase
    .from('orders')
    .select('id, user_id, total_amount, total_price, payment_status')
    .eq('id', orderId)
    .eq('user_id', userId)
    .single()

  if (error || !order) return false
  if (order.payment_status === 'completed') return true

  const total = orderTotal(order)

  await supabase
    .from('orders')
    .update({
      payment_status: 'completed',
      order_status: 'processing',
      stripe_session_id: stripeSessionId ?? undefined,
    })
    .eq('id', orderId)

  const { data: existingPayment } = await supabase
    .from('payments')
    .select('id')
    .eq('order_id', orderId)
    .maybeSingle()

  if (!existingPayment) {
    await supabase.from('payments').insert({
      order_id: orderId,
      user_id: userId,
      amount: total,
      currency: 'EUR',
      payment_method: 'stripe',
      status: 'completed',
      metadata: { stripe_session_id: stripeSessionId ?? null } as Json,
    })
  }

  await supabase.from('cart').delete().eq('user_id', userId)
  return true
}

async function enrichOrderItems(
  supabase: SupabaseClient,
  orderIds: string[]
): Promise<Map<string, OrderWithItems['items']>> {
  const map = new Map<string, OrderWithItems['items']>()
  if (!orderIds.length) return map

  const { data: orderItems } = await supabase
    .from('order_items')
    .select('order_id, quantity, price, product_variant_id')
    .in('order_id', orderIds)

  const variantIds = [
    ...new Set(
      (orderItems ?? [])
        .map((i) => i.product_variant_id)
        .filter((id): id is string => Boolean(id))
    ),
  ]

  const variantMap = new Map<string, { size: string; product_id: string }>()
  const productMap = new Map<string, string>()

  if (variantIds.length > 0) {
    const { data: variants } = await supabase
      .from('product_variants')
      .select('id, product_id, size, size_ml')
      .in('id', variantIds)

    const productIds = [...new Set((variants ?? []).map((v) => v.product_id))]
    if (productIds.length > 0) {
      const { data: products } = await supabase
        .from('products')
        .select('id, name')
        .in('id', productIds)

      for (const p of products ?? []) {
        productMap.set(p.id, p.name)
      }
    }

    for (const v of variants ?? []) {
      const size =
        v.size && String(v.size).trim()
          ? String(v.size)
          : v.size_ml
            ? `${v.size_ml}ml`
            : 'Standard'
      variantMap.set(v.id, { size, product_id: v.product_id })
    }
  }

  for (const item of orderItems ?? []) {
    const variant = item.product_variant_id
      ? variantMap.get(item.product_variant_id)
      : null
    const line = {
      quantity: item.quantity,
      price: Number(item.price),
      product_name: variant ? productMap.get(variant.product_id) ?? 'Product' : 'Product',
      size: variant?.size ?? '',
    }
    const list = map.get(item.order_id) ?? []
    list.push(line)
    map.set(item.order_id, list)
  }

  return map
}

export async function getUserOrders(
  supabase: SupabaseClient,
  userId: string
): Promise<OrderWithItems[]> {
  const { data: orders, error: ordersError } = await supabase
    .from('orders')
    .select('id, total_price, total_amount, order_status, payment_status, shipping_address, created_at')
    .eq('user_id', userId)
    .order('created_at', { ascending: false })

  if (ordersError || !orders?.length) return []

  const rows = orders as OrderRow[]
  const itemsMap = await enrichOrderItems(
    supabase,
    rows.map((o) => o.id)
  )

  return rows.map((order) => ({
    id: order.id,
    total_price: orderTotal(order),
    order_status: order.order_status,
    payment_status: order.payment_status,
    created_at: order.created_at,
    shipping_address: parseDeliveryAddress(order.shipping_address),
    items: itemsMap.get(order.id) ?? [],
  }))
}

export async function getAdminOrders(supabase: SupabaseClient): Promise<AdminOrder[]> {
  const { data: orders, error } = await supabase
    .from('orders')
    .select(
      'id, user_id, total_price, total_amount, order_status, payment_status, shipping_address, stripe_session_id, created_at'
    )
    .order('created_at', { ascending: false })

  if (error || !orders?.length) return []

  const rows = orders as OrderRow[]
  const orderIds = rows.map((o) => o.id)
  const userIds = [...new Set(rows.map((o) => o.user_id).filter(Boolean))] as string[]

  const itemsMap = await enrichOrderItems(supabase, orderIds)

  const userMap = new Map<string, { full_name: string | null; email: string }>()
  if (userIds.length > 0) {
    const { data: users } = await supabase
      .from('users')
      .select('id, full_name, email')
      .in('id', userIds)

    for (const u of users ?? []) {
      userMap.set(u.id, { full_name: u.full_name, email: u.email })
    }
  }

  const { data: payments } = await supabase
    .from('payments')
    .select('order_id, amount, payment_method, card_last_four, status')
    .in('order_id', orderIds)

  const paymentMap = new Map(
    (payments ?? []).map((p) => [
      p.order_id,
      {
        amount: Number(p.amount),
        method: p.payment_method,
        card_last_four: p.card_last_four,
        status: p.status,
      },
    ])
  )

  return rows.map((order) => {
    const user = order.user_id ? userMap.get(order.user_id) : null
    const delivery = parseDeliveryAddress(order.shipping_address)
    return {
      id: order.id,
      user_id: order.user_id,
      total_price: orderTotal(order),
      order_status: order.order_status,
      payment_status: order.payment_status,
      shipping_address: delivery,
      stripe_session_id: order.stripe_session_id ?? null,
      created_at: order.created_at,
      customer_name:
        delivery
          ? `${delivery.firstName} ${delivery.lastName}`.trim()
          : user?.full_name || 'Guest',
      customer_email: delivery?.email || user?.email || '—',
      items: itemsMap.get(order.id) ?? [],
      payment: paymentMap.get(order.id) ?? null,
    }
  })
}

export async function updateOrderStatus(
  supabase: SupabaseClient,
  orderId: string,
  orderStatus: string
) {
  const { data, error } = await supabase
    .from('orders')
    .update({ order_status: orderStatus })
    .eq('id', orderId)
    .select('id, order_status')
    .single()

  if (error) throw error
  return data
}
