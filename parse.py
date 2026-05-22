import re

data = """
WHISKY / WHISKEY
——————————————————————————————————————————————————
Brand / Series: Johnnie Walker Series
Variant / Flavor Type	Size / Volume	Price
Red Label	1L	46.99/-
Red Label (Red Soul)	700ml	35.99/-
Red Label	700ml	34.99/-
Red Label	350ml	24.77/-
Red Label	200ml	14.99/-
Black Label	1L	69.99/-
Black Label	700ml	54.99/-
Black Label	350ml	34.99/-
Black Label	200ml	24.99/-
Double Black	700ml	57.99/-
Green Label	700ml	89.99/-
Gold Label	700ml	94.99/-
Blue Label	700ml	329.99/-

Brand / Series: Jack Daniel's Series
Variant / Flavor Type	Size / Volume	Price
Jack Daniel’s Old No. 7	1L	61.99/-
Jack Daniel’s Old No. 7	700ml	44.99/-
Jack Daniel’s Old No. 7	500ml	37.99/-
Jack Daniel’s Old No. 7	350ml	27.99/-
Jack Daniel’s Old No. 7	200ml	17.99/-
Jack Daniel’s Honey	700ml	44.99/-
Jack Daniel’s Apple	700ml	44.99/-
Jack Daniel’s Blackberry	700ml	49.99/-
Jack Daniel’s Bold Spicy	500ml	57.99/-
Jack Daniel’s Sweet & Oaky	500ml	57.99/-
Jack Daniel’s Tennessee Straight	700ml	44.99/-
Jack Daniel’s Tennessee Fire	700ml	44.99/-
Jack Daniel’s Bonded	700ml	74.99/-
Jack Daniel’s McLXJD 2024 Edition	700ml	54.99/-
Jack Daniel’s Single Barrel	700ml	109.99/-

Brand / Series: Jack Daniel's (Other)
Variant / Flavor Type	Size / Volume	Price
Gentleman Jack	700ml	59.99/-

Brand / Series: Chivas Regal
Variant / Flavor Type	Size / Volume	Price
Chivas 12	1L	74.99/-
Chivas 12	700ml	58.99/-
Chivas 12	350ml	33.99/-
Chivas 18	1L	149.99/-
Chivas Regal Mizunara	1L	99.99/-
Chivas Regal XV 15 Year Old	700ml	109.99/-
Chivas Regal Extra 13 Year Old	700ml	84.99/-

Brand / Series: Ballantine’s
Variant / Flavor Type	Size / Volume	Price
Ballantine’s Finest	700ml	37.99/-
Ballantine’s 12	1L	74.99/-

Brand / Series: Jim Beam
Variant / Flavor Type	Size / Volume	Price
Jim Beam Bourbon	1L	44.99/-
Jim Beam Apple	700ml	34.99/-
Jim Beam Peach	700ml	34.99/-
Jim Beam Honey	700ml	34.99/-
Jim Beam Bourbon	700ml	34.99/-
Jim Beam Sunshine	700ml	34.99/-
Jim Beam Black Cherry	700ml	34.99/-
Jim Beam RYE	700ml	44.99/-
Jim Beam Black	700ml	45.99/-

Brand / Series: Other Popular Whisky Brands
Variant / Flavor Type	Size / Volume	Price
J&B	1L	39.99/-
J&B	700ml	29.99/-
Glen Scanlan	1L	29.99/-
Glen Scanlan	700ml	24.99/-
Glen Scanlan	500ml	19.99/-
Glenfiddich	1L	39.99/-
Glenfiddich	700ml	27.99/-
Four Roses	1L	54.99/-
Four Roses	700ml	39.99/-
Famous Grouse	1L	41.99/-
Famous Grouse	700ml	32.99/-
Label 5	700ml	25.99/-
Label 5	500ml	17.99/-
Teacher’s	700ml	31.99/-
VAT 69	700ml	27.99/-
Jagermeister	1L	38.99/-
Jagermeister	700ml	28.99/-
Jagermeister	350ml	17.99/-

VODKA
——————————————————————————————————————————————————
Brand / Series: Absolut Vodka
Variant / Flavor Type	Size / Volume	Price
Absolut Vodka (Normal)	1L	41.99/-
Absolut Vodka (Normal)	700ml	34.99/-
Absolut Vodka (Normal)	500ml	27.99/-
Absolut Vodka (Normal)	350ml	19.99/-
Absolut Sensations	700ml	34.99/-
Absolut Raspberri	700ml	34.99/-
Absolut Citron	700ml	34.99/-
Absolut Passionfruit	700ml	34.99/-
Absolut Lime	700ml	34.99/-
Absolut Warhol Edition	700ml	34.99/-
Absolut Vanilla	700ml	34.99/-

Brand / Series: Smirnoff Vodka
Variant / Flavor Type	Size / Volume	Price
Smirnoff (Normal)	1L	39.99/-
Smirnoff (Normal)	700ml	27.99/-
Smirnoff (Normal)	500ml	19.99/-
Smirnoff (Normal)	200ml	11.99/-
Smirnoff Peach	700ml	29.99/-
Smirnoff Raspberry	700ml	29.99/-
Smirnoff Mango	700ml	29.99/-
Smirnoff North	700ml	29.99/-
Smirnoff Small Batch Vodka	700ml	29.99/-
Smirnoff Vanilla	700ml	29.99/-

Brand / Series: Grey Goose
Variant / Flavor Type	Size / Volume	Price
Grey Goose (Normal)	700ml	79.99/-
Grey Goose La Poire	700ml	79.99/-
Grey Goose Le Citron	700ml	79.99/-
Grey Goose L'Orange	700ml	79.99/-
Grey Goose (Normal)	500ml	41.99/-
Grey Goose Peach & Rosemary	1L	94.99/-

Brand / Series: AU Vodka
Variant / Flavor Type	Size / Volume	Price
AU Vodka (Normal)	700ml	54.99/-
AU Juicy Peach	700ml	54.99/-
AU Black Grape	700ml	54.99/-
AU Blue Raspberry	700ml	54.99/-
AU Watermelon	700ml	54.99/-
AU Strawberry Burst	700ml	54.99/-
AU Fruit	700ml	54.99/-
AU Pineapple Crush	700ml	54.99/-
AU Bubble Gum	700ml	54.99/-
AU Cosmic Berries	700ml	54.99/-
AU Pink Lemonade	700ml	54.99/-

Brand / Series: Ciroc Vodka
Variant / Flavor Type	Size / Volume	Price
Ciroc Vodka (Normal)	700ml	61.99/-
Ciroc Apple	700ml	61.99/-
Ciroc Peach	700ml	61.99/-
Ciroc Pineapple	700ml	61.99/-
Ciroc Coconut	700ml	61.99/-
Ciroc Summer Citrus	700ml	61.99/-
Ciroc Mango	700ml	61.99/-
Ciroc Summer Watermelon	700ml	61.99/-
Ciroc Red Berry	700ml	61.99/-

Brand / Series: Other Popular Vodka Brands
Variant / Flavor Type	Size / Volume	Price
Finlandia	1L	39.99/-
Finlandia	700ml	29.99/-
POLIAKOV	700ml	23.99/-
POLIAKOV	500ml	17.99/-
POLIAKOV	200ml	11.99/-
ESBJAERG	1L	34.99/-
ESBJAERG	500ml	19.99/-
ESBJAERG	200ml	9.99/-
SKYY Vodka	700ml	29.99/-
Tito’s Vodka	1L	51.99/-
Tito’s Vodka	700ml	41.99/-
Puschkin	1L	31.99/-
Puschkin	700ml	22.99/-
Puschkin Amorelie	700ml	22.99/-

GIN
——————————————————————————————————————————————————
Brand / Series: Bombay Sapphire
Variant / Flavor Type	Size / Volume	Price
Bombay Sapphire	1L	54.99/-
Bombay Sapphire	700ml	42.99/-
Bombay Sapphire	500ml	34.99/-
Bombay Sapphire East	700ml	42.99/-
Bombay Sapphire Premier	1L	59.99/-
Star of Bombay	1L	54.99/-
Bombay Sapphire Sunset	700ml	49.99/-

Brand / Series: Other Popular Gin Brands
Variant / Flavor Type	Size / Volume	Price
Still Gin	700ml	54.99/-
Monkey 47	700ml	69.99/-
Hendrick’s	1L	79.99/-
Hendrick’s	700ml	64.99/-
Hendrick’s	350ml	44.50/-
Beefeater	1L	44.99/-
Beefeater	700ml	34.99/-
Beefeater Strawberry	700ml	34.99/-
London Dry Gin Tanqueray	1L	53.99/-
London Dry Gin Tanqueray	700ml	35.99/-
London Dry Gin Tanqueray	350ml	22.99/-

RUM
——————————————————————————————————————————————————
Brand / Series: Bacardi
Variant / Flavor Type	Size / Volume	Price
Bacardi (White/Normal)	1L	41.99/-
Bacardi (White/Normal)	700ml	27.99/-
Bacardi (White/Normal)	500ml	21.99/-
Bacardi (White/Normal)	350ml	17.99/-
Bacardi Limon	1L	38.99/-
Bacardi Limon	700ml	28.99/-
Bacardi Tropical	700ml	28.99/-
Bacardi Punch	700ml	28.99/-
Bacardi Coconut	700ml	28.99/-
Bacardi Mojito	700ml	28.99/-
Bacardi Passionfruit	700ml	28.99/-
Bacardi Carta Negra	1L	41.99/-
Bacardi Carta Negra	700ml	32.99/-
Bacardi Anejo	1L	54.99/-
Bacardi Anejo	500ml	41.99/-
Bacardi Spiced	1L	39.99/-
Bacardi Spiced	700ml	28.99/-

Brand / Series: Other Rum Brands
Variant / Flavor Type	Size / Volume	Price
Captain Morgan	1L	39.99/-
Captain Morgan	700ml	27.99/-
Captain Morgan White Rum	700ml	27.99/-
Old Captain	1L	36.99/-
Old Captain	700ml	27.99/-
Havana Club	1L	41.99/-
Havana Club	700ml	35.99/-

TEQUILA
——————————————————————————————————————————————————
Brand / Series: Popular Tequila Brands
Variant / Flavor Type	Size / Volume	Price
José Cuervo	1L	54.99/-
José Cuervo	700ml	45.99/-
Sierra Tequila	Standard	29.99/-
Patrón	Standard	89.99/-
Don Julio	700ml	109/-
Tiscaz	700ml	43.99/-

DUTCH GIN (GENEVER) & COGNAC
——————————————————————————————————————————————————
Brand / Series: Genever & Brandy Brands
Variant / Flavor Type	Size / Volume	Price
Ketel 1 Original	1L	32.99/-
Ketel 1 Original	500ml	19.99/-
Bol’s Corenwijn 2 Jaar Vatgerijpt	1L	54.99/-
Bol’s Corenwijn 2 Jaar Vatgerijpt	500ml	29.99/-
Bol’s Jonge	1L	31.99/-
Hope Jonge	1L	24.99/-
Hope Vieux	1L	26.99/-
Oude Genever 5 Jaar Vat Gelagerd (Blue)	500ml	34.99/-
Oude Genever 5 Jaar Vat Gelagerd (Red)	500ml	34.99/-
Oude Genever 5 Jaar Vat Gelagerd (Gray)	500ml	34.99/-
Oude Genever 5 Jaar Vat Gelagerd (Black)	500ml	34.99/-
Oude Genever 3 Jaar Vat Gelagerd	1L	64.99/-
Hennessy Very Special	1L	99.99/-
Hennessy Very Special	700ml	71.99/-
Hennessy Very Special	350ml	44.99/-
Hennessy Very Special	200ml	22.99/-

LIQUEURS / SHOTS
——————————————————————————————————————————————————
Brand / Series: Buzzball & Shots
Variant / Flavor Type	Size / Volume	Price
Buzzball (Red)	Standard	8/-
Buzzball (White)	Standard	8/-
Buzzball (Yellow)	Standard	8/-
Buzzball (Orange)	Standard	8/-

CHAMPAGNE / SPARKLING
——————————————————————————————————————————————————
Brand / Series: Champagne & Prosecco Brands
Variant / Flavor Type	Size / Volume	Price
Moët & Chandon	Standard	94.99/-
Veuve Clicquot	Standard	59.99/-
Piper Heidsieck	Standard	99.99/-
Bernard Bijotat	Standard	59.99/-
Freixenet	Standard	19.99/-
Martini Prosecco	Standard	19.99/-
Asti	Standard	19.99/-
Pronol Prosecco	Standard	19.99/-
Prosecco Cuvee	Standard	19.99/-
Prosecco Rose	Standard	21.99/-

BEER BRANDS
——————————————————————————————————————————————————
Brand / Series: Most Common Beers
Variant / Flavor Type	Size / Volume	Price
Heineken Can/Bottle	500ml	3.50/-
Heineken Can/Bottle	330ml	2.25/-
Heineken Can/Bottle	250ml	2.75/-
Amstel	500ml	3.50/-
Amstel	330ml	2.25/-
Grolsch	500ml	3.50/-
Grolsch	330ml	2.25/-
Grolsch Glass Bottle	500ml	4.75/-
Grolsch Glass Bottle	330ml	4.00/-
Corona	330ml	3.50/-
Hertog Jan	500ml	3.50/-
Hertog Jan	330ml	2.25/-
Brouwerij’TIJ Can	330ml	5.00/-
Brouwerij’TIJ Glass Bottle	330ml	5.00/-
Guinness	500ml	6.00/-
Guinness Glass Bottle	350ml	6.00/-
Desperados Red	500ml	5.00/-
Desperados Original	500ml	5.00/-
Desperados Mojito	500ml	5.00/-
Desperados Red Glass Bottle	330ml	5.00/-
Desperados Original Glass Bottle	330ml	5.00/-
Desperados Mojito Glass Bottle	330ml	5.00/-
Somersby Apple Mango & Lime	500ml	4.00/-
Somersby Blackberry	500ml	4.00/-
Somersby Apple Mango & Lime Glass Bottle	330ml	5.00/-
Somersby Blackberry Glass Bottle	330ml	5.00/-

ALCOHOL DRINKS CANS & READY TO DRINK
——————————————————————————————————————————————————
Brand / Series: Premixed Cans & Bottled RTD
Variant / Flavor Type	Size / Volume	Price
Smirnoff Black Can	250ml	5.00/-
Smirnoff Original Can	250ml	5.00/-
Smirnoff Tropical Can	250ml	5.00/-
Smirnoff Raspberry Can	250ml	5.00/-
Absolut Sprite 5% Vodka Can	250ml	5.00/-
Jack Daniel's Normal Can	330ml	5.00/-
Jack Daniel's Cherry Can	330ml	5.00/-
Lavish Whisky Cola	250ml	5.50/-
Lavish Mango	250ml	6.00/- euro
Lavish Strawberry Vanilla	250ml	6.00/- euro
Lavish Grape	250ml	6.00/- euro
Lavish Mangorini	250ml	6.00/- euro
Lavish Orange Spritz	250ml	6.00/- euro
Lavish Fruit Punch	250ml	6.00/- euro
Lavish Purple Grape	250ml	6.00/- euro
Lavish Blue Raspberry	250ml	6.00/- euro
Lavish Passiontini	250ml	6.00/- euro
Lavish Raspberry Guava	250ml	6.00/- euro
Lavish Cosmopolitan	250ml	6.00/- euro
Lavish Green Apple	250ml	6.00/- euro
Lavish Pineapple	250ml	6.00/- euro
Lavish 10%	250ml	6.00/- euro
Lavish 17%	250ml	6.00/- euro
Lavish 21%	250ml	6.00/- euro
STELZ Mango	250ml	6.00/- euro
STELZ Peach	250ml	6.00/- euro
STELZ Raspberry	250ml	6.00/- euro
STELZ Lime	250ml	6.00/- euro
Bacardi Coca-Cola Can	250ml	5.00/-
Bacardi Razz & Up Can	250ml	5.00/-
Bacardi Cuba Libre Can	250ml	5.00/-
Bacardi Tropical Breeze Can	250ml	5.00/-
Bacardi Sunset Punch Can	250ml	5.00/-
Bacardi Limon & Lemonade Can	250ml	5.00/-
Bacardi Mojito Can	250ml	5.00/-
Bacardi Mango Mojito Can	250ml	5.00/-
Smirnoff 4% Original	700ml	9.99/-
Smirnoff 4% Raspberry	700ml	9.99/-
Smirnoff 4% (Flavor N/A)	275ml	4.00/-
Breezer	275ml	5.00/-

SEED DRINKS & INFUSED DRINKS
——————————————————————————————————————————————————
Brand / Series: Cannabis Drinks
Variant / Flavor Type	Size / Volume	Price
Cannabis Green Tea	Standard	6.00/-
Cannabis Energy Drink (Normal)	Standard	6.00/-
Cannabis Energy Drink (Power Amsterdam)	Standard	6.00/-
Cannabis Energy Drink (Sostned)	Standard	6.00/-

SOFT DRINKS FOR MIXING
——————————————————————————————————————————————————
Brand / Series: Sodas, Juices & Mixers
Variant / Flavor Type	Size / Volume	Price
Coca-Cola Can	330ml	3.00/-
Coca-Cola Bottle	500ml	3.50/-
Coca-Cola Bottle	1.5L	4.75/-
Coca-Cola Zero Can	330ml	3.00/-
Coca-Cola Zero Bottle	500ml	3.50/-
Coca-Cola Zero Bottle	1.5L	4.75/-
Pepsi Can	330ml	3.00/-
Pepsi Bottle	500ml	3.50/-
Pepsi Bottle	1.5L	4.75/-
Sprite Can	330ml	3.00/-
Sprite Bottle	500ml	3.50/-
Sprite Bottle	1.5L	4.75/-
7UP Can	330ml	3.00/-
7UP Bottle	500ml	3.50/-
7UP Bottle	1.5L	4.75/-
Fanta (All Flavors) Can	330ml	3.00/-
Fanta (All Flavors) Bottle	500ml	3.50/-
Fanta (All Flavors) Bottle	1.5L	4.75/-
Red Bull Original	Standard	5.00/-
Red Bull Sugarfree / Zero	Standard	3.5/- euro
Red Bull Watermelon (Red Edition)	Standard	5.00/-
Red Bull Tropical (Yellow Edition)	Standard	5.00/-
Red Bull Blueberry (Blue Edition)	Standard	5.00/-
Red Bull Coconut Berry	Standard	5.00/-
Red Bull Strawberry Apricot (Amber Edition)	Standard	5.00/-
Red Bull Peach / White Peach	Standard	5.00/-
Red Bull Dragon Fruit	Standard	5.00/-
Red Bull Juneberry	Standard	5.00/-
Red Bull Açaí (Purple Edition)	Standard	5.00/-
Red Bull Wild Berry	Standard	5.00/-
Red Bull Fuji Apple & Ginger	Standard	5.00/-
Red Bull Iced Vanilla Berry	Standard	5.00/-
Tonic Water	Standard	5.00/-
Ginger Ale Bottle	Standard	5.00/-
Ginger Ale Can	Standard	3.25/-
Soda Water	Standard	5.00/-
Water Normal	500ml	2.50/-
Water Normal	1.5L	3.50/-
Water Sparkling	500ml	2.50/-
Water Sparkling	1.5L	3.50/-
Dimes Juice (Orange)	1L	5.00/-
Dimes Juice (Apple)	1L	5.00/-
Maaza Guava	500ml	3.50/-
Maaza Lychee	500ml	3.50/-
Lipton Sparkling	Standard	3.50/-
Lipton Peach	Standard	3.50/-
Lipton Lemon	Standard	3.50/-
PowerADE	Standard	3.25/-
Vitamin Water Limoen	Standard	3.75/-
Vitamin Water Framboos	Standard	3.75/-
Vitamin Water Citroen	Standard	3.75/-
Vitamin Water Mango	Standard	3.75/-
Vitamin Water Peer Vlierbloesem	Standard	3.75/-
Capri-Sun Orange	Standard	1.75/-
Capri-Sun Cerise	Standard	1.75/-
Coconut Water	1L	10.00/-
Coconut Water	500ml	5.00/-
"""

