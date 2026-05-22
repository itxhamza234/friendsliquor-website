'use client'

import { useSyncExternalStore } from 'react'
import type { DeliveryAddress } from '@/lib/api/orders'
import {
  EMPTY_DELIVERY,
  getDeliverySnapshot,
  getValidDeliverySnapshot,
  subscribeDeliveryStorage,
} from '@/lib/checkout/deliveryStorage'

export function useSavedDelivery(): DeliveryAddress {
  return useSyncExternalStore(
    subscribeDeliveryStorage,
    getDeliverySnapshot,
    () => EMPTY_DELIVERY
  )
}

export function useValidDelivery(): DeliveryAddress | null {
  return useSyncExternalStore(
    subscribeDeliveryStorage,
    getValidDeliverySnapshot,
    () => null
  )
}
