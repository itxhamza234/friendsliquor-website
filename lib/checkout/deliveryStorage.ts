import type { DeliveryAddress } from '@/lib/api/orders'

export const CHECKOUT_STORAGE_KEY = 'friends-checkout-delivery'

/** Stable empty snapshot — same reference every time */
export const EMPTY_DELIVERY: DeliveryAddress = {
  firstName: '',
  lastName: '',
  address: '',
  city: 'Amsterdam',
  postalCode: '',
}

const listeners = new Set<() => void>()

let cachedRaw: string | null | undefined
let cachedDelivery: DeliveryAddress = EMPTY_DELIVERY

let cachedValidRaw: string | null | undefined
let cachedValidDelivery: DeliveryAddress | null = null

function notifyListeners() {
  listeners.forEach((listener) => listener())
}

function parseDelivery(raw: string | null): DeliveryAddress {
  if (!raw) return EMPTY_DELIVERY
  try {
    const data = JSON.parse(raw) as Partial<DeliveryAddress>
    const next: DeliveryAddress = {
      firstName: String(data.firstName ?? ''),
      lastName: String(data.lastName ?? ''),
      address: String(data.address ?? ''),
      city: String(data.city ?? 'Amsterdam'),
      postalCode: String(data.postalCode ?? ''),
    }
    if (
      next.firstName === cachedDelivery.firstName &&
      next.lastName === cachedDelivery.lastName &&
      next.address === cachedDelivery.address &&
      next.city === cachedDelivery.city &&
      next.postalCode === cachedDelivery.postalCode
    ) {
      return cachedDelivery
    }
    cachedDelivery = next
    return cachedDelivery
  } catch {
    return EMPTY_DELIVERY
  }
}

function invalidateCache() {
  cachedRaw = undefined
  cachedValidRaw = undefined
  cachedDelivery = EMPTY_DELIVERY
  cachedValidDelivery = null
}

/** Cached snapshot for useSyncExternalStore — stable reference when data unchanged */
export function getDeliverySnapshot(): DeliveryAddress {
  if (typeof window === 'undefined') return EMPTY_DELIVERY
  const raw = sessionStorage.getItem(CHECKOUT_STORAGE_KEY)
  if (raw === cachedRaw) return cachedDelivery
  cachedRaw = raw
  if (!raw) {
    cachedDelivery = EMPTY_DELIVERY
    return EMPTY_DELIVERY
  }
  return parseDelivery(raw)
}

/** Cached valid delivery or null — stable reference */
export function getValidDeliverySnapshot(): DeliveryAddress | null {
  if (typeof window === 'undefined') return null
  const raw = sessionStorage.getItem(CHECKOUT_STORAGE_KEY)
  if (raw === cachedValidRaw) return cachedValidDelivery
  cachedValidRaw = raw

  if (!raw) {
    cachedValidDelivery = null
    return null
  }

  const delivery = parseDelivery(raw)
  if (!delivery.firstName.trim() || !delivery.address.trim()) {
    cachedValidDelivery = null
    return null
  }

  cachedValidDelivery = delivery
  return cachedValidDelivery
}

export function subscribeDeliveryStorage(onStoreChange: () => void) {
  listeners.add(onStoreChange)
  return () => listeners.delete(onStoreChange)
}

export function saveDelivery(data: DeliveryAddress) {
  const raw = JSON.stringify(data)
  sessionStorage.setItem(CHECKOUT_STORAGE_KEY, raw)
  cachedRaw = raw
  cachedDelivery = {
    firstName: data.firstName,
    lastName: data.lastName,
    address: data.address,
    city: data.city,
    postalCode: data.postalCode,
  }
  cachedValidRaw = raw
  cachedValidDelivery = cachedDelivery
  notifyListeners()
}

export function clearSavedDelivery() {
  sessionStorage.removeItem(CHECKOUT_STORAGE_KEY)
  invalidateCache()
  notifyListeners()
}

/** @deprecated Use getDeliverySnapshot — kept for non-hook callers */
export function readSavedDelivery(): DeliveryAddress {
  return getDeliverySnapshot()
}

/** @deprecated Use getValidDeliverySnapshot */
export function readSavedDeliveryOrNull(): DeliveryAddress | null {
  return getValidDeliverySnapshot()
}

export function getEmptyDelivery(): DeliveryAddress {
  return EMPTY_DELIVERY
}