lines = data.split('\n')
current_category = None
current_brand = None
products = []

categories_map = {
    'WHISKY / WHISKEY': ('Whisky', 'whisky'),
    'VODKA': ('Vodka', 'vodka'),
    'GIN': ('Gin', 'gin'),
    'RUM': ('Rum', 'rum'),
    'TEQUILA': ('Tequila', 'tequila'),
    'DUTCH GIN (GENEVER) & COGNAC': ('Dutch Gin (Genever) & Cognac', 'dutch-gin-genever-cognac'),
    'LIQUEURS / SHOTS': ('Liqueurs / Shots', 'liqueurs-shots'),
    'CHAMPAGNE / SPARKLING': ('Champagne / Sparkling', 'champagne-sparkling'),
    'BEER BRANDS': ('Beer Brands', 'beer'),
    'ALCOHOL DRINKS CANS & READY TO DRINK': ('Cans', 'cans'),
    'SEED DRINKS & INFUSED DRINKS': ('Seed Drinks & Infused Drinks', 'seed-drinks-infused'),
    'SOFT DRINKS FOR MIXING': ('Soft Drinks', 'soft-drinks')
}

def parse_size(size_str):
    if size_str.lower() == 'standard':
        return 750
    size_str = size_str.lower()
    if 'l' in size_str and 'ml' not in size_str:
        num = re.sub(r'[^0-9.]', '', size_str)
        if num: return int(float(num) * 1000)
    elif 'ml' in size_str:
        num = re.sub(r'[^0-9.]', '', size_str)
        if num: return int(float(num))
    return 750

def parse_price(price_str):
    num = re.sub(r'[^0-9.]', '', price_str)
    if num: return float(num)
    return 0.0

def make_slug(name):
    return re.sub(r'[^a-z0-9]+', '-', name.lower()).strip('-')

for line in lines:
    line = line.strip()
    if not line or line.startswith('——') or line.startswith('Variant / Flavor'):
        continue
    
    is_cat = False
    for cat_key in categories_map:
        if line == cat_key:
            current_category = categories_map[cat_key]
            is_cat = True
            break
    if is_cat: continue
    
    if line.startswith('Brand / Series:'):
        current_brand = line.replace('Brand / Series:', '').strip()
        continue
        
    parts = line.split('\t')
    if len(parts) >= 3:
        variant = parts[0].strip()
        size = parts[1].strip()
        price = parts[2].strip()
        
        products.append({
            'category_name': current_category[0],
            'category_slug': current_category[1],
            'brand': current_brand,
            'name': variant,
            'size_ml': parse_size(size),
            'price': parse_price(price)
        })

sql_script = """-- ==============================================================
-- MASSIVE SEED FILE: BRANDS, PRODUCTS, VARIANTS
-- Execute in Supabase SQL Editor
-- ==============================================================

DO $$
DECLARE
"""

cat_slugs_to_var = {}
for cat_name, cat_slug in categories_map.values():
    var_name = 'v_cat_' + cat_slug.replace('-', '_')
    cat_slugs_to_var[cat_slug] = var_name
    sql_script += f"  {var_name} UUID;\n"

