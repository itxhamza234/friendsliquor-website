-- ==========================================
-- FIX CART SCHEMA + RLS RECURSION
-- Run this entire file in Supabase SQL Editor (once)
-- ==========================================

-- 1. Safe admin check (avoids infinite recursion on users table)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.users
    WHERE id = auth.uid() AND role = 'admin'
  );
$$;

-- 2. Fix recursive admin policies
DROP POLICY IF EXISTS "Admins can manage products" ON public.products;
DROP POLICY IF EXISTS "Admins can manage variants" ON public.product_variants;
DROP POLICY IF EXISTS "Admins can manage categories" ON public.categories;
DROP POLICY IF EXISTS "Admins can view all orders" ON public.orders;
DROP POLICY IF EXISTS "Admins can view all users" ON public.users;

CREATE POLICY "Admins can insert products" ON public.products
  FOR INSERT WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update products" ON public.products
  FOR UPDATE USING (public.is_admin());
CREATE POLICY "Admins can delete products" ON public.products
  FOR DELETE USING (public.is_admin());

CREATE POLICY "Admins can insert variants" ON public.product_variants
  FOR INSERT WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update variants" ON public.product_variants
  FOR UPDATE USING (public.is_admin());
CREATE POLICY "Admins can delete variants" ON public.product_variants
  FOR DELETE USING (public.is_admin());

CREATE POLICY "Admins can insert categories" ON public.categories
  FOR INSERT WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update categories" ON public.categories
  FOR UPDATE USING (public.is_admin());
CREATE POLICY "Admins can delete categories" ON public.categories
  FOR DELETE USING (public.is_admin());

CREATE POLICY "Admins can manage all orders" ON public.orders
  FOR ALL USING (public.is_admin());

CREATE POLICY "Admins can view all users" ON public.users
  FOR SELECT USING (public.is_admin());

DROP POLICY IF EXISTS "Users can insert own profile" ON public.users;
CREATE POLICY "Users can insert own profile" ON public.users
  FOR INSERT WITH CHECK (auth.uid() = id);

-- 3. Cart table: add missing columns used by the storefront
ALTER TABLE public.cart
  ADD COLUMN IF NOT EXISTS product_variant_id UUID REFERENCES public.product_variants(id) ON DELETE CASCADE;

ALTER TABLE public.cart
  ADD COLUMN IF NOT EXISTS quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0);

-- Remove old "one cart row per user" constraint (causes duplicate key on 2nd product)
ALTER TABLE public.cart DROP CONSTRAINT IF EXISTS cart_user_id_key;

-- One row per user + variant (multiple products allowed)
DROP INDEX IF EXISTS cart_user_variant_unique;
CREATE UNIQUE INDEX cart_user_variant_unique
  ON public.cart (user_id, product_variant_id);

-- 3b. Auto-create public.users profile when someone signs up in Supabase Auth
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.users (id, email, full_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', ''),
    'customer'
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    full_name = COALESCE(NULLIF(EXCLUDED.full_name, ''), public.users.full_name);
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 4. Orders: align with storefront (add columns if your admin DB used different names)
ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS total_price DECIMAL(10,2);

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS shipping_address JSONB;

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS payment_status TEXT DEFAULT 'pending';

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS order_status TEXT DEFAULT 'pending';

-- 5. Order items: align with storefront
ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS product_variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL;

ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0);

ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS price DECIMAL(10,2);

-- 6. Reload API schema cache
NOTIFY pgrst, 'reload schema';
