-- ==============================================================
-- DATABASE CLEANUP SCRIPT
-- Execute in Supabase SQL Editor to clean up unused data
-- ==============================================================

-- 1. Remove orphan product variants (variants that belong to a deleted product)
DELETE FROM public.product_variants 
WHERE product_id NOT IN (SELECT id FROM public.products);

-- 2. Remove empty categories (categories that have no products)
DELETE FROM public.categories 
WHERE id NOT IN (
    SELECT DISTINCT category_id 
    FROM public.products 
    WHERE category_id IS NOT NULL
);

-- Note: We are NOT deleting products without variants because 
-- some premium products might have a direct price instead of variants.
-- This safely leaves your active Whisky, Vodka, Gin, Rum, Tequila, etc. untouched.

-- Force schema cache refresh just in case
NOTIFY pgrst, 'reload schema';
