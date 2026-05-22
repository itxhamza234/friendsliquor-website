-- ==============================================================
-- MASSIVE SEED FILE: BRANDS, PRODUCTS, VARIANTS
-- Execute in Supabase SQL Editor
-- ==============================================================

DELETE FROM public.product_variants;
DELETE FROM public.products;

DO $$
DECLARE
  v_cat_whisky UUID;
  v_cat_vodka UUID;
  v_cat_gin UUID;
  v_cat_rum UUID;
  v_cat_tequila UUID;
  v_cat_dutch_gin_cognac UUID;
  v_cat_liqueurs_shots UUID;
  v_cat_champagne_sparkling UUID;
  v_cat_beer_brands UUID;
  v_cat_cans UUID;
  v_cat_seed_drinks_infused UUID;
  v_cat_soft_drinks UUID;
  v_cat_wines UUID;
  v_product_id UUID;
BEGIN

-- Insert Categories
  INSERT INTO public.categories (name, slug) VALUES ('WHISKY', 'whisky') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_whisky;
  INSERT INTO public.categories (name, slug) VALUES ('VODKA', 'vodka') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_vodka;
  INSERT INTO public.categories (name, slug) VALUES ('GIN', 'gin') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_gin;
  INSERT INTO public.categories (name, slug) VALUES ('RUM', 'rum') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_rum;
  INSERT INTO public.categories (name, slug) VALUES ('TEQUILA', 'tequila') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_tequila;
  INSERT INTO public.categories (name, slug) VALUES ('DUTCH GIN (GENEVER) & COGNAC', 'dutch-gin-genever-cognac') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_dutch_gin_cognac;
  INSERT INTO public.categories (name, slug) VALUES ('LIQUEURS / SHOTS', 'liqueurs-shots') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_liqueurs_shots;
  INSERT INTO public.categories (name, slug) VALUES ('CHAMPAGNE / SPARKLING', 'champagne-sparkling') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_champagne_sparkling;
  INSERT INTO public.categories (name, slug) VALUES ('BEER BRANDS', 'beer-brands') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_beer_brands;
  INSERT INTO public.categories (name, slug) VALUES ('CANS', 'cans') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_cans;
  INSERT INTO public.categories (name, slug) VALUES ('SEED DRINKS & INFUSED DRINKS', 'seed-drinks-infused') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_seed_drinks_infused;
  INSERT INTO public.categories (name, slug) VALUES ('SOFT DRINKS', 'soft-drinks') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_soft_drinks;
  INSERT INTO public.categories (name, slug) VALUES ('WINES', 'wines') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_cat_wines;

