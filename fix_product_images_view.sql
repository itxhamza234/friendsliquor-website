-- Fix product_details_view for admin + storefront (run in Supabase SQL Editor)
-- Maps product_name, premium, price_euro, total_quantity from admin saves.

DROP VIEW IF EXISTS public.product_details_view CASCADE;

CREATE OR REPLACE VIEW public.product_details_view AS
SELECT
    p.id AS product_id,
    p.slug AS product_slug,
    COALESCE(p.product_name, p.name) AS product_name,
    p.brand,
    p.description,
    COALESCE(p.premium, p.is_premium, false) AS premium,
    COALESCE(p.is_featured, p.featured, false) AS featured,
    COALESCE(
        p.image_url,
        p.image,
        (
            SELECT pv.image_url
            FROM public.product_variants pv
            WHERE pv.product_id = p.id AND pv.image_url IS NOT NULL
            LIMIT 1
        )
    ) AS image_url,
    5.00 AS rating,
    COALESCE(
        p.total_quantity,
        (
            SELECT COALESCE(SUM(COALESCE(pv.stock, pv.stock_quantity, 0)), 0)::integer
            FROM public.product_variants pv
            WHERE pv.product_id = p.id
        ),
        p.stock,
        0
    ) AS total_stock,
    p.created_at,
    c.id AS category_id,
    c.name AS category_name,
    c.slug AS category_slug,
    (
        SELECT json_agg(
            json_build_object(
                'id', pv.id,
                'variant_name', COALESCE(
                    NULLIF(TRIM(pv.size), ''),
                    CASE WHEN pv.size_ml IS NOT NULL THEN pv.size_ml::text || 'ml' ELSE 'Standard' END
                ),
                'size', COALESCE(
                    NULLIF(TRIM(pv.size), ''),
                    CASE WHEN pv.size_ml IS NOT NULL THEN pv.size_ml::text || 'ml' ELSE 'Standard' END
                ),
                'price_euro', COALESCE(pv.price_euro, pv.price, 0),
                'stock', COALESCE(pv.stock, pv.stock_quantity, 0),
                'sku', pv.sku
            )
            ORDER BY pv.size NULLS LAST
        )
        FROM public.product_variants pv
        WHERE pv.product_id = p.id
    ) AS variants
FROM public.products p
LEFT JOIN public.categories c ON p.category_id = c.id;

GRANT SELECT ON public.product_details_view TO anon, authenticated, service_role;

NOTIFY pgrst, 'reload schema';
