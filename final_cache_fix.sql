-- ==========================================
-- FINAL CACHE & PERMISSION FIX
-- ==========================================

-- 1. Explicitly grant permissions to the public roles for the view
GRANT SELECT ON public.product_details_view TO anon, authenticated, service_role;
GRANT SELECT ON public.products TO anon, authenticated, service_role;
GRANT SELECT ON public.categories TO anon, authenticated, service_role;
GRANT SELECT ON public.product_variants TO anon, authenticated, service_role;

-- 2. Force PostgREST to reload its schema cache
NOTIFY pgrst, 'reload schema';