-- Insert Products and Variants
  -- Johnnie Walker Red Label
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Red Label', 'johnnie-walker-red-label', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 46.99, floor(random() * 50) + 10, 'johnnie-walker-red-label-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'johnnie-walker-red-label-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 24.77, floor(random() * 50) + 10, 'johnnie-walker-red-label-350ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 14.99, floor(random() * 50) + 10, 'johnnie-walker-red-label-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Red Label (Red Soul)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Red Label (Red Soul)', 'johnnie-walker-red-label-red-soul', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 35.99, floor(random() * 50) + 10, 'johnnie-walker-red-label-red-soul-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Black Label
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Black Label', 'johnnie-walker-black-label', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 69.99, floor(random() * 50) + 10, 'johnnie-walker-black-label-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'johnnie-walker-black-label-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 34.99, floor(random() * 50) + 10, 'johnnie-walker-black-label-350ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 24.99, floor(random() * 50) + 10, 'johnnie-walker-black-label-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Double Black
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Double Black', 'johnnie-walker-double-black', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 57.99, floor(random() * 50) + 10, 'johnnie-walker-double-black-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Green Label
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Green Label', 'johnnie-walker-green-label', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 89.99, floor(random() * 50) + 10, 'johnnie-walker-green-label-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Gold Label
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Gold Label', 'johnnie-walker-gold-label', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 94.99, floor(random() * 50) + 10, 'johnnie-walker-gold-label-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Blue Label
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Blue Label', 'johnnie-walker-blue-label', 'Johnnie Walker', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 329.99, floor(random() * 50) + 10, 'johnnie-walker-blue-label-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Old No. 7
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Old No. 7', 'jack-daniel-s-old-no-7', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 61.99, floor(random() * 50) + 10, 'jack-daniel-s-old-no-7-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 44.99, floor(random() * 50) + 10, 'jack-daniel-s-old-no-7-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 37.99, floor(random() * 50) + 10, 'jack-daniel-s-old-no-7-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 27.99, floor(random() * 50) + 10, 'jack-daniel-s-old-no-7-350ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 17.99, floor(random() * 50) + 10, 'jack-daniel-s-old-no-7-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Honey
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Honey', 'jack-daniel-s-honey', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 44.99, floor(random() * 50) + 10, 'jack-daniel-s-honey-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Apple
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Apple', 'jack-daniel-s-apple', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 44.99, floor(random() * 50) + 10, 'jack-daniel-s-apple-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Blackberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Blackberry', 'jack-daniel-s-blackberry', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 49.99, floor(random() * 50) + 10, 'jack-daniel-s-blackberry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Bold Spicy
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Bold Spicy', 'jack-daniel-s-bold-spicy', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 57.99, floor(random() * 50) + 10, 'jack-daniel-s-bold-spicy-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Sweet & Oaky
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Sweet & Oaky', 'jack-daniel-s-sweet-oaky', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 57.99, floor(random() * 50) + 10, 'jack-daniel-s-sweet-oaky-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Tennessee Straight
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Tennessee Straight', 'jack-daniel-s-tennessee-straight', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 44.99, floor(random() * 50) + 10, 'jack-daniel-s-tennessee-straight-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Tennessee Fire
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Tennessee Fire', 'jack-daniel-s-tennessee-fire', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 44.99, floor(random() * 50) + 10, 'jack-daniel-s-tennessee-fire-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Bonded
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Bonded', 'jack-daniel-s-bonded', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 74.99, floor(random() * 50) + 10, 'jack-daniel-s-bonded-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s McLXJD 2024 Edition
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'McLXJD 2024 Edition', 'jack-daniel-s-mclxjd-2024-edition', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'jack-daniel-s-mclxjd-2024-edition-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Single Barrel
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Single Barrel', 'jack-daniel-s-single-barrel', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 109.99, floor(random() * 50) + 10, 'jack-daniel-s-single-barrel-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Gentleman Jack Gentleman Jack
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Gentleman Jack', 'gentleman-jack-gentleman-jack', 'Gentleman Jack', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 59.99, floor(random() * 50) + 10, 'gentleman-jack-gentleman-jack-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal Chivas 12
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Chivas 12', 'chivas-regal-chivas-12', 'Chivas Regal', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 74.99, floor(random() * 50) + 10, 'chivas-regal-chivas-12-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 58.99, floor(random() * 50) + 10, 'chivas-regal-chivas-12-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 33.99, floor(random() * 50) + 10, 'chivas-regal-chivas-12-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal Chivas 18
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Chivas 18', 'chivas-regal-chivas-18', 'Chivas Regal', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 149.99, floor(random() * 50) + 10, 'chivas-regal-chivas-18-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal Mizunara
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Mizunara', 'chivas-regal-mizunara', 'Chivas Regal', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 99.99, floor(random() * 50) + 10, 'chivas-regal-mizunara-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal XV 15 Year Old
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'XV 15 Year Old', 'chivas-regal-xv-15-year-old', 'Chivas Regal', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 109.99, floor(random() * 50) + 10, 'chivas-regal-xv-15-year-old-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal Extra 13 Year Old
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Extra 13 Year Old', 'chivas-regal-extra-13-year-old', 'Chivas Regal', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 84.99, floor(random() * 50) + 10, 'chivas-regal-extra-13-year-old-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ballantine’s Finest
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Finest', 'ballantine-s-finest', 'Ballantine’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 37.99, floor(random() * 50) + 10, 'ballantine-s-finest-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ballantine’s 12
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '12', 'ballantine-s-12', 'Ballantine’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 74.99, floor(random() * 50) + 10, 'ballantine-s-12-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Bourbon
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Bourbon', 'jim-beam-bourbon', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 44.99, floor(random() * 50) + 10, 'jim-beam-bourbon-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'jim-beam-bourbon-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Apple
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Apple', 'jim-beam-apple', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'jim-beam-apple-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Peach
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Peach', 'jim-beam-peach', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'jim-beam-peach-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Honey
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Honey', 'jim-beam-honey', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'jim-beam-honey-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Sunshine
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Sunshine', 'jim-beam-sunshine', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'jim-beam-sunshine-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Black Cherry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Black Cherry', 'jim-beam-black-cherry', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'jim-beam-black-cherry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam RYE
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'RYE', 'jim-beam-rye', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 44.99, floor(random() * 50) + 10, 'jim-beam-rye-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jim Beam Black
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Black', 'jim-beam-black', 'Jim Beam', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 45.99, floor(random() * 50) + 10, 'jim-beam-black-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- J&B J&B
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'J&B', 'j-b-j-b', 'J&B', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 39.99, floor(random() * 50) + 10, 'j-b-j-b-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'j-b-j-b-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Glen Scanlan Glen Scanlan
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Glen Scanlan', 'glen-scanlan-glen-scanlan', 'Glen Scanlan', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 29.99, floor(random() * 50) + 10, 'glen-scanlan-glen-scanlan-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 24.99, floor(random() * 50) + 10, 'glen-scanlan-glen-scanlan-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 19.99, floor(random() * 50) + 10, 'glen-scanlan-glen-scanlan-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Glenfiddich Glenfiddich
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Glenfiddich', 'glenfiddich-glenfiddich', 'Glenfiddich', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 39.99, floor(random() * 50) + 10, 'glenfiddich-glenfiddich-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'glenfiddich-glenfiddich-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Four Roses Four Roses
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Four Roses', 'four-roses-four-roses', 'Four Roses', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 54.99, floor(random() * 50) + 10, 'four-roses-four-roses-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 39.99, floor(random() * 50) + 10, 'four-roses-four-roses-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Famous Grouse Famous Grouse
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Famous Grouse', 'famous-grouse-famous-grouse', 'Famous Grouse', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 41.99, floor(random() * 50) + 10, 'famous-grouse-famous-grouse-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 32.99, floor(random() * 50) + 10, 'famous-grouse-famous-grouse-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Label 5 Label 5
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Label 5', 'label-5-label-5', 'Label 5', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 25.99, floor(random() * 50) + 10, 'label-5-label-5-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 17.99, floor(random() * 50) + 10, 'label-5-label-5-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Teacher’s Teacher’s
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Teacher’s', 'teacher-s-teacher-s', 'Teacher’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 31.99, floor(random() * 50) + 10, 'teacher-s-teacher-s-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- VAT 69 VAT 69
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'VAT 69', 'vat-69-vat-69', 'VAT 69', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'vat-69-vat-69-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jagermeister Jagermeister
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_liqueurs_shots, 'Jagermeister', 'jagermeister-jagermeister', 'Jagermeister', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 38.99, floor(random() * 50) + 10, 'jagermeister-jagermeister-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'jagermeister-jagermeister-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 17.99, floor(random() * 50) + 10, 'jagermeister-jagermeister-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Blue Label Blended Scotch Whisky
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Blue Label Blended Scotch Whisky', 'johnnie-walker-blue-label-blended-scotch-whisky', 'Johnnie Walker', 'An exquisite premium luxury blend made from Scotland''s rarest and oldest single malt and grain whiskies. Only 1 in 10,000 casks meets this unparalleled standard. Delivers a remarkably velvety smooth character with honey, hazelnuts, and a signature gentle smoky finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 299.99, 1, 'johnnie-walker-blue-label-blended-scotch-whisky-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- The Macallan 12 Years Old Double Cask Single Malt
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '12 Years Old Double Cask Single Malt', 'the-macallan-12-years-old-double-cask-single-malt', 'The Macallan', 'A beautifully balanced Speyside single malt matured in a perfect combination of American and European oak casks seasoned with Oloroso sherry. Delivers classic creamy fudge, honeyed citrus, and rich warming spices.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 159.99, 1, 'the-macallan-12-years-old-double-cask-single-malt-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Royal Salute 21 Years Old x Harris Reed (The Fashion Collection - Purple Edition)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '21 Years Old x Harris Reed (The Fashion Collection - Purple Edition)', 'royal-salute-21-years-old-x-harris-reed-the-fashion-collection-purple-edition', 'Royal Salute', 'A prestigious, limited-edition blended Scotch whisky created in collaboration with celebrated fashion designer Harris Reed. Matured for a minimum of 21 years, it offers an incredibly rich and sweet profile filled with notes of red apples, rich honey, creamy toffee, and a whisper of warm kitchen spices, presented in a stunning theatrical purple bottle.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 199.99, 1, 'royal-salute-21-years-old-x-harris-reed-the-fashion-collection-purple-edition-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Royal Salute 21 Years Old x Harris Reed (The Fashion Collection - Gold Edition)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '21 Years Old x Harris Reed (The Fashion Collection - Gold Edition)', 'royal-salute-21-years-old-x-harris-reed-the-fashion-collection-gold-edition', 'Royal Salute', 'Part of the exclusive Fashion Collection collaboration with Harris Reed, this premium 21-year-old blended Scotch is housed in a striking gold feather-themed flagon. It delivers an extraordinarily smooth palate layered with notes of autumn fruits, sweet golden syrup, poached pears, and a wonderfully complex, long-lasting finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 199.99, 1, 'royal-salute-21-years-old-x-harris-reed-the-fashion-collection-gold-edition-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Royal Salute 21 Years Old - The Signature Blend (Kristjana S. Williams Edition)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '21 Years Old - The Signature Blend (Kristjana S. Williams Edition)', 'royal-salute-21-years-old-the-signature-blend-kristjana-s-williams-edition', 'Royal Salute', 'Royal Salute''s flagship and iconic blended Scotch whisky matured for at least 21 years. Housed in a sapphire blue flagon inside a premium gift box illustrated by award-winning fine artist Kristjana S. Williams, depicting the British Royal Menagerie.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 299.99, 2, 'royal-salute-21-years-old-the-signature-blend-kristjana-s-williams-edition-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Glenfiddich 18 Years Old Small Batch Single Malt
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '18 Years Old Small Batch Single Malt', 'glenfiddich-18-years-old-small-batch-single-malt', 'Glenfiddich', 'A distinguished single malt matured in finest Oloroso Sherry and Bourbon casks for 18 years. Married in small batches, it delivers an incredibly rich, elegant, and complex depth with notes of baked apple, cinnamon, and robust oak.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 199.99, 1, 'glenfiddich-18-years-old-small-batch-single-malt-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel's Single Barrel - Barrel Strength Tennessee Whiskey
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Single Barrel - Barrel Strength Tennessee Whiskey', 'jack-daniel-s-single-barrel-barrel-strength-tennessee-whiskey', 'Jack Daniel''s', 'An intense, high-proof premium Tennessee whiskey bottled straight from a single select barrel without dilution. Offers a bold and robust flavor profile balanced with sweet brown sugar, toasted oak, and deep vanilla.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 109.99, 1, 'jack-daniel-s-single-barrel-barrel-strength-tennessee-whiskey-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal 18 Years Old - The Gold Signature Blended Scotch
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '18 Years Old - The Gold Signature Blended Scotch', 'chivas-regal-18-years-old-the-gold-signature-blended-scotch', 'Chivas Regal', 'A uniquely rich and multi-layered blend created by Master Blender Colin Scott. Matured for 18 years, it features indulgent velvet notes of dark chocolate, dried autumn fruits, and buttery toffee.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 119.99, 1, 'chivas-regal-18-years-old-the-gold-signature-blended-scotch-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- The Dalmore 12 Years Old Highland Single Malt
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '12 Years Old Highland Single Malt', 'the-dalmore-12-years-old-highland-single-malt', 'The Dalmore', 'An outstanding Highland single malt aged initially in American white oak ex-bourbon casks and beautifully finished in rare Oloroso sherry butts. Complex and rich, delivering citrus fruits, chocolate, and warm aromatic spices.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 119.99, 1, 'the-dalmore-12-years-old-highland-single-malt-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Don Julio 1942 Añejo Tequila
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_tequila, '1942 Añejo Tequila', 'don-julio-1942-a-ejo-tequila', 'Don Julio', 'An internationally celebrated, ultra-premium Añejo tequila crafted from 100% Blue Agave. Handcrafted in small batches and aged for a minimum of two and a half years in American white oak barrels, offering unmatched notes of warm oak, vanilla, and roasted agave in an iconic elongated tall bottle.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 275, 1, 'don-julio-1942-a-ejo-tequila-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Glenfiddich 15 Years Old Distillery Edition Single Malt
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '15 Years Old Distillery Edition Single Malt', 'glenfiddich-15-years-old-distillery-edition-single-malt', 'Glenfiddich', 'A higher-strength, non-chill-filtered expression of Glenfiddich aged for 15 years in traditional American and Spanish oak casks. Rich, robust, and highly concentrated with distinct peppery spices and sweet floral notes.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 199.99, 1, 'glenfiddich-15-years-old-distillery-edition-single-malt-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Cognac Frapin V.I.P. XO Grande Champagne
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'V.I.P. XO Grande Champagne', 'cognac-frapin-v-i-p-xo-grande-champagne', 'Cognac Frapin', 'An exceptionally premium and exclusive XO Cognac crafted entirely from grapes grown in the premier Grande Champagne region of France. Aged over decades in historic family cellars, presented in a royal designer decanter with elegant chocolate, dried fruit, and rancio notes.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 279.99, 1, 'cognac-frapin-v-i-p-xo-grande-champagne-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Chivas Regal 25 Years Old - Original Legend Blended Scotch
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '25 Years Old - Original Legend Blended Scotch', 'chivas-regal-25-years-old-original-legend-blended-scotch', 'Chivas Regal', 'The world''s first luxury whisky blend, meticulously brought back as an iconic limited masterpiece. Every single whisky in this blend is aged for at least 25 years. Housed in an exclusive red velvet luxury case, providing spectacular notes of apricot, peach, and creamy milk chocolate.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 499.99, 1, 'chivas-regal-25-years-old-original-legend-blended-scotch-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker 18 Years Old Blended Scotch Whisky
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '18 Years Old Blended Scotch Whisky', 'johnnie-walker-18-years-old-blended-scotch-whisky', 'Johnnie Walker', 'A masterful blend of up to 18 different whiskies that have matured for a minimum of 18 years. Highly sophisticated and extraordinarily smooth, with fruit sweetness, dark caramel, toffee, and a delicate hint of smoke.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 149.99, 1, 'johnnie-walker-18-years-old-blended-scotch-whisky-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Johnnie Walker Gold Label Reserve Blended Scotch Whisky
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Gold Label Reserve Blended Scotch Whisky', 'johnnie-walker-gold-label-reserve-blended-scotch-whisky', 'Johnnie Walker', 'A luxurious and festive blend renowned for its creamy sweetness. Built around the prestigious Clynelish single malt, it unfolds rich layers of maple syrup, golden honey, vibrant fruits, and subtle wood notes.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 120, 1, 'johnnie-walker-gold-label-reserve-blended-scotch-whisky-1000ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 94.99, 1, 'johnnie-walker-gold-label-reserve-blended-scotch-whisky-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- The GlenDronach Port Wood Highland Single Malt
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Port Wood Highland Single Malt', 'the-glendronach-port-wood-highland-single-malt', 'The GlenDronach', 'An exquisite Highland single malt distilled in traditional sherry casks and subsequently finished in the finest Port pipes from Portugal. Imparts a majestic deep ruby color and an intense flavor of baked plums, wild berries, and ginger spice.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 130, 1, 'the-glendronach-port-wood-highland-single-malt-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ballantine's 21 Years Old Blended Scotch Whisky
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, '21 Years Old Blended Scotch Whisky', 'ballantine-s-21-years-old-blended-scotch-whisky', 'Ballantine''s', 'An highly acclaimed, premium blended Scotch matured for over two decades. Possesses an aromatic, highly balanced profile of red apple, sweet liquorice, and aromatic spices with a prolonged, warm finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 189.99, 1, 'ballantine-s-21-years-old-blended-scotch-whisky-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Glen Scanlan Reserve Blended Scotch Whisky
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Reserve Blended Scotch Whisky', 'glen-scanlan-reserve-blended-scotch-whisky', 'Glen Scanlan', 'A classic blended Scotch whisky matured in oak casks, presented in a magnificent extra-large display bottle. It offers a smooth and approachable character with a traditional harmony of malt and grain whiskies, featuring light peat, honeyed sweetness, and subtle oak undertones.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 4500, 134.99, 1, 'glen-scanlan-reserve-blended-scotch-whisky-4500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Gérard Bertrand L'Hospitalitas La Clape 2020
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'L''Hospitalitas La Clape 2020', 'g-rard-bertrand-l-hospitalitas-la-clape-2020', 'Gérard Bertrand', 'A prestigious and powerful red wine from the Sud de France. This exceptional blend boasts an intense, complex bouquet of ripe dark fruits, spices, and elegant roasted notes, offering a full-bodied texture with fine tannins and a long, luxurious finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 119.99, 1, 'g-rard-bertrand-l-hospitalitas-la-clape-2020-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château Lafon-Rochet Saint-Estèphe 2019
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Saint-Estèphe 2019', 'ch-teau-lafon-rochet-saint-est-phe-2019', 'Château Lafon-Rochet', 'A classic Grand Cru Classé red Bordeaux wine from the renowned Saint-Estèphe appellation. The 2019 vintage showcases an elegant and highly structured profile filled with deep expressions of blackcurrant, cedarwood, and earthy minerals, supported by firm yet refined tannins.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 99.99, 1, 'ch-teau-lafon-rochet-saint-est-phe-2019-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Tamnavulin Sherry Cask Edition
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_whisky, 'Sherry Cask Edition', 'tamnavulin-sherry-cask-edition', 'Tamnavulin', 'A rich and inviting Speyside single malt whisky that has been matured in American oak barrels and expertly finished in three different types of sherry casks. It treats the palate to a sweet and smooth taste profile dominated by raisins, vanilla, and a warm hint of Christmas cake spices.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 57.99, 1, 'tamnavulin-sherry-cask-edition-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château de Terrefort-Quancard Bordeaux Supérieur 2015
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Bordeaux Supérieur 2015', 'ch-teau-de-terrefort-quancard-bordeaux-sup-rieur-2015', 'Château de Terrefort-Quancard', 'An elegant, well-aged Bordeaux Supérieur from an exceptional 2015 vintage. This red wine features an appealing ruby color with an aromatic bouquet of red berries, subtle oak integration, and mild spices, providing a smooth and well-rounded drinking experience.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 79.99, 1, 'ch-teau-de-terrefort-quancard-bordeaux-sup-rieur-2015-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château Carbonnieux Grand Cru Classé de Graves 2021
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Grand Cru Classé de Graves 2021', 'ch-teau-carbonnieux-grand-cru-class-de-graves-2021', 'Château Carbonnieux', 'A highly celebrated Pessac-Léognan Grand Cru Classé white wine. It offers an incredibly fresh, crisp, and aromatic profile packed with notes of citrus, white peach, flinty minerality, and a wonderfully vibrant acidity that makes it exceptionally refreshing on the palate.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 89.99, 1, 'ch-teau-carbonnieux-grand-cru-class-de-graves-2021-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Baron Nathaniel Pauillac 2015
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Pauillac 2015', 'baron-nathaniel-pauillac-2015', 'Baron Nathaniel', 'A premium Pauillac red wine paying tribute to the historic Rothschild heritage. This 2015 vintage delivers a deeply intense palate rich in black fruits, subtle tobacco, leather, and oak spices, tightly bound by a robust structure and a complex, elegant finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 39.99, 1, 'baron-nathaniel-pauillac-2015-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château Gloria Saint-Julien 2021
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Saint-Julien 2021', 'ch-teau-gloria-saint-julien-2021', 'Château Gloria', 'A highly esteemed red Bordeaux from the historic Saint-Julien appellation. The 2021 vintage boasts a vibrant and expressive character filled with juicy black fruits, liquorice, and elegant earthy undertones, balanced perfectly by refined tannins and a fresh acidity.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 99.99, 1, 'ch-teau-gloria-saint-julien-2021-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château Capet-Guillier Saint-Émilion Grand Cru 2015
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Saint-Émilion Grand Cru 2015', 'ch-teau-capet-guillier-saint-milion-grand-cru-2015', 'Château Capet-Guillier', 'A premium Saint-Émilion Grand Cru produced by Antoine Moueix. Originating from the exceptional 2015 vintage, this Merlot-dominant blend offers a plush texture with layers of dark plum, black cherry, subtle tobacco, and a long, velvety finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 99.99, 1, 'ch-teau-capet-guillier-saint-milion-grand-cru-2015-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château Giscours Margaux 2019
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Margaux 2019', 'ch-teau-giscours-margaux-2019', 'Château Giscours', 'A spectacular Grand Cru Classé red wine from the prestigious Margaux appellation. This 2019 vintage delivers outstanding aromatic complexity, featuring dark chocolate, ripe blackberries, cedar wood, and a luxurious, full-bodied structure that will age beautifully.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 159.99, 1, 'ch-teau-giscours-margaux-2019-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château Talbot Saint-Julien 2020
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Saint-Julien 2020', 'ch-teau-talbot-saint-julien-2020', 'Château Talbot', 'A classic and powerful Fourth Growth Grand Cru Classé wine from Saint-Julien. The 2020 vintage showcases incredible depth and concentration, marked by robust flavors of cassis, leather, smoke, and fine-grained tannins that lead into a very persistent finish.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 179.99, 1, 'ch-teau-talbot-saint-julien-2020-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Château d'Issan Margaux 2019
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_wines, 'Margaux 2019', 'ch-teau-d-issan-margaux-2019', 'Château d''Issan', 'A historic Third Growth Grand Cru Classé from Margaux. This 2019 bottling is renowned for its quintessential elegance and silkiness, offering an exquisite bouquet of fresh violets, red currants, sweet spices, and a beautifully balanced mineral core.', true, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 149.99, 1, 'ch-teau-d-issan-margaux-2019-750ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Normal', 'absolut-vodka-normal', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 41.99, floor(random() * 50) + 10, 'absolut-vodka-normal-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-normal-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 27.99, floor(random() * 50) + 10, 'absolut-vodka-normal-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 19.99, floor(random() * 50) + 10, 'absolut-vodka-normal-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Sensations
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Sensations', 'absolut-vodka-sensations', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-sensations-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Raspberri
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Raspberri', 'absolut-vodka-raspberri', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-raspberri-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Citron
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Citron', 'absolut-vodka-citron', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-citron-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Passionfruit
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Passionfruit', 'absolut-vodka-passionfruit', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-passionfruit-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Lime
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Lime', 'absolut-vodka-lime', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-lime-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Warhol Edition
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Warhol Edition', 'absolut-vodka-warhol-edition', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-warhol-edition-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Vodka Vanilla
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Vanilla', 'absolut-vodka-vanilla', 'Absolut Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'absolut-vodka-vanilla-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Normal', 'smirnoff-normal', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 39.99, floor(random() * 50) + 10, 'smirnoff-normal-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'smirnoff-normal-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 19.99, floor(random() * 50) + 10, 'smirnoff-normal-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 11.99, floor(random() * 50) + 10, 'smirnoff-normal-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Peach
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Peach', 'smirnoff-peach', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'smirnoff-peach-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Raspberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Raspberry', 'smirnoff-raspberry', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'smirnoff-raspberry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Mango
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Mango', 'smirnoff-mango', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'smirnoff-mango-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff North
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'North', 'smirnoff-north', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'smirnoff-north-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Small Batch Vodka
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Small Batch Vodka', 'smirnoff-small-batch-vodka', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'smirnoff-small-batch-vodka-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Vanilla
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Vanilla', 'smirnoff-vanilla', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'smirnoff-vanilla-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grey Goose Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Normal', 'grey-goose-normal', 'Grey Goose', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 79.99, floor(random() * 50) + 10, 'grey-goose-normal-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 41.99, floor(random() * 50) + 10, 'grey-goose-normal-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grey Goose La Poire
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'La Poire', 'grey-goose-la-poire', 'Grey Goose', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 79.99, floor(random() * 50) + 10, 'grey-goose-la-poire-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grey Goose Le Citron
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Le Citron', 'grey-goose-le-citron', 'Grey Goose', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 79.99, floor(random() * 50) + 10, 'grey-goose-le-citron-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grey Goose L'Orange
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'L''Orange', 'grey-goose-l-orange', 'Grey Goose', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 79.99, floor(random() * 50) + 10, 'grey-goose-l-orange-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grey Goose Peach & Rosemary
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Peach & Rosemary', 'grey-goose-peach-rosemary', 'Grey Goose', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 94.99, floor(random() * 50) + 10, 'grey-goose-peach-rosemary-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Normal', 'au-vodka-normal', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-normal-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Juicy Peach
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Juicy Peach', 'au-vodka-juicy-peach', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-juicy-peach-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Black Grape
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Black Grape', 'au-vodka-black-grape', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-black-grape-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Blue Raspberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Blue Raspberry', 'au-vodka-blue-raspberry', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-blue-raspberry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Watermelon
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Watermelon', 'au-vodka-watermelon', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-watermelon-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Strawberry Burst
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Strawberry Burst', 'au-vodka-strawberry-burst', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-strawberry-burst-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Fruit
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Fruit', 'au-vodka-fruit', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-fruit-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Pineapple Crush
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Pineapple Crush', 'au-vodka-pineapple-crush', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-pineapple-crush-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Bubble Gum
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Bubble Gum', 'au-vodka-bubble-gum', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-bubble-gum-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Cosmic Berries
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Cosmic Berries', 'au-vodka-cosmic-berries', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-cosmic-berries-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- AU Vodka Pink Lemonade
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Pink Lemonade', 'au-vodka-pink-lemonade', 'AU Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'au-vodka-pink-lemonade-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Normal', 'ciroc-vodka-normal', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-normal-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Apple
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Apple', 'ciroc-vodka-apple', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-apple-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Peach
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Peach', 'ciroc-vodka-peach', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-peach-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Pineapple
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Pineapple', 'ciroc-vodka-pineapple', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-pineapple-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Coconut
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Coconut', 'ciroc-vodka-coconut', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-coconut-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Summer Citrus
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Summer Citrus', 'ciroc-vodka-summer-citrus', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-summer-citrus-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Mango
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Mango', 'ciroc-vodka-mango', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-mango-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Summer Watermelon
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Summer Watermelon', 'ciroc-vodka-summer-watermelon', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-summer-watermelon-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ciroc Vodka Red Berry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Red Berry', 'ciroc-vodka-red-berry', 'Ciroc Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 61.99, floor(random() * 50) + 10, 'ciroc-vodka-red-berry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Finlandia Finlandia
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Finlandia', 'finlandia-finlandia', 'Finlandia', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 39.99, floor(random() * 50) + 10, 'finlandia-finlandia-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'finlandia-finlandia-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- POLIAKOV POLIAKOV
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'POLIAKOV', 'poliakov-poliakov', 'POLIAKOV', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 23.99, floor(random() * 50) + 10, 'poliakov-poliakov-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 17.99, floor(random() * 50) + 10, 'poliakov-poliakov-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 11.99, floor(random() * 50) + 10, 'poliakov-poliakov-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- ESBJAERG ESBJAERG
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'ESBJAERG', 'esbjaerg-esbjaerg', 'ESBJAERG', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 34.99, floor(random() * 50) + 10, 'esbjaerg-esbjaerg-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 19.99, floor(random() * 50) + 10, 'esbjaerg-esbjaerg-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 9.99, floor(random() * 50) + 10, 'esbjaerg-esbjaerg-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- SKYY Vodka SKYY Vodka
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'SKYY Vodka', 'skyy-vodka-skyy-vodka', 'SKYY Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 29.99, floor(random() * 50) + 10, 'skyy-vodka-skyy-vodka-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Tito’s Vodka Tito’s Vodka
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Tito’s Vodka', 'tito-s-vodka-tito-s-vodka', 'Tito’s Vodka', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 51.99, floor(random() * 50) + 10, 'tito-s-vodka-tito-s-vodka-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 41.99, floor(random() * 50) + 10, 'tito-s-vodka-tito-s-vodka-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Puschkin Puschkin
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Puschkin', 'puschkin-puschkin', 'Puschkin', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 31.99, floor(random() * 50) + 10, 'puschkin-puschkin-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 22.99, floor(random() * 50) + 10, 'puschkin-puschkin-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Puschkin Amorelie
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_vodka, 'Amorelie', 'puschkin-amorelie', 'Puschkin', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 22.99, floor(random() * 50) + 10, 'puschkin-amorelie-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bombay Sapphire Bombay Sapphire
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Bombay Sapphire', 'bombay-sapphire-bombay-sapphire', 'Bombay Sapphire', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 54.99, floor(random() * 50) + 10, 'bombay-sapphire-bombay-sapphire-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 42.99, floor(random() * 50) + 10, 'bombay-sapphire-bombay-sapphire-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 34.99, floor(random() * 50) + 10, 'bombay-sapphire-bombay-sapphire-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bombay Sapphire East
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'East', 'bombay-sapphire-east', 'Bombay Sapphire', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 42.99, floor(random() * 50) + 10, 'bombay-sapphire-east-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bombay Sapphire Premier
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Premier', 'bombay-sapphire-premier', 'Bombay Sapphire', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 59.99, floor(random() * 50) + 10, 'bombay-sapphire-premier-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Star of Bombay Star of Bombay
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Star of Bombay', 'star-of-bombay-star-of-bombay', 'Star of Bombay', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 54.99, floor(random() * 50) + 10, 'star-of-bombay-star-of-bombay-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bombay Sapphire Sunset
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Sunset', 'bombay-sapphire-sunset', 'Bombay Sapphire', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 49.99, floor(random() * 50) + 10, 'bombay-sapphire-sunset-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Still Gin Still Gin
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Still Gin', 'still-gin-still-gin', 'Still Gin', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 54.99, floor(random() * 50) + 10, 'still-gin-still-gin-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Monkey 47 Monkey 47
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Monkey 47', 'monkey-47-monkey-47', 'Monkey 47', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 69.99, floor(random() * 50) + 10, 'monkey-47-monkey-47-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Hendrick’s Hendrick’s
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Hendrick’s', 'hendrick-s-hendrick-s', 'Hendrick’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 79.99, floor(random() * 50) + 10, 'hendrick-s-hendrick-s-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 64.99, floor(random() * 50) + 10, 'hendrick-s-hendrick-s-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 44.5, floor(random() * 50) + 10, 'hendrick-s-hendrick-s-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Beefeater Beefeater
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Beefeater', 'beefeater-beefeater', 'Beefeater', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 44.99, floor(random() * 50) + 10, 'beefeater-beefeater-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'beefeater-beefeater-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Beefeater Strawberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'Strawberry', 'beefeater-strawberry', 'Beefeater', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 34.99, floor(random() * 50) + 10, 'beefeater-strawberry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Tanqueray London Dry Gin
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_gin, 'London Dry Gin', 'tanqueray-london-dry-gin', 'Tanqueray', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 53.99, floor(random() * 50) + 10, 'tanqueray-london-dry-gin-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 35.99, floor(random() * 50) + 10, 'tanqueray-london-dry-gin-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 22.99, floor(random() * 50) + 10, 'tanqueray-london-dry-gin-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi White / Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'White / Normal', 'bacardi-white-normal', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 41.99, floor(random() * 50) + 10, 'bacardi-white-normal-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'bacardi-white-normal-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 21.99, floor(random() * 50) + 10, 'bacardi-white-normal-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 17.99, floor(random() * 50) + 10, 'bacardi-white-normal-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Limon
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Limon', 'bacardi-limon', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 38.99, floor(random() * 50) + 10, 'bacardi-limon-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-limon-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Tropical
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Tropical', 'bacardi-tropical', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-tropical-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Punch
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Punch', 'bacardi-punch', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-punch-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Coconut
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Coconut', 'bacardi-coconut', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-coconut-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Mojito
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Mojito', 'bacardi-mojito', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-mojito-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Passionfruit
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Passionfruit', 'bacardi-passionfruit', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-passionfruit-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Carta Negra
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Carta Negra', 'bacardi-carta-negra', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 41.99, floor(random() * 50) + 10, 'bacardi-carta-negra-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 32.99, floor(random() * 50) + 10, 'bacardi-carta-negra-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Anejo
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Anejo', 'bacardi-anejo', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 54.99, floor(random() * 50) + 10, 'bacardi-anejo-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 41.99, floor(random() * 50) + 10, 'bacardi-anejo-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Spiced
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Spiced', 'bacardi-spiced', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 39.99, floor(random() * 50) + 10, 'bacardi-spiced-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 28.99, floor(random() * 50) + 10, 'bacardi-spiced-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Captain Morgan Captain Morgan
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Captain Morgan', 'captain-morgan-captain-morgan', 'Captain Morgan', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 39.99, floor(random() * 50) + 10, 'captain-morgan-captain-morgan-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'captain-morgan-captain-morgan-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Captain Morgan White Rum
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'White Rum', 'captain-morgan-white-rum', 'Captain Morgan', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'captain-morgan-white-rum-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Old Captain Old Captain
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Old Captain', 'old-captain-old-captain', 'Old Captain', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 36.99, floor(random() * 50) + 10, 'old-captain-old-captain-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 27.99, floor(random() * 50) + 10, 'old-captain-old-captain-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Havana Club Havana Club
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_rum, 'Havana Club', 'havana-club-havana-club', 'Havana Club', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 41.99, floor(random() * 50) + 10, 'havana-club-havana-club-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 35.99, floor(random() * 50) + 10, 'havana-club-havana-club-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- José Cuervo José Cuervo
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_tequila, 'José Cuervo', 'jos-cuervo-jos-cuervo', 'José Cuervo', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 54.99, floor(random() * 50) + 10, 'jos-cuervo-jos-cuervo-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 45.99, floor(random() * 50) + 10, 'jos-cuervo-jos-cuervo-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Sierra Tequila Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_tequila, 'Standard', 'sierra-tequila-standard', 'Sierra Tequila', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 29.99, floor(random() * 50) + 10, 'sierra-tequila-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Patrón Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_tequila, 'Standard', 'patr-n-standard', 'Patrón', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 89.99, floor(random() * 50) + 10, 'patr-n-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Don Julio Don Julio
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_tequila, 'Don Julio', 'don-julio-don-julio', 'Don Julio', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 109, floor(random() * 50) + 10, 'don-julio-don-julio-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Tiscaz Tiscaz
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_tequila, 'Tiscaz', 'tiscaz-tiscaz', 'Tiscaz', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 43.99, floor(random() * 50) + 10, 'tiscaz-tiscaz-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ketel 1 Original Ketel 1 Original
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'Ketel 1 Original', 'ketel-1-original-ketel-1-original', 'Ketel 1 Original', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 32.99, floor(random() * 50) + 10, 'ketel-1-original-ketel-1-original-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 19.99, floor(random() * 50) + 10, 'ketel-1-original-ketel-1-original-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bol’s Corenwijn 2 Jaar Vatgerijpt Bol’s Corenwijn 2 Jaar Vatgerijpt
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'Bol’s Corenwijn 2 Jaar Vatgerijpt', 'bol-s-corenwijn-2-jaar-vatgerijpt-bol-s-corenwijn-2-jaar-vatgerijpt', 'Bol’s Corenwijn 2 Jaar Vatgerijpt', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 54.99, floor(random() * 50) + 10, 'bol-s-corenwijn-2-jaar-vatgerijpt-bol-s-corenwijn-2-jaar-vatgerijpt-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 29.99, floor(random() * 50) + 10, 'bol-s-corenwijn-2-jaar-vatgerijpt-bol-s-corenwijn-2-jaar-vatgerijpt-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bol’s Jonge
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'Jonge', 'bol-s-jonge', 'Bol’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 31.99, floor(random() * 50) + 10, 'bol-s-jonge-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Hope Jonge Hope Jonge
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'Hope Jonge', 'hope-jonge-hope-jonge', 'Hope Jonge', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 24.99, floor(random() * 50) + 10, 'hope-jonge-hope-jonge-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Hope Vieux Hope Vieux
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'Hope Vieux', 'hope-vieux-hope-vieux', 'Hope Vieux', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 26.99, floor(random() * 50) + 10, 'hope-vieux-hope-vieux-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Oude Genever 5 Jaar Vat Gelagerd (Blue)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, '5 Jaar Vat Gelagerd (Blue)', 'oude-genever-5-jaar-vat-gelagerd-blue', 'Oude Genever', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 34.99, floor(random() * 50) + 10, 'oude-genever-5-jaar-vat-gelagerd-blue-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Oude Genever 5 Jaar Vat Gelagerd (Red)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, '5 Jaar Vat Gelagerd (Red)', 'oude-genever-5-jaar-vat-gelagerd-red', 'Oude Genever', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 34.99, floor(random() * 50) + 10, 'oude-genever-5-jaar-vat-gelagerd-red-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Oude Genever 5 Jaar Vat Gelagerd (Gray)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, '5 Jaar Vat Gelagerd (Gray)', 'oude-genever-5-jaar-vat-gelagerd-gray', 'Oude Genever', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 34.99, floor(random() * 50) + 10, 'oude-genever-5-jaar-vat-gelagerd-gray-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Oude Genever 5 Jaar Vat Gelagerd (Black)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, '5 Jaar Vat Gelagerd (Black)', 'oude-genever-5-jaar-vat-gelagerd-black', 'Oude Genever', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 34.99, floor(random() * 50) + 10, 'oude-genever-5-jaar-vat-gelagerd-black-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Oude Genever 3 Jaar Vat Gelagerd
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, '3 Jaar Vat Gelagerd', 'oude-genever-3-jaar-vat-gelagerd', 'Oude Genever', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 64.99, floor(random() * 50) + 10, 'oude-genever-3-jaar-vat-gelagerd-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Hennessy Very Special
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_dutch_gin_cognac, 'Very Special', 'hennessy-very-special', 'Hennessy', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 99.99, floor(random() * 50) + 10, 'hennessy-very-special-1l')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 71.99, floor(random() * 50) + 10, 'hennessy-very-special-700ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 44.99, floor(random() * 50) + 10, 'hennessy-very-special-350ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 200, 22.99, floor(random() * 50) + 10, 'hennessy-very-special-200ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Buzzball Red
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_liqueurs_shots, 'Red', 'buzzball-red', 'Buzzball', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 8, floor(random() * 50) + 10, 'buzzball-red-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Buzzball White
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_liqueurs_shots, 'White', 'buzzball-white', 'Buzzball', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 8, floor(random() * 50) + 10, 'buzzball-white-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Buzzball Yellow
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_liqueurs_shots, 'Yellow', 'buzzball-yellow', 'Buzzball', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 8, floor(random() * 50) + 10, 'buzzball-yellow-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Buzzball Orange
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_liqueurs_shots, 'Orange', 'buzzball-orange', 'Buzzball', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 8, floor(random() * 50) + 10, 'buzzball-orange-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Moët & Chandon Moët & Chandon
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Moët & Chandon', 'mo-t-chandon-mo-t-chandon', 'Moët & Chandon', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 94.99, floor(random() * 50) + 10, 'mo-t-chandon-mo-t-chandon-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Veuve Clicquot Veuve Clicquot
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Veuve Clicquot', 'veuve-clicquot-veuve-clicquot', 'Veuve Clicquot', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 59.99, floor(random() * 50) + 10, 'veuve-clicquot-veuve-clicquot-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Piper Heidsieck Piper Heidsieck
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Piper Heidsieck', 'piper-heidsieck-piper-heidsieck', 'Piper Heidsieck', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 99.99, floor(random() * 50) + 10, 'piper-heidsieck-piper-heidsieck-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bernard Bijotat Bernard Bijotat
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Bernard Bijotat', 'bernard-bijotat-bernard-bijotat', 'Bernard Bijotat', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 59.99, floor(random() * 50) + 10, 'bernard-bijotat-bernard-bijotat-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Freixenet Freixenet
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Freixenet', 'freixenet-freixenet', 'Freixenet', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 19.99, floor(random() * 50) + 10, 'freixenet-freixenet-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Martini Prosecco Martini Prosecco
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Martini Prosecco', 'martini-prosecco-martini-prosecco', 'Martini Prosecco', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 19.99, floor(random() * 50) + 10, 'martini-prosecco-martini-prosecco-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Asti Asti
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Asti', 'asti-asti', 'Asti', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 19.99, floor(random() * 50) + 10, 'asti-asti-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Pronol Prosecco Pronol Prosecco
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Pronol Prosecco', 'pronol-prosecco-pronol-prosecco', 'Pronol Prosecco', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 19.99, floor(random() * 50) + 10, 'pronol-prosecco-pronol-prosecco-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Prosecco Cuvee Prosecco Cuvee
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Prosecco Cuvee', 'prosecco-cuvee-prosecco-cuvee', 'Prosecco Cuvee', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 19.99, floor(random() * 50) + 10, 'prosecco-cuvee-prosecco-cuvee-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Prosecco Rose Prosecco Rose
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_champagne_sparkling, 'Prosecco Rose', 'prosecco-rose-prosecco-rose', 'Prosecco Rose', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 21.99, floor(random() * 50) + 10, 'prosecco-rose-prosecco-rose-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Heineken Can/Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Can/Bottle', 'heineken-can-bottle', 'Heineken', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'heineken-can-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 2.25, floor(random() * 50) + 10, 'heineken-can-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 2.75, floor(random() * 50) + 10, 'heineken-can-bottle-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Amstel Amstel
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Amstel', 'amstel-amstel', 'Amstel', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'amstel-amstel-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 2.25, floor(random() * 50) + 10, 'amstel-amstel-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grolsch Grolsch
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Grolsch', 'grolsch-grolsch', 'Grolsch', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'grolsch-grolsch-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 2.25, floor(random() * 50) + 10, 'grolsch-grolsch-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Grolsch Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Glass Bottle', 'grolsch-glass-bottle', 'Grolsch', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 4.75, floor(random() * 50) + 10, 'grolsch-glass-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 4, floor(random() * 50) + 10, 'grolsch-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Corona Corona
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Corona', 'corona-corona', 'Corona', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3.5, floor(random() * 50) + 10, 'corona-corona-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Hertog Jan Hertog Jan
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Hertog Jan', 'hertog-jan-hertog-jan', 'Hertog Jan', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'hertog-jan-hertog-jan-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 2.25, floor(random() * 50) + 10, 'hertog-jan-hertog-jan-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Brouwerij’TIJ Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Can', 'brouwerij-tij-can', 'Brouwerij’TIJ', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'brouwerij-tij-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Brouwerij’TIJ Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Glass Bottle', 'brouwerij-tij-glass-bottle', 'Brouwerij’TIJ', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'brouwerij-tij-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Guinness Guinness
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Guinness', 'guinness-guinness', 'Guinness', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 6, floor(random() * 50) + 10, 'guinness-guinness-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Guinness Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Glass Bottle', 'guinness-glass-bottle', 'Guinness', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 350, 6, floor(random() * 50) + 10, 'guinness-glass-bottle-350ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Desperados Red
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Red', 'desperados-red', 'Desperados', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 5, floor(random() * 50) + 10, 'desperados-red-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Desperados Original
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Original', 'desperados-original', 'Desperados', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 5, floor(random() * 50) + 10, 'desperados-original-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Desperados Mojito
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Mojito', 'desperados-mojito', 'Desperados', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 5, floor(random() * 50) + 10, 'desperados-mojito-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Desperados Red Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Red Glass Bottle', 'desperados-red-glass-bottle', 'Desperados', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'desperados-red-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Desperados Original Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Original Glass Bottle', 'desperados-original-glass-bottle', 'Desperados', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'desperados-original-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Desperados Mojito Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Mojito Glass Bottle', 'desperados-mojito-glass-bottle', 'Desperados', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'desperados-mojito-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Somersby Apple Mango & Lime
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Apple Mango & Lime', 'somersby-apple-mango-lime', 'Somersby', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 4, floor(random() * 50) + 10, 'somersby-apple-mango-lime-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Somersby Blackberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Blackberry', 'somersby-blackberry', 'Somersby', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 4, floor(random() * 50) + 10, 'somersby-blackberry-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Somersby Apple Mango & Lime Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Apple Mango & Lime Glass Bottle', 'somersby-apple-mango-lime-glass-bottle', 'Somersby', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'somersby-apple-mango-lime-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Somersby Blackberry Glass Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_beer_brands, 'Blackberry Glass Bottle', 'somersby-blackberry-glass-bottle', 'Somersby', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'somersby-blackberry-glass-bottle-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Black Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Black Can', 'smirnoff-black-can', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'smirnoff-black-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Original Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Original Can', 'smirnoff-original-can', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'smirnoff-original-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Tropical Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Tropical Can', 'smirnoff-tropical-can', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'smirnoff-tropical-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff Raspberry Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Raspberry Can', 'smirnoff-raspberry-can', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'smirnoff-raspberry-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Absolut Sprite 5% Vodka Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Sprite 5% Vodka Can', 'absolut-sprite-5-vodka-can', 'Absolut', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'absolut-sprite-5-vodka-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Normal Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Normal Can', 'jack-daniel-s-normal-can', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'jack-daniel-s-normal-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Jack Daniel’s Cherry Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Cherry Can', 'jack-daniel-s-cherry-can', 'Jack Daniel’s', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 5, floor(random() * 50) + 10, 'jack-daniel-s-cherry-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Whisky Cola
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Whisky Cola', 'lavish-whisky-cola', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5.5, floor(random() * 50) + 10, 'lavish-whisky-cola-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Mango
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Mango', 'lavish-mango', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-mango-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Strawberry Vanilla
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Strawberry Vanilla', 'lavish-strawberry-vanilla', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-strawberry-vanilla-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Grape
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Grape', 'lavish-grape', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-grape-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Mangorini
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Mangorini', 'lavish-mangorini', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-mangorini-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Orange Spritz
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Orange Spritz', 'lavish-orange-spritz', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-orange-spritz-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Fruit Punch
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Fruit Punch', 'lavish-fruit-punch', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-fruit-punch-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Purple Grape
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Purple Grape', 'lavish-purple-grape', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-purple-grape-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Blue Raspberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Blue Raspberry', 'lavish-blue-raspberry', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-blue-raspberry-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Passiontini
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Passiontini', 'lavish-passiontini', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-passiontini-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Raspberry Guava
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Raspberry Guava', 'lavish-raspberry-guava', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-raspberry-guava-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Cosmopolitan
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Cosmopolitan', 'lavish-cosmopolitan', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-cosmopolitan-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Green Apple
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Green Apple', 'lavish-green-apple', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-green-apple-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish Pineapple
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Pineapple', 'lavish-pineapple', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-pineapple-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish 10%
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, '10%', 'lavish-10', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-10-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish 17%
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, '17%', 'lavish-17', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-17-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lavish 21%
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, '21%', 'lavish-21', 'Lavish', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'lavish-21-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- STELZ Mango
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Mango', 'stelz-mango', 'STELZ', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'stelz-mango-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- STELZ Peach
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Peach', 'stelz-peach', 'STELZ', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'stelz-peach-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- STELZ Raspberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Raspberry', 'stelz-raspberry', 'STELZ', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'stelz-raspberry-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- STELZ Lime
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Lime', 'stelz-lime', 'STELZ', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 6, floor(random() * 50) + 10, 'stelz-lime-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Coca-Cola Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Coca-Cola Can', 'bacardi-coca-cola-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-coca-cola-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Razz & Up Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Razz & Up Can', 'bacardi-razz-up-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-razz-up-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Cuba Libre Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Cuba Libre Can', 'bacardi-cuba-libre-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-cuba-libre-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Tropical Breeze Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Tropical Breeze Can', 'bacardi-tropical-breeze-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-tropical-breeze-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Sunset Punch Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Sunset Punch Can', 'bacardi-sunset-punch-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-sunset-punch-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Limon & Lemonade Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Limon & Lemonade Can', 'bacardi-limon-lemonade-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-limon-lemonade-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Mojito Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Mojito Can', 'bacardi-mojito-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-mojito-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Bacardi Mango Mojito Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Mango Mojito Can', 'bacardi-mango-mojito-can', 'Bacardi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 250, 5, floor(random() * 50) + 10, 'bacardi-mango-mojito-can-250ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff 4% Original
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, '4% Original', 'smirnoff-4-original', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 9.99, floor(random() * 50) + 10, 'smirnoff-4-original-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff 4% Raspberry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, '4% Raspberry', 'smirnoff-4-raspberry', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 700, 9.99, floor(random() * 50) + 10, 'smirnoff-4-raspberry-700ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Smirnoff 4% (Flavor N/A)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, '4% (Flavor N/A)', 'smirnoff-4-flavor-n-a', 'Smirnoff', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 275, 4, floor(random() * 50) + 10, 'smirnoff-4-flavor-n-a-275ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Breezer Breezer
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_cans, 'Breezer', 'breezer-breezer', 'Breezer', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 275, 5, floor(random() * 50) + 10, 'breezer-breezer-275ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Cannabis Drinks Green Tea
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_seed_drinks_infused, 'Green Tea', 'cannabis-drinks-green-tea', 'Cannabis Drinks', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 6, floor(random() * 50) + 10, 'cannabis-drinks-green-tea-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Cannabis Drinks Energy Drink (Normal)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_seed_drinks_infused, 'Energy Drink (Normal)', 'cannabis-drinks-energy-drink-normal', 'Cannabis Drinks', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 6, floor(random() * 50) + 10, 'cannabis-drinks-energy-drink-normal-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Cannabis Drinks Energy Drink (Power Amsterdam)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_seed_drinks_infused, 'Energy Drink (Power Amsterdam)', 'cannabis-drinks-energy-drink-power-amsterdam', 'Cannabis Drinks', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 6, floor(random() * 50) + 10, 'cannabis-drinks-energy-drink-power-amsterdam-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Cannabis Drinks Energy Drink (Sostned)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_seed_drinks_infused, 'Energy Drink (Sostned)', 'cannabis-drinks-energy-drink-sostned', 'Cannabis Drinks', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 6, floor(random() * 50) + 10, 'cannabis-drinks-energy-drink-sostned-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Coca-Cola Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Can', 'coca-cola-can', 'Coca-Cola', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3, floor(random() * 50) + 10, 'coca-cola-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Coca-Cola Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Bottle', 'coca-cola-bottle', 'Coca-Cola', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'coca-cola-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 4.75, floor(random() * 50) + 10, 'coca-cola-bottle-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Coca-Cola Zero Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Can', 'coca-cola-zero-can', 'Coca-Cola Zero', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3, floor(random() * 50) + 10, 'coca-cola-zero-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Coca-Cola Zero Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Bottle', 'coca-cola-zero-bottle', 'Coca-Cola Zero', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'coca-cola-zero-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 4.75, floor(random() * 50) + 10, 'coca-cola-zero-bottle-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Pepsi Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Can', 'pepsi-can', 'Pepsi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3, floor(random() * 50) + 10, 'pepsi-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Pepsi Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Bottle', 'pepsi-bottle', 'Pepsi', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'pepsi-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 4.75, floor(random() * 50) + 10, 'pepsi-bottle-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Sprite Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Can', 'sprite-can', 'Sprite', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3, floor(random() * 50) + 10, 'sprite-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Sprite Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Bottle', 'sprite-bottle', 'Sprite', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'sprite-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 4.75, floor(random() * 50) + 10, 'sprite-bottle-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- 7UP Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Can', '7up-can', '7UP', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3, floor(random() * 50) + 10, '7up-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- 7UP Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Bottle', '7up-bottle', '7UP', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, '7up-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 4.75, floor(random() * 50) + 10, '7up-bottle-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Fanta (All Flavors) Can
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Can', 'fanta-all-flavors-can', 'Fanta (All Flavors)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 330, 3, floor(random() * 50) + 10, 'fanta-all-flavors-can-330ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Fanta (All Flavors) Bottle
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Bottle', 'fanta-all-flavors-bottle', 'Fanta (All Flavors)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'fanta-all-flavors-bottle-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 4.75, floor(random() * 50) + 10, 'fanta-all-flavors-bottle-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Original Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-original-standard', 'Red Bull Original', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-original-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Sugarfree / Zero Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-sugarfree-zero-standard', 'Red Bull Sugarfree / Zero', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.5, floor(random() * 50) + 10, 'red-bull-sugarfree-zero-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Watermelon (Red Edition) Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-watermelon-red-edition-standard', 'Red Bull Watermelon (Red Edition)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-watermelon-red-edition-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Tropical (Yellow Edition) Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-tropical-yellow-edition-standard', 'Red Bull Tropical (Yellow Edition)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-tropical-yellow-edition-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Blueberry (Blue Edition) Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-blueberry-blue-edition-standard', 'Red Bull Blueberry (Blue Edition)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-blueberry-blue-edition-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Coconut Berry Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-coconut-berry-standard', 'Red Bull Coconut Berry', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-coconut-berry-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Strawberry Apricot (Amber Edition) Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-strawberry-apricot-amber-edition-standard', 'Red Bull Strawberry Apricot (Amber Edition)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-strawberry-apricot-amber-edition-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Peach / White Peach Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-peach-white-peach-standard', 'Red Bull Peach / White Peach', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-peach-white-peach-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Dragon Fruit Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-dragon-fruit-standard', 'Red Bull Dragon Fruit', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-dragon-fruit-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Juneberry Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'red-bull-juneberry-standard', 'Red Bull Juneberry', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-juneberry-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Açaí (Purple Edition)
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Açaí (Purple Edition)', 'red-bull-a-a-purple-edition', 'Red Bull', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-a-a-purple-edition-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Wild Berry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Wild Berry', 'red-bull-wild-berry', 'Red Bull', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-wild-berry-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Fuji Apple & Ginger
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Fuji Apple & Ginger', 'red-bull-fuji-apple-ginger', 'Red Bull', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-fuji-apple-ginger-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Red Bull Iced Vanilla Berry
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Iced Vanilla Berry', 'red-bull-iced-vanilla-berry', 'Red Bull', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'red-bull-iced-vanilla-berry-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Tonic Water Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'tonic-water-standard', 'Tonic Water', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'tonic-water-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ginger Ale Bottle Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'ginger-ale-bottle-standard', 'Ginger Ale Bottle', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'ginger-ale-bottle-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Ginger Ale Can Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'ginger-ale-can-standard', 'Ginger Ale Can', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.25, floor(random() * 50) + 10, 'ginger-ale-can-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Soda Water Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'soda-water-standard', 'Soda Water', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 5, floor(random() * 50) + 10, 'soda-water-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Water Normal Water Normal
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Water Normal', 'water-normal-water-normal', 'Water Normal', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 2.5, floor(random() * 50) + 10, 'water-normal-water-normal-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 3.5, floor(random() * 50) + 10, 'water-normal-water-normal-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Water Sparkling Water Sparkling
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Water Sparkling', 'water-sparkling-water-sparkling', 'Water Sparkling', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 2.5, floor(random() * 50) + 10, 'water-sparkling-water-sparkling-500ml')
    ON CONFLICT (sku) DO NOTHING;
    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1500, 3.5, floor(random() * 50) + 10, 'water-sparkling-water-sparkling-1.5l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Dimes Juice (Orange) 1L
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, '1L', 'dimes-juice-orange-1l', 'Dimes Juice (Orange)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 5, floor(random() * 50) + 10, 'dimes-juice-orange-1l-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Dimes Juice (Apple) 1L
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, '1L', 'dimes-juice-apple-1l', 'Dimes Juice (Apple)', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 5, floor(random() * 50) + 10, 'dimes-juice-apple-1l-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Maaza Guava 500ml
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, '500ml', 'maaza-guava-500ml', 'Maaza Guava', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'maaza-guava-500ml-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Maaza Lychee 500ml
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, '500ml', 'maaza-lychee-500ml', 'Maaza Lychee', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 3.5, floor(random() * 50) + 10, 'maaza-lychee-500ml-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lipton Sparkling Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'lipton-sparkling-standard', 'Lipton Sparkling', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.5, floor(random() * 50) + 10, 'lipton-sparkling-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lipton Peach Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'lipton-peach-standard', 'Lipton Peach', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.5, floor(random() * 50) + 10, 'lipton-peach-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Lipton Lemon Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'lipton-lemon-standard', 'Lipton Lemon', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.5, floor(random() * 50) + 10, 'lipton-lemon-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- PowerADE Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'powerade-standard', 'PowerADE', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.25, floor(random() * 50) + 10, 'powerade-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Vitamin Water Limoen Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'vitamin-water-limoen-standard', 'Vitamin Water Limoen', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.75, floor(random() * 50) + 10, 'vitamin-water-limoen-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Vitamin Water Framboos Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'vitamin-water-framboos-standard', 'Vitamin Water Framboos', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.75, floor(random() * 50) + 10, 'vitamin-water-framboos-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Vitamin Water Citroen Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'vitamin-water-citroen-standard', 'Vitamin Water Citroen', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.75, floor(random() * 50) + 10, 'vitamin-water-citroen-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Vitamin Water Mango Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'vitamin-water-mango-standard', 'Vitamin Water Mango', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.75, floor(random() * 50) + 10, 'vitamin-water-mango-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Vitamin Water Peer Vlierbloesem Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'vitamin-water-peer-vlierbloesem-standard', 'Vitamin Water Peer Vlierbloesem', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 3.75, floor(random() * 50) + 10, 'vitamin-water-peer-vlierbloesem-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Capri-Sun Orange Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'capri-sun-orange-standard', 'Capri-Sun Orange', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 1.75, floor(random() * 50) + 10, 'capri-sun-orange-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Capri-Sun Cerise Standard
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, 'Standard', 'capri-sun-cerise-standard', 'Capri-Sun Cerise', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 750, 1.75, floor(random() * 50) + 10, 'capri-sun-cerise-standard-standard')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Coconut Water 1L
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, '1L', 'coconut-water-1l', 'Coconut Water', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 1000, 10, floor(random() * 50) + 10, 'coconut-water-1l-1l')
    ON CONFLICT (sku) DO NOTHING;
  END;

  -- Coconut Water 500ml
  DECLARE v_product_id UUID;
  BEGIN
    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)
    VALUES (v_cat_soft_drinks, '500ml', 'coconut-water-500ml', 'Coconut Water', '', false, true, true)
    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;

    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)
    VALUES (v_product_id, 500, 5, floor(random() * 50) + 10, 'coconut-water-500ml-500ml')
    ON CONFLICT (sku) DO NOTHING;
  END;

END $$;

-- Force schema cache refresh
NOTIFY pgrst, 'reload schema';
