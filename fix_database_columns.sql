-- Run in Supabase SQL Editor
-- Fixes database column names and adds missing columns for checkout process

-- 1. Rename delivery_address to shipping_address in orders table (only if delivery_address exists and shipping_address doesn't)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'orders' 
    AND column_name = 'delivery_address'
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'orders' 
    AND column_name = 'shipping_address'
  ) THEN
    ALTER TABLE public.orders RENAME COLUMN delivery_address TO shipping_address;
  END IF;
END $$;

-- 2. Add total_amount column if it doesn't exist
ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS total_amount DECIMAL(10, 2);

-- 3. Add size_ml column to order_items if it doesn't exist
ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS size_ml INTEGER;

-- 3b. Add price_at_time column to order_items if it doesn't exist
ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS price_at_time DECIMAL(10, 2);

-- 4. Backfill total_amount from total_price if null
UPDATE public.orders
SET total_amount = total_price
WHERE total_amount IS NULL AND total_price IS NOT NULL;

-- 5. Make total_amount NOT NULL (after backfill)
ALTER TABLE public.orders
  ALTER COLUMN total_amount SET NOT NULL;

-- 6. Backfill shipping_address with default value if null
UPDATE public.orders
SET shipping_address = '{"firstName":"","lastName":"","address":"","city":"Amsterdam","postalCode":"","email":""}'::jsonb
WHERE shipping_address IS NULL;

-- 7. Make shipping_address NOT NULL (after backfill)
ALTER TABLE public.orders
  ALTER COLUMN shipping_address SET NOT NULL;

-- 8. Backfill price_at_time from price if null
UPDATE public.order_items
SET price_at_time = price
WHERE price_at_time IS NULL AND price IS NOT NULL;

-- 9. Make price_at_time NOT NULL (after backfill)
ALTER TABLE public.order_items
  ALTER COLUMN price_at_time SET NOT NULL;

-- 10. Make size_ml NOT NULL in order_items (after ensuring data exists)
-- First backfill with default value if null
UPDATE public.order_items oi
SET size_ml = COALESCE(pv.size_ml, 0)
FROM public.product_variants pv
WHERE oi.product_variant_id = pv.id
AND oi.size_ml IS NULL;

-- If any still null (no variant found), set to 0
UPDATE public.order_items
SET size_ml = 0
WHERE size_ml IS NULL;

ALTER TABLE public.order_items
  ALTER COLUMN size_ml SET NOT NULL;

-- 11. Create trigger to sync total_amount with total_price
CREATE OR REPLACE FUNCTION public.sync_order_totals()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.total_amount IS NULL AND NEW.total_price IS NOT NULL THEN
    NEW.total_amount := NEW.total_price;
  ELSIF NEW.total_price IS NULL AND NEW.total_amount IS NOT NULL THEN
    NEW.total_price := NEW.total_amount;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS orders_sync_totals ON public.orders;
CREATE TRIGGER orders_sync_totals
  BEFORE INSERT OR UPDATE ON public.orders
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_order_totals();

-- 12. Notify PostgREST to reload schema
NOTIFY pgrst, 'reload schema';
