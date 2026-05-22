-- Quick fix: allow multiple products in cart (run if add-to-cart shows cart_user_id_key error)
ALTER TABLE public.cart DROP CONSTRAINT IF EXISTS cart_user_id_key;

DROP INDEX IF EXISTS cart_user_variant_unique;
CREATE UNIQUE INDEX cart_user_variant_unique
  ON public.cart (user_id, product_variant_id);

NOTIFY pgrst, 'reload schema';
