import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

export const dynamic = 'force-dynamic'

export async function GET() {
  const supabase = await createClient()
  const { data: p } = await supabase.from('products').select('id')
  const { data: c } = await supabase.from('categories').select('id')
  return NextResponse.json({ 
    totalProducts: p?.length || 0, 
    totalCategories: c?.length || 0 
  })
}
