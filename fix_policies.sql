-- ==========================================
-- FIX RLS INFINITE RECURSION & SCHEMA CACHE
-- NOTE: Prefer fix_cart_and_rls.sql (includes cart columns + policies)
-- Execute this file in your Supabase SQL Editor
-- ==========================================

-- 1. Create a SECURITY DEFINER function to safely check admin status without triggering RLS
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 2. Drop the old recursive policies
DROP POLICY IF EXISTS "Admins can manage products" ON public.products;
DROP POLICY IF EXISTS "Admins can manage variants" ON public.product_variants;
DROP POLICY IF EXISTS "Admins can manage categories" ON public.categories;
DROP POLICY IF EXISTS "Admins can view all orders" ON public.orders;
DROP POLICY IF EXISTS "Admins can view all users" ON public.users;

-- 3. Recreate the policies using the safe function
CREATE POLICY "Admins can manage products" ON public.products FOR ALL USING (public.is_admin());
CREATE POLICY "Admins can manage variants" ON public.product_variants FOR ALL USING (public.is_admin());
CREATE POLICY "Admins can manage categories" ON public.categories FOR ALL USING (public.is_admin());
CREATE POLICY "Admins can view all orders" ON public.orders FOR ALL USING (public.is_admin());
CREATE POLICY "Admins can view all users" ON public.users FOR SELECT USING (public.is_admin());

-- 4. Reload the PostgREST schema cache to fix the 'PGRST205' (Could not find table) error
NOTIFY pgrst, 'reload schema';
