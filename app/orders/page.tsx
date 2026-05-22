'use client'

import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { useAuth } from '@/providers/AuthProvider'
import Link from 'next/link'

type Order = {
  id: string
  created_at: string
  total_amount: number
  payment_status: string
  order_status: string
  shipping_address: any
  order_items: {
    id: string
    product_name: string
    quantity: number
    price: number
    size_ml: number | null
  }[]
}

export default function OrdersPage() {
  const { user } = useAuth()
  const [orders, setOrders] = useState<Order[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return

    const fetchOrders = async () => {
      const supabase = createClient()
      const { data, error } = await supabase
        .from('orders')
        .select(`
          *,
          order_items (
            id,
            product_name,
            quantity,
            price,
            size_ml
          )
        `)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false })

      if (error) {
        console.error('Error fetching orders:', error)
      } else {
        setOrders(data as Order[])
      }
      setLoading(false)
    }

    fetchOrders()
  }, [user])

  if (!user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Please login to view your orders</h1>
          <Link href="/auth" className="text-red-500 hover:underline">
            Login
          </Link>
        </div>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-white">Loading orders...</div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-black text-white p-6">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-black mb-8">Your Orders</h1>

        {orders.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-white/60 text-lg mb-4">No orders yet</p>
            <Link href="/shop" className="text-red-500 hover:underline">
              Start Shopping
            </Link>
          </div>
        ) : (
          <div className="space-y-6">
            {orders.map((order) => (
              <div
                key={order.id}
                className="bg-white/5 border border-white/10 rounded-2xl p-6"
              >
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h2 className="text-xl font-bold mb-2">
                      Order #{order.id.slice(0, 8)}
                    </h2>
                    <p className="text-white/60 text-sm">
                      {new Date(order.created_at).toLocaleDateString()}
                    </p>
                  </div>
                  <div className="text-right">
                    <p className="text-2xl font-bold text-red-500">
                      €{order.total_amount.toFixed(2)}
                    </p>
                    <span
                      className={`inline-block px-3 py-1 rounded-full text-xs font-bold ${
                        order.payment_status === 'paid'
                          ? 'bg-green-500/20 text-green-400'
                          : 'bg-yellow-500/20 text-yellow-400'
                      }`}
                    >
                      {order.payment_status.toUpperCase()}
                    </span>
                  </div>
                </div>

                <div className="border-t border-white/10 pt-4 mb-4">
                  <h3 className="font-bold mb-3">Items</h3>
                  <div className="space-y-2">
                    {order.order_items.map((item) => (
                      <div
                        key={item.id}
                        className="flex justify-between text-sm"
                      >
                        <div>
                          <span className="text-white/80">{item.product_name}</span>
                          {item.size_ml && (
                            <span className="text-white/50 ml-2">
                              ({item.size_ml}ml)
                            </span>
                          )}
                        </div>
                        <div className="text-white/60">
                          {item.quantity} x €{item.price.toFixed(2)}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                {order.shipping_address && (
                  <div className="border-t border-white/10 pt-4">
                    <h3 className="font-bold mb-2">Shipping Address</h3>
                    <p className="text-white/60 text-sm">
                      {typeof order.shipping_address === 'string'
                        ? order.shipping_address
                        : JSON.stringify(order.shipping_address)}
                    </p>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
