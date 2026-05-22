import { getCategories, getTopPremiumProducts } from '@/lib/api/products'
import Navbar from '@/components/Navbar'

export default async function NavbarShell() {
  const [categories, premiumProducts] = await Promise.all([
    getCategories(),
    getTopPremiumProducts(5),
  ])

  return (
    <Navbar
      categories={categories.map((c) => ({
        name: c.name,
        slug: c.slug,
      }))}
      premiumProducts={premiumProducts.map((p) => ({
        name: p.product_name,
        slug: p.product_slug,
      }))}
    />
  )
}
