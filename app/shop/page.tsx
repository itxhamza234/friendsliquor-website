'use client'

import { Suspense } from 'react'
import ShopContent from './ShopContent'

export default function ShopPage() {
  return (
    <Suspense fallback={<div className="text-white p-10">Loading...</div>}>
      <ShopContent />
    </Suspense>
  )
}