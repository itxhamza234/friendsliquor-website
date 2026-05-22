-- ==============================================================================
-- LUXURY LIQUOR ECOMMERCE - SUPABASE POSTGRESQL SCHEMA (REAL BACKEND)
-- ==============================================================================

-- 1. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. CUSTOM TYPES
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('customer', 'admin', 'manager');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE order_status AS ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE payment_status AS ENUM ('pending', 'completed', 'failed', 'refunded');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 3. UTILITY FUNCTIONS
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ==============================================================================
-- 4. TABLES
-- ==============================================================================

-- 1. USERS
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address JSONB,
    role user_role DEFAULT 'customer',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. CATEGORIES
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    image TEXT,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. PRODUCTS
CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug TEXT UNIQUE NOT NULL,
    product_name TEXT NOT NULL,
    category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
    brand TEXT,
    description TEXT,
    premium BOOLEAN DEFAULT false,
    featured BOOLEAN DEFAULT false,
    image_url TEXT,
    rating DECIMAL(3,2) DEFAULT 0.00,
    stock INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. PRODUCT VARIANTS
CREATE TABLE IF NOT EXISTS public.product_variants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    variant_name TEXT,
    size TEXT NOT NULL, -- e.g., '1L', '700ml', '500ml', '200ml'
    price_euro DECIMAL(10,2) NOT NULL,
    stock INTEGER DEFAULT 0,
    sku TEXT UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. CART
CREATE TABLE IF NOT EXISTS public.cart (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    product_variant_id UUID REFERENCES public.product_variants(id) ON DELETE CASCADE,
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, product_variant_id)
);

-- 6. WISHLIST
CREATE TABLE IF NOT EXISTS public.wishlist (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, product_id)
);

-- 7. ORDERS
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE SET NULL,
    total_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_status payment_status DEFAULT 'pending',
    order_status order_status DEFAULT 'pending',
    shipping_address JSONB NOT NULL,
    stripe_session_id TEXT UNIQUE,
    stripe_payment_intent_id TEXT UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. ORDER ITEMS
CREATE TABLE IF NOT EXISTS public.order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
    product_variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    price_at_time DECIMAL(10,2) NOT NULL,
    size_ml INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. REVIEWS
CREATE TABLE IF NOT EXISTS public.reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    product_id UUID REFERENCES public.products(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, product_id)
);

-- 10. CONTACT MESSAGES
CREATE TABLE IF NOT EXISTS public.contact_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    message TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 11. ADMIN SETTINGS
CREATE TABLE IF NOT EXISTS public.admin_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    homepage_banners JSONB,
    featured_products JSONB,
    premium_collection_selections JSONB,
    contact_details JSONB,
    social_links JSONB,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 5. API VIEWS (CLEAN API STRUCTURE)
-- ==============================================================================
-- Reusable view for fetching a product with all its variants and category data natively
CREATE OR REPLACE VIEW public.product_details_view AS
SELECT 
    p.id as product_id,
    p.slug as product_slug,
    p.product_name,
    p.brand,
    p.description,
    p.premium,
    p.featured,
    p.image_url,
    p.rating,
    p.stock as total_stock,
    p.created_at,
    c.id as category_id,
    c.name as category_name,
    c.slug as category_slug,
    (
        SELECT json_agg(
            json_build_object(
                'id', pv.id,
                'variant_name', pv.variant_name,
                'size', pv.size,
                'price_euro', pv.price_euro,
                'stock', pv.stock,
                'sku', pv.sku
            )
        )
        FROM public.product_variants pv
        WHERE pv.product_id = p.id
    ) as variants
FROM public.products p
LEFT JOIN public.categories c ON p.category_id = c.id;

-- ==============================================================================
-- 6. TRIGGERS (Auto-update updated_at timestamp)
-- ==============================================================================
DROP TRIGGER IF EXISTS set_updated_at ON public.users;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON public.categories;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON public.products;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.products FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON public.product_variants;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.product_variants FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON public.orders;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON public.reviews;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_updated_at ON public.admin_settings;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.admin_settings FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

-- ==============================================================================
-- 7. AUTHENTICATION TRIGGER (Auto create user profile on signup)
-- ==============================================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.users (id, email, full_name, avatar_url)
  VALUES (
    new.id, 
    new.email, 
    new.raw_user_meta_data->>'full_name', 
    new.raw_user_meta_data->>'avatar_url'
  );
  
  RETURN new;
END;
$$ LANGUAGE plpgsql security definer;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- ==============================================================================
-- 8. INDEXES (For Performance & Scalability)
-- ==============================================================================
CREATE INDEX IF NOT EXISTS idx_products_category ON public.products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_brand ON public.products(brand);
CREATE INDEX IF NOT EXISTS idx_products_slug ON public.products(slug);
CREATE INDEX IF NOT EXISTS idx_variants_product ON public.product_variants(product_id);
CREATE INDEX IF NOT EXISTS idx_cart_user ON public.cart(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_user ON public.orders(user_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON public.order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_reviews_product ON public.reviews(product_id);

-- ==============================================================================
-- 9. ROW LEVEL SECURITY (RLS) POLICIES
-- ==============================================================================
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cart ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wishlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

-- Public read access for catalogs
CREATE POLICY "Public read active categories" ON public.categories FOR SELECT USING (true);
CREATE POLICY "Public read active products" ON public.products FOR SELECT USING (true);
CREATE POLICY "Public read variants" ON public.product_variants FOR SELECT USING (true);
CREATE POLICY "Public read reviews" ON public.reviews FOR SELECT USING (true);

-- Users manage their own data
CREATE POLICY "Users manage own profile" ON public.users FOR ALL USING (auth.uid() = id);
CREATE POLICY "Users manage own cart" ON public.cart FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users manage own wishlist" ON public.wishlist FOR ALL USING (auth.uid() = user_id);

-- Users can read their own orders
CREATE POLICY "Users read own orders" ON public.orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users read own order items" ON public.order_items FOR SELECT USING (
    order_id IN (SELECT id FROM public.orders WHERE user_id = auth.uid())
);

-- ==============================================================================
-- 10. SUPABASE STORAGE BUCKETS
-- ==============================================================================
-- Create storage buckets natively
INSERT INTO storage.buckets (id, name, public) VALUES ('product-images', 'product-images', true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('category-banners', 'category-banners', true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('homepage-sliders', 'homepage-sliders', true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('user-profile-images', 'user-profile-images', true) ON CONFLICT DO NOTHING;

-- Storage Policies
CREATE POLICY "Public Access product-images" ON storage.objects FOR SELECT USING (bucket_id = 'product-images');
CREATE POLICY "Public Access category-banners" ON storage.objects FOR SELECT USING (bucket_id = 'category-banners');
CREATE POLICY "Public Access homepage-sliders" ON storage.objects FOR SELECT USING (bucket_id = 'homepage-sliders');
CREATE POLICY "Public Access user-profile-images" ON storage.objects FOR SELECT USING (bucket_id = 'user-profile-images');

-- ==============================================================================
-- 11. SEED DATA (EXAMPLES)
-- ==============================================================================
-- Insert Core Categories
INSERT INTO public.categories (id, name, slug, description) VALUES 
('cat-00000000-0000-0000-0000-000000000001', 'Whiskey', 'whiskey', 'Premium selection of single malt and blended whiskeys.'),
('cat-00000000-0000-0000-0000-000000000002', 'Vodka', 'vodka', 'Finest clear spirits from around the world.'),
('cat-00000000-0000-0000-0000-000000000003', 'Gin', 'gin', 'Botanical infused spirits perfect for cocktails.'),
('cat-00000000-0000-0000-0000-000000000004', 'Rum', 'rum', 'Rich and smooth rums from the Caribbean.'),
('cat-00000000-0000-0000-0000-000000000005', 'Tequila', 'tequila', 'Authentic agave spirits from Mexico.'),
('cat-00000000-0000-0000-0000-000000000006', 'Cognac', 'cognac', 'Luxury French cognac.'),
('cat-00000000-0000-0000-0000-000000000007', 'Beer', 'beer', 'World-class ales, lagers, and stouts.'),
('cat-00000000-0000-0000-0000-000000000008', 'Champagne', 'champagne', 'Sparkling wines for celebration.'),
('cat-00000000-0000-0000-0000-000000000009', 'Genever', 'genever', 'Classic Dutch genever spirits.')
ON CONFLICT (slug) DO NOTHING;

-- Insert Normal Category Products
-- WHISKEY: Johnnie Walker, Jack Daniel's, Chivas Regal
INSERT INTO public.products (id, category_id, slug, product_name, brand, premium, featured, rating, stock) VALUES
('prod-00000000-0000-0000-0000-00000000001', 'cat-00000000-0000-0000-0000-000000000001', 'johnnie-walker-black-label', 'Johnnie Walker Black Label', 'Johnnie Walker', false, true, 4.8, 150),
('prod-00000000-0000-0000-0000-00000000002', 'cat-00000000-0000-0000-0000-000000000001', 'jack-daniels-old-no-7', 'Jack Daniel''s Old No. 7', 'Jack Daniel''s', false, true, 4.7, 200),
('prod-00000000-0000-0000-0000-00000000003', 'cat-00000000-0000-0000-0000-000000000001', 'chivas-regal-12', 'Chivas Regal 12 Year Old', 'Chivas Regal', false, false, 4.6, 120),
-- VODKA: Absolut, Grey Goose
('prod-00000000-0000-0000-0000-00000000004', 'cat-00000000-0000-0000-0000-000000000002', 'absolut-vodka', 'Absolut Vodka', 'Absolut', false, false, 4.5, 300),
('prod-00000000-0000-0000-0000-00000000005', 'cat-00000000-0000-0000-0000-000000000002', 'grey-goose-vodka', 'Grey Goose Vodka', 'Grey Goose', true, true, 4.9, 100),
-- GIN: Bombay Sapphire
('prod-00000000-0000-0000-0000-00000000006', 'cat-00000000-0000-0000-0000-000000000003', 'bombay-sapphire', 'Bombay Sapphire Gin', 'Bombay Sapphire', false, true, 4.7, 180),
-- RUM: Bacardi
('prod-00000000-0000-0000-0000-00000000007', 'cat-00000000-0000-0000-0000-000000000004', 'bacardi-carta-blanca', 'Bacardi Carta Blanca', 'Bacardi', false, false, 4.6, 250),
-- TEQUILA: Don Julio
('prod-00000000-0000-0000-0000-00000000008', 'cat-00000000-0000-0000-0000-000000000005', 'don-julio-blanco', 'Don Julio Blanco', 'Don Julio', true, true, 4.8, 90),
-- COGNAC: Hennessy
('prod-00000000-0000-0000-0000-00000000009', 'cat-00000000-0000-0000-0000-000000000006', 'hennessy-vs', 'Hennessy V.S', 'Hennessy', false, true, 4.7, 110)
ON CONFLICT (slug) DO NOTHING;

-- Insert Product Variants (Sizes, Pricing, Stock)
INSERT INTO public.product_variants (product_id, variant_name, size, price_euro, stock, sku) VALUES
-- Johnnie Walker Black Label (prod-1)
('prod-00000000-0000-0000-0000-00000000001', 'Standard Bottle', '700ml', 34.99, 100, 'JW-BLACK-700'),
('prod-00000000-0000-0000-0000-00000000001', 'Liter Bottle', '1L', 45.99, 50, 'JW-BLACK-1000'),
('prod-00000000-0000-0000-0000-00000000001', 'Miniature', '200ml', 12.99, 30, 'JW-BLACK-200'),
-- Jack Daniel's Old No. 7 (prod-2)
('prod-00000000-0000-0000-0000-00000000002', 'Standard Bottle', '700ml', 24.99, 150, 'JD-NO7-700'),
('prod-00000000-0000-0000-0000-00000000002', 'Liter Bottle', '1L', 32.99, 50, 'JD-NO7-1000'),
-- Absolut Vodka (prod-4)
('prod-00000000-0000-0000-0000-00000000004', 'Standard Bottle', '700ml', 18.99, 200, 'ABS-VODKA-700'),
('prod-00000000-0000-0000-0000-00000000004', 'Liter Bottle', '1L', 25.99, 100, 'ABS-VODKA-1000'),
-- Grey Goose (prod-5)
('prod-00000000-0000-0000-0000-00000000005', 'Standard Bottle', '700ml', 42.99, 80, 'GG-VODKA-700'),
('prod-00000000-0000-0000-0000-00000000005', 'Magnum', '1.5L', 89.99, 20, 'GG-VODKA-1500')
ON CONFLICT (sku) DO NOTHING;