sql_script += "  v_product_id UUID;\nBEGIN\n\n-- Insert Categories\n"

for cat_name, cat_slug in categories_map.values():
    var_name = cat_slugs_to_var[cat_slug]
    sql_script += f"  INSERT INTO public.categories (name, slug) VALUES ('{cat_name}', '{cat_slug}') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO {var_name};\n"

sql_script += "\n-- Insert Products and Variants\n"

grouped_products = {}
for p in products:
    brand = p['brand']
    if 'Other ' in brand:
        brand = p['name'].split(' ')[0] # Heuristic for "Other" brands
        if brand == 'London': brand = 'Tanqueray'
        elif brand == 'Old': brand = 'Old Captain'
    
    p_name = p['name']
    product_slug = make_slug(f"{brand}-{p_name}")
    
    if product_slug not in grouped_products:
        grouped_products[product_slug] = {
            'name': p_name,
            'brand': brand,
            'cat_slug': p['category_slug'],
            'variants': []
        }
    grouped_products[product_slug]['variants'].append(p)

for p_slug, prod in grouped_products.items():
    cat_var = cat_slugs_to_var[prod['cat_slug']]
    b_name = prod['brand'].replace("'", "''")
    p_name = prod['name'].replace("'", "''")
    
    sql_script += f"  INSERT INTO public.products (category_id, name, slug, brand, is_premium, is_featured, is_active)\n"
    sql_script += f"  VALUES ({cat_var}, '{p_name}', '{p_slug}', '{b_name}', false, true, true)\n"
    sql_script += f"  ON CONFLICT (slug) DO UPDATE SET brand = EXCLUDED.brand RETURNING id INTO v_product_id;\n"
    
    for v in prod['variants']:
        v_sku = make_slug(f"{p_slug}-{v['size_ml']}ml")
        sql_script += f"    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)\n"
        sql_script += f"    VALUES (v_product_id, {v['size_ml']}, {v['price']}, 100, '{v_sku}')\n"
        sql_script += f"    ON CONFLICT (sku) DO NOTHING;\n"
    sql_script += "\n"

sql_script += "END $$;\n"

with open('c:/Users/Ata Ur Rehman/Desktop/friends-liquor-store/friends-liquor-store/seed_liquor_data.sql', 'w', encoding='utf-8') as f:
    f.write(sql_script)
