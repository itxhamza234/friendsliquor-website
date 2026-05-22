import { getCategories } from '@/lib/api/products'
import Footer from '@/components/Footer'

export default async function FooterShell() {
  const categories = await getCategories()
  return <Footer categories={categories.map((c) => ({ name: c.name, slug: c.slug }))} />
}
