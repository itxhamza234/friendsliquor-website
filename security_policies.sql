-- ==========================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- Safe to re-run: drops existing policies first, then recreates them.
-- Execute this file in your Supabase SQL Editor
-- IMPORTANT: Run fix_cart_and_rls.sql first if cart/orders columns are missing
-- ==========================================

-- Safe admin check (prevents infinite recursion on users table)
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

-- 1. Add Role Column to Users (For Future Admin Features)
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS role text DEFAULT 'customer' CHECK (role IN ('customer', 'admin'));

-- 2. Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cart ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wishlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- DROP EXISTING POLICIES (idempotent re-run)
-- ==========================================

-- users
DROP POLICY IF EXISTS "Users can view own profile" ON public.users;
DROP POLICY IF EXISTS "Users can update own profile" ON public.users;
DROP POLICY IF EXISTS "Users can insert own profile" ON public.users;
DROP POLICY IF EXISTS "Admins can view all users" ON public.users;

-- cart
DROP POLICY IF EXISTS "Users can view own cart" ON public.cart;
DROP POLICY IF EXISTS "Users can insert into own cart" ON public.cart;
DROP POLICY IF EXISTS "Users can update own cart" ON public.cart;
DROP POLICY IF EXISTS "Users can delete from own cart" ON public.cart;

-- wishlist
DROP POLICY IF EXISTS "Users can view own wishlist" ON public.wishlist;
DROP POLICY IF EXISTS "Users can insert into own wishlist" ON public.wishlist;
DROP POLICY IF EXISTS "Users can delete from own wishlist" ON public.wishlist;

-- orders
DROP POLICY IF EXISTS "Users can view own orders" ON public.orders;
DROP POLICY IF EXISTS "Users can insert own orders" ON public.orders;
DROP POLICY IF EXISTS "Admins can view all orders" ON public.orders;

-- order_items
DROP POLICY IF EXISTS "Users can view own order items" ON public.order_items;
DROP POLICY IF EXISTS "Users can insert own order items" ON public.order_items;

-- reviews
DROP POLICY IF EXISTS "Anyone can view reviews" ON public.reviews;
DROP POLICY IF EXISTS "Users can insert own reviews" ON public.reviews;
DROP POLICY IF EXISTS "Users can update own reviews" ON public.reviews;
DROP POLICY IF EXISTS "Users can delete own reviews" ON public.reviews;

-- public read
DROP POLICY IF EXISTS "Public read products" ON public.products;
DROP POLICY IF EXISTS "Public read product variants" ON public.product_variants;
DROP POLICY IF EXISTS "Public read categories" ON public.categories;

-- admin (old names)
DROP POLICY IF EXISTS "Admins can manage products" ON public.products;
DROP POLICY IF EXISTS "Admins can manage variants" ON public.product_variants;
DROP POLICY IF EXISTS "Admins can manage categories" ON public.categories;
DROP POLICY IF EXISTS "Admins can insert products" ON public.products;
DROP POLICY IF EXISTS "Admins can update products" ON public.products;
DROP POLICY IF EXISTS "Admins can delete products" ON public.products;
DROP POLICY IF EXISTS "Admins can insert variants" ON public.product_variants;
DROP POLICY IF EXISTS "Admins can update variants" ON public.product_variants;
DROP POLICY IF EXISTS "Admins can delete variants" ON public.product_variants;
DROP POLICY IF EXISTS "Admins can insert categories" ON public.categories;
DROP POLICY IF EXISTS "Admins can update categories" ON public.categories;
DROP POLICY IF EXISTS "Admins can delete categories" ON public.categories;
DROP POLICY IF EXISTS "Admins can manage all orders" ON public.orders;

-- ==========================================
-- USERS / PROFILES POLICIES
-- ==========================================
CREATE POLICY "Users can view own profile"
ON public.users FOR SELECT
USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
ON public.users FOR UPDATE
USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
ON public.users FOR INSERT
WITH CHECK (auth.uid() = id);

-- ==========================================
-- CART POLICIES
-- ==========================================
CREATE POLICY "Users can view own cart"
ON public.cart FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert into own cart"
ON public.cart FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own cart"
ON public.cart FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete from own cart"
ON public.cart FOR DELETE
USING (auth.uid() = user_id);

-- ==========================================
-- WISHLIST POLICIES
-- ==========================================
CREATE POLICY "Users can view own wishlist"
ON public.wishlist FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert into own wishlist"
ON public.wishlist FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete from own wishlist"
ON public.wishlist FOR DELETE
USING (auth.uid() = user_id);

-- ==========================================
-- ORDERS POLICIES
-- ==========================================
CREATE POLICY "Users can view own orders"
ON public.orders FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own orders"
ON public.orders FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view own order items"
ON public.order_items FOR SELECT
USING (
  order_id IN (
    SELECT id FROM public.orders WHERE user_id = auth.uid()
  )
);

CREATE POLICY "Users can insert own order items"
ON public.order_items FOR INSERT
WITH CHECK (
  order_id IN (
    SELECT id FROM public.orders WHERE user_id = auth.uid()
  )
);

-- ==========================================
-- REVIEWS POLICIES
-- ==========================================
CREATE POLICY "Anyone can view reviews"
ON public.reviews FOR SELECT
USING (true);

CREATE POLICY "Users can insert own reviews"
ON public.reviews FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own reviews"
ON public.reviews FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own reviews"
ON public.reviews FOR DELETE
USING (auth.uid() = user_id);

-- ==========================================
-- PUBLIC DATA POLICIES (Products, Categories)
-- ==========================================
CREATE POLICY "Public read products" ON public.products FOR SELECT USING (true);
CREATE POLICY "Public read product variants" ON public.product_variants FOR SELECT USING (true);
CREATE POLICY "Public read categories" ON public.categories FOR SELECT USING (true);

-- ==========================================
-- ADMIN POLICIES (use is_admin() — no recursion)
-- ==========================================
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

NOTIFY pgrst, 'reload schema';
