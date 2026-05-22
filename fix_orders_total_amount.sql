-- Run in Supabase SQL Editor
-- Fixes total_amount NOT NULL vs app using total_price

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS total_price DECIMAL(10, 2);

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS total_amount DECIMAL(10, 2);

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS shipping_address JSONB;

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS payment_status TEXT DEFAULT 'pending';

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS order_status TEXT DEFAULT 'pending';

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS stripe_session_id TEXT;

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS stripe_payment_intent_id TEXT;

-- Backfill missing totals
UPDATE public.orders
SET
  total_amount = COALESCE(total_amount, total_price, 0),
  total_price = COALESCE(total_price, total_amount, 0)
WHERE total_amount IS NULL OR total_price IS NULL;

-- Keep both columns in sync on insert/update
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

-- Payments table RLS for admin (if payments table exists)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'payments') THEN
    ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
    DROP POLICY IF EXISTS "Admins manage payments" ON public.payments;
    CREATE POLICY "Admins manage payments" ON public.payments FOR ALL USING (public.is_admin());
    DROP POLICY IF EXISTS "Users can view own payments" ON public.payments;
    CREATE POLICY "Users can view own payments" ON public.payments FOR SELECT USING (auth.uid() = user_id);
  END IF;
END $$;

NOTIFY pgrst, 'reload schema';
