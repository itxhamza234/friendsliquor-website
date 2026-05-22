-- Run in Supabase SQL Editor if checkout fails on order_items
DROP POLICY IF EXISTS "Users can view own order items" ON public.order_items;
DROP POLICY IF EXISTS "Users can insert own order items" ON public.order_items;

CREATE POLICY "Users can view own order items"
ON public.order_items FOR SELECT
USING (
  order_id IN (SELECT id FROM public.orders WHERE user_id = auth.uid())
);

CREATE POLICY "Users can insert own order items"
ON public.order_items FOR INSERT
WITH CHECK (
  order_id IN (SELECT id FROM public.orders WHERE user_id = auth.uid())
);
