'use client'

import { useState } from 'react'
import { useCart } from '@/providers/CartProvider'

type AddToCartButtonProps = {
  variantId: string | null | undefined
  quantity?: number
  price?: number
  className?: string
  showPrice?: boolean
  label?: string
  size?: 'sm' | 'md' | 'lg'
}

const sizeClasses = {
  sm: 'px-5 py-3 text-sm',
  md: 'px-6 py-3 text-sm',
  lg: 'px-8 py-4 text-lg',
}

export default function AddToCartButton({
  variantId,
  quantity = 1,
  price,
  className = '',
  showPrice = false,
  label = 'Add To Cart',
  size = 'md',
}: AddToCartButtonProps) {
  const { addToCart } = useCart()
  const [status, setStatus] = useState<'idle' | 'adding' | 'added'>('idle')

  const disabled = !variantId || status === 'adding'

  const handleClick = async (e: React.MouseEvent) => {
    e.preventDefault()
    e.stopPropagation()

    if (!variantId) return

    setStatus('adding')
    const ok = await addToCart(variantId, quantity)
    if (ok) {
      setStatus('added')
      setTimeout(() => setStatus('idle'), 2000)
    } else {
      setStatus('idle')
      alert('Could not add to cart. Please try again or select a size.')
    }
  }

  const buttonLabel =
    status === 'added' ? 'Added!' : status === 'adding' ? 'Adding...' : label

  return (
    <button
      type="button"
      onClick={handleClick}
      disabled={disabled}
      className={`rounded-full bg-red-500 hover:bg-red-600 transition-all font-bold shadow-[0_0_30px_rgba(255,0,0,0.5)] disabled:opacity-50 disabled:cursor-not-allowed ${sizeClasses[size]} ${className}`}
    >
      <span className="flex items-center justify-center gap-2">
        <span>{buttonLabel}</span>
        {showPrice && price !== undefined && status === 'idle' && (
          <>
            <span>—</span>
            <span>€{(price * quantity).toFixed(2)}</span>
          </>
        )}
      </span>
    </button>
  )
}
