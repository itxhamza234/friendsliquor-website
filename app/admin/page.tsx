import Link from 'next/link'
import { createClient } from '@/lib/supabase/server'
import { requireAdmin } from '@/lib/auth/requireAdmin'
import { getAdminOrders } from '@/lib/api/orders'
import AdminOrdersClient from '@/components/AdminOrdersClient'

export const revalidate = 0

export default async function AdminPage() {
  const supabase = await createClient()
  await requireAdmin(supabase)
  const orders = await getAdminOrders(supabase)

  const stats = {
    total: orders.length,
    pending: orders.filter((o) => o.payment_status === 'pending').length,
    delivered: orders.filter((o) => o.order_status === 'delivered').length,
    revenue: orders
      .filter((o) => o.payment_status === 'completed')
      .reduce((sum, o) => sum + o.total_price, 0),
  }

  return (
    <div className="w-full pt-28 pb-24 px-6 min-h-screen">
      <div className="max-w-6xl mx-auto">
        <div className="flex flex-wrap items-center justify-between gap-4 mb-10">
          <div>
            <p className="text-red-500 text-xs font-bold uppercase tracking-[4px] mb-2">
              Admin
            </p>
            <h1 className="text-4xl font-black">
              Orders <span className="text-red-500">Dashboard</span>
            </h1>
          </div>
          <Link
            href="/"
            className="px-6 py-3 rounded-full border border-white/20 hover:border-red-500 text-sm font-bold"
          >
            ← Store
          </Link>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
          <div className="rounded-2xl border border-white/10 bg-white/5 p-5">
            <p className="text-white/50 text-xs uppercase">Total orders</p>
            <p className="text-3xl font-black">{stats.total}</p>
          </div>
          <div className="rounded-2xl border border-white/10 bg-white/5 p-5">
            <p className="text-white/50 text-xs uppercase">Awaiting payment</p>
            <p className="text-3xl font-black text-yellow-400">{stats.pending}</p>
          </div>
          <div className="rounded-2xl border border-white/10 bg-white/5 p-5">
            <p className="text-white/50 text-xs uppercase">Delivered</p>
            <p className="text-3xl font-black text-green-400">{stats.delivered}</p>
          </div>
          <div className="rounded-2xl border border-white/10 bg-white/5 p-5">
            <p className="text-white/50 text-xs uppercase">Revenue (paid)</p>
            <p className="text-3xl font-black text-yellow-400">€{stats.revenue.toFixed(2)}</p>
          </div>
        </div>

        <AdminOrdersClient orders={orders} />
      </div>
    </div>
  )
}
