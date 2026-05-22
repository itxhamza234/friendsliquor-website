'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import type { AdminOrder } from '@/lib/api/orders'

const STATUS_OPTIONS = [
  { value: 'pending', label: 'Pending' },
  { value: 'processing', label: 'Processing' },
  { value: 'shipped', label: 'Shipped' },
  { value: 'delivered', label: 'Delivered' },
  { value: 'cancelled', label: 'Cancelled' },
]

function statusBadge(status: string, type: 'order' | 'payment') {
  const colors: Record<string, string> =
    type === 'payment'
      ? {
          completed: 'bg-green-500/20 text-green-400 border-green-500/30',
          pending: 'bg-yellow-500/20 text-yellow-400 border-yellow-500/30',
          failed: 'bg-red-500/20 text-red-400 border-red-500/30',
          refunded: 'bg-white/10 text-white/60 border-white/20',
        }
      : {
          delivered: 'bg-green-500/20 text-green-400 border-green-500/30',
          shipped: 'bg-blue-500/20 text-blue-400 border-blue-500/30',
          processing: 'bg-yellow-500/20 text-yellow-400 border-yellow-500/30',
          pending: 'bg-white/10 text-white/60 border-white/20',
          cancelled: 'bg-red-500/20 text-red-400 border-red-500/30',
        }

  return (
    <span
      className={`px-3 py-1 rounded-full text-xs font-bold border capitalize ${colors[status] ?? 'bg-white/10 text-white/70 border-white/20'}`}
    >
      {status}
    </span>
  )
}

export default function AdminOrdersClient({ orders }: { orders: AdminOrder[] }) {
  const router = useRouter()
  const [updatingId, setUpdatingId] = useState<string | null>(null)
  const [error, setError] = useState<string | null>(null)

  const handleStatusChange = async (orderId: string, order_status: string) => {
    setUpdatingId(orderId)
    setError(null)
    try {
      const res = await fetch(`/api/admin/orders/${orderId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ order_status }),
      })
      const result = await res.json()
      if (!res.ok) throw new Error(result.error || 'Update failed')
      router.refresh()
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Update failed')
    } finally {
      setUpdatingId(null)
    }
  }

  if (orders.length === 0) {
    return (
      <p className="text-white/50 text-center py-16">No orders yet.</p>
    )
  }

  return (
    <div className="space-y-6">
      {error && (
        <p className="text-red-400 bg-red-500/10 border border-red-500/30 rounded-xl px-4 py-3 text-sm">
          {error}
        </p>
      )}

      {orders.map((order) => (
        <div
          key={order.id}
          className="rounded-2xl border border-white/10 bg-white/[0.03] p-6 md:p-8"
        >
          <div className="flex flex-wrap items-start justify-between gap-4 mb-6">
            <div>
              <p className="text-white/40 text-xs uppercase tracking-widest mb-1">
                Order #{order.id.slice(0, 8)}
              </p>
              <h3 className="text-xl font-bold">{order.customer_name}</h3>
              <p className="text-white/60 text-sm">{order.customer_email}</p>
              <p className="text-white/40 text-sm mt-1">
                {new Date(order.created_at).toLocaleString('en-GB')}
              </p>
            </div>
            <div className="text-right">
              <p className="text-3xl font-black text-yellow-400">
                €{order.total_price.toFixed(2)}
              </p>
              <div className="flex flex-wrap gap-2 justify-end mt-2">
                {statusBadge(order.payment_status, 'payment')}
                {statusBadge(order.order_status, 'order')}
              </div>
            </div>
          </div>

          {order.shipping_address && (
            <div className="mb-6 p-4 rounded-xl bg-black/30 border border-white/10 text-sm text-white/70">
              <p className="font-bold text-white mb-1">Delivery address</p>
              <p>
                {order.shipping_address.firstName} {order.shipping_address.lastName}
              </p>
              <p>{order.shipping_address.address}</p>
              <p>
                {order.shipping_address.postalCode} {order.shipping_address.city}
              </p>
            </div>
          )}

          <div className="mb-6">
            <p className="text-xs font-bold text-white/50 uppercase mb-3">Items</p>
            <ul className="space-y-2 text-sm text-white/80">
              {order.items.map((item, idx) => (
                <li key={idx} className="flex justify-between gap-4">
                  <span>
                    {item.product_name}
                    {item.size ? ` (${item.size})` : ''} × {item.quantity}
                  </span>
                  <span>€{(item.price * item.quantity).toFixed(2)}</span>
                </li>
              ))}
            </ul>
          </div>

          {order.payment && (
            <div className="mb-6 text-sm text-white/60">
              <span className="font-bold text-white/80">Payment: </span>
              {order.payment.method}
              {order.payment.card_last_four ? ` •••• ${order.payment.card_last_four}` : ''}
              {' — '}€{order.payment.amount.toFixed(2)} ({order.payment.status})
            </div>
          )}

          <div className="flex flex-wrap items-center gap-4 pt-4 border-t border-white/10">
            <label className="text-sm text-white/50 font-bold uppercase">
              Delivery status
            </label>
            <select
              value={order.order_status}
              disabled={updatingId === order.id}
              onChange={(e) => handleStatusChange(order.id, e.target.value)}
              className="bg-black/50 border border-white/20 rounded-xl px-4 py-2 text-white outline-none focus:border-red-500"
            >
              {STATUS_OPTIONS.map((opt) => (
                <option key={opt.value} value={opt.value}>
                  {opt.label}
                </option>
              ))}
            </select>
            {order.order_status === 'delivered' && (
              <span className="text-green-400 text-sm font-bold">✓ Delivered</span>
            )}
          </div>
        </div>
      ))}
    </div>
  )
}
