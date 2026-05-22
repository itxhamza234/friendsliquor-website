import { createClient } from '@/lib/supabase/server'
import { NextRequest, NextResponse } from 'next/server'
import { updateOrderStatus } from '@/lib/api/orders'

const ALLOWED_STATUSES = [
  'pending',
  'processing',
  'shipped',
  'delivered',
  'cancelled',
] as const

export async function PATCH(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const supabase = await createClient()
    const {
      data: { user },
    } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

   const { data: profile } = await supabase
  .from('users')
  .select('role')
  .eq('id', user.id)
  .single() as unknown as { data: { role: string } | null }

    if (profile?.role !== 'admin') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const { id } = await params
    const body = await request.json()
    const { order_status } = body

    if (!order_status || !ALLOWED_STATUSES.includes(order_status)) {
      return NextResponse.json({ error: 'Invalid order status' }, { status: 400 })
    }

    const updated = await updateOrderStatus(supabase, id, order_status)
    return NextResponse.json({ success: true, order: updated })
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Update failed'
    return NextResponse.json({ error: message }, { status: 400 })
  }
}
