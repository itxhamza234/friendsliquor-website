import { createClient } from '@/lib/supabase/server'

export const dynamic = 'force-dynamic'

export default async function DebugPage() {
  const supabase = await createClient()

  // Test Categories
  const { data: categories, error: catError } = await supabase.from('categories').select('*')
  
  // Test Products
  const { data: products, error: prodError } = await supabase.from('products').select('*')
  
  // Test View
  const { data: viewData, error: viewError } = await supabase.from('product_details_view').select('*')

  return (
    <div className="p-20 text-white break-words">
      <h1 className="text-3xl font-bold mb-4">Database Debug Info</h1>
      
      <div className="mb-8 border p-4 border-red-500 bg-red-900/20">
        <h2 className="text-xl font-bold">Categories Error:</h2>
        <pre>{JSON.stringify(catError, null, 2)}</pre>
        <h2 className="text-xl font-bold mt-4">Categories Data Length:</h2>
        <pre>{categories?.length || 0}</pre>
      </div>

      <div className="mb-8 border p-4 border-blue-500 bg-blue-900/20">
        <h2 className="text-xl font-bold">Products Error:</h2>
        <pre>{JSON.stringify(prodError, null, 2)}</pre>
        <h2 className="text-xl font-bold mt-4">Products Data Length:</h2>
        <pre>{products?.length || 0}</pre>
      </div>

      <div className="mb-8 border p-4 border-green-500 bg-green-900/20">
        <h2 className="text-xl font-bold">View Error:</h2>
        <pre>{JSON.stringify(viewError, null, 2)}</pre>
        <h2 className="text-xl font-bold mt-4">View Data Length:</h2>
        <pre>{viewData?.length || 0}</pre>
      </div>
    </div>
  )
}
