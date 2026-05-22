import { Product, ProductVariant } from '@/types/product'

function parseVariantsJson(raw: unknown): Record<string, unknown>[] {
  if (!raw) return []
  if (Array.isArray(raw)) return raw as Record<string, unknown>[]
  if (typeof raw === 'string') {
    try {
      const parsed = JSON.parse(raw)
      return Array.isArray(parsed) ? parsed : []
    } catch {
      return []
    }
  }
  return []
}

export function normalizeVariantFromRow(
  row: Record<string, unknown>
): ProductVariant {
  const size =
    (row.size as string) ||
    (row.variant_name as string) ||
    (row.size_ml != null ? `${row.size_ml}ml` : 'Standard')

  return {
    id: String(row.id ?? ''),
    variant_name: (row.variant_name as string | null) ?? size,
    size,
    price_euro: Number(row.price_euro ?? row.price ?? 0),
    stock: Number(row.stock_quantity ?? row.stock ?? 0),
    sku: (row.sku as string | null) ?? null,
  }
}

export function normalizeProductVariants<T extends Product>(product: T): T {
  const parsed = parseVariantsJson(product.variants)
  const variants = parsed
    .filter((v) => v.id)
    .map((v) => normalizeVariantFromRow(v))

  return {
    ...product,
    variants: variants.length > 0 ? variants : null,
  }
}
