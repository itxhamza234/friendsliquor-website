
import fs from "fs";

const categories = [
  { id: 'cat_whisky', name: 'WHISKY', slug: 'whisky' },
  { id: 'cat_vodka', name: 'VODKA', slug: 'vodka' },
  { id: 'cat_gin', name: 'GIN', slug: 'gin' },
  { id: 'cat_rum', name: 'RUM', slug: 'rum' },
  { id: 'cat_tequila', name: 'TEQUILA', slug: 'tequila' },
  { id: 'cat_dutch_gin_cognac', name: 'DUTCH GIN (GENEVER) & COGNAC', slug: 'dutch-gin-genever-cognac' },
  { id: 'cat_liqueurs_shots', name: 'LIQUEURS / SHOTS', slug: 'liqueurs-shots' },
  { id: 'cat_champagne_sparkling', name: 'CHAMPAGNE / SPARKLING', slug: 'champagne-sparkling' },
  { id: 'cat_beer_brands', name: 'BEER BRANDS', slug: 'beer-brands' },
  { id: 'cat_cans', name: 'CANS', slug: 'cans' },
  { id: 'cat_seed_drinks_infused', name: 'SEED DRINKS & INFUSED DRINKS', slug: 'seed-drinks-infused' },
  { id: 'cat_soft_drinks', name: 'SOFT DRINKS', slug: 'soft-drinks' },
  { id: 'cat_wines', name: 'WINES', slug: 'wines' },
];

const productsData = [
  // WHISKY
  { brand: 'Johnnie Walker', name: 'Red Label', cat: 'cat_whisky', v: [{ size: '1L', price: 46.99 }, { size: '700ml', price: 34.99 }, { size: '350ml', price: 24.77 }, { size: '200ml', price: 14.99 }] },
  { brand: 'Johnnie Walker', name: 'Red Label (Red Soul)', cat: 'cat_whisky', v: [{ size: '700ml', price: 35.99 }] },
  { brand: 'Johnnie Walker', name: 'Black Label', cat: 'cat_whisky', v: [{ size: '1L', price: 69.99 }, { size: '700ml', price: 54.99 }, { size: '350ml', price: 34.99 }, { size: '200ml', price: 24.99 }] },
  { brand: 'Johnnie Walker', name: 'Double Black', cat: 'cat_whisky', v: [{ size: '700ml', price: 57.99 }] },
  { brand: 'Johnnie Walker', name: 'Green Label', cat: 'cat_whisky', v: [{ size: '700ml', price: 89.99 }] },
  { brand: 'Johnnie Walker', name: 'Gold Label', cat: 'cat_whisky', v: [{ size: '700ml', price: 94.99 }] },
  { brand: 'Johnnie Walker', name: 'Blue Label', cat: 'cat_whisky', v: [{ size: '700ml', price: 329.99 }] },
  { brand: 'Jack Daniel’s', name: 'Old No. 7', cat: 'cat_whisky', v: [{ size: '1L', price: 61.99 }, { size: '700ml', price: 44.99 }, { size: '500ml', price: 37.99 }, { size: '350ml', price: 27.99 }, { size: '200ml', price: 17.99 }] },
  { brand: 'Jack Daniel’s', name: 'Honey', cat: 'cat_whisky', v: [{ size: '700ml', price: 44.99 }] },
  { brand: 'Jack Daniel’s', name: 'Apple', cat: 'cat_whisky', v: [{ size: '700ml', price: 44.99 }] },
  { brand: 'Jack Daniel’s', name: 'Blackberry', cat: 'cat_whisky', v: [{ size: '700ml', price: 49.99 }] },
  { brand: 'Jack Daniel’s', name: 'Bold Spicy', cat: 'cat_whisky', v: [{ size: '500ml', price: 57.99 }] },
  { brand: 'Jack Daniel’s', name: 'Sweet & Oaky', cat: 'cat_whisky', v: [{ size: '500ml', price: 57.99 }] },
  { brand: 'Jack Daniel’s', name: 'Tennessee Straight', cat: 'cat_whisky', v: [{ size: '700ml', price: 44.99 }] },
  { brand: 'Jack Daniel’s', name: 'Tennessee Fire', cat: 'cat_whisky', v: [{ size: '700ml', price: 44.99 }] },
  { brand: 'Jack Daniel’s', name: 'Bonded', cat: 'cat_whisky', v: [{ size: '700ml', price: 74.99 }] },
  { brand: 'Jack Daniel’s', name: 'McLXJD 2024 Edition', cat: 'cat_whisky', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'Jack Daniel’s', name: 'Single Barrel', cat: 'cat_whisky', v: [{ size: '700ml', price: 109.99 }] },
  { brand: 'Gentleman Jack', name: 'Gentleman Jack', cat: 'cat_whisky', v: [{ size: '700ml', price: 59.99 }] },
  { brand: 'Chivas Regal', name: 'Chivas 12', cat: 'cat_whisky', v: [{ size: '1L', price: 74.99 }, { size: '700ml', price: 58.99 }, { size: '350ml', price: 33.99 }] },
  { brand: 'Chivas Regal', name: 'Chivas 18', cat: 'cat_whisky', v: [{ size: '1L', price: 149.99 }] },
  { brand: 'Chivas Regal', name: 'Mizunara', cat: 'cat_whisky', v: [{ size: '1L', price: 99.99 }] },
  { brand: 'Chivas Regal', name: 'XV 15 Year Old', cat: 'cat_whisky', v: [{ size: '700ml', price: 109.99 }] },
  { brand: 'Chivas Regal', name: 'Extra 13 Year Old', cat: 'cat_whisky', v: [{ size: '700ml', price: 84.99 }] },
  { brand: 'Ballantine’s', name: 'Finest', cat: 'cat_whisky', v: [{ size: '700ml', price: 37.99 }] },
  { brand: 'Ballantine’s', name: '12', cat: 'cat_whisky', v: [{ size: '1L', price: 74.99 }] },
  { brand: 'Jim Beam', name: 'Bourbon', cat: 'cat_whisky', v: [{ size: '1L', price: 44.99 }, { size: '700ml', price: 34.99 }] },
  { brand: 'Jim Beam', name: 'Apple', cat: 'cat_whisky', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Jim Beam', name: 'Peach', cat: 'cat_whisky', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Jim Beam', name: 'Honey', cat: 'cat_whisky', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Jim Beam', name: 'Sunshine', cat: 'cat_whisky', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Jim Beam', name: 'Black Cherry', cat: 'cat_whisky', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Jim Beam', name: 'RYE', cat: 'cat_whisky', v: [{ size: '700ml', price: 44.99 }] },
  { brand: 'Jim Beam', name: 'Black', cat: 'cat_whisky', v: [{ size: '700ml', price: 45.99 }] },
  { brand: 'J&B', name: 'J&B', cat: 'cat_whisky', v: [{ size: '1L', price: 39.99 }, { size: '700ml', price: 29.99 }] },
  { brand: 'Glen Scanlan', name: 'Glen Scanlan', cat: 'cat_whisky', v: [{ size: '1L', price: 29.99 }, { size: '700ml', price: 24.99 }, { size: '500ml', price: 19.99 }] },
  { brand: 'Glenfiddich', name: 'Glenfiddich', cat: 'cat_whisky', v: [{ size: '1L', price: 39.99 }, { size: '700ml', price: 27.99 }] },
  { brand: 'Four Roses', name: 'Four Roses', cat: 'cat_whisky', v: [{ size: '1L', price: 54.99 }, { size: '700ml', price: 39.99 }] },
  { brand: 'Famous Grouse', name: 'Famous Grouse', cat: 'cat_whisky', v: [{ size: '1L', price: 41.99 }, { size: '700ml', price: 32.99 }] },
  { brand: 'Label 5', name: 'Label 5', cat: 'cat_whisky', v: [{ size: '700ml', price: 25.99 }, { size: '500ml', price: 17.99 }] },
  { brand: 'Teacher’s', name: 'Teacher’s', cat: 'cat_whisky', v: [{ size: '700ml', price: 31.99 }] },
  { brand: 'VAT 69', name: 'VAT 69', cat: 'cat_whisky', v: [{ size: '700ml', price: 27.99 }] },
  { brand: 'Jagermeister', name: 'Jagermeister', cat: 'cat_liqueurs_shots', v: [{ size: '1L', price: 38.99 }, { size: '700ml', price: 28.99 }, { size: '350ml', price: 17.99 }] },

  // PREMIUM DRINKS
  { brand: 'Johnnie Walker', name: 'Blue Label Blended Scotch Whisky', cat: 'cat_whisky', is_premium: true, desc: "An exquisite premium luxury blend made from Scotland's rarest and oldest single malt and grain whiskies. Only 1 in 10,000 casks meets this unparalleled standard. Delivers a remarkably velvety smooth character with honey, hazelnuts, and a signature gentle smoky finish.", v: [{ size: '700ml', price: 299.99, stock: 1 }] },
  { brand: 'The Macallan', name: '12 Years Old Double Cask Single Malt', cat: 'cat_whisky', is_premium: true, desc: 'A beautifully balanced Speyside single malt matured in a perfect combination of American and European oak casks seasoned with Oloroso sherry. Delivers classic creamy fudge, honeyed citrus, and rich warming spices.', v: [{ size: '700ml', price: 159.99, stock: 1 }] },
  { brand: 'Royal Salute', name: '21 Years Old x Harris Reed (The Fashion Collection - Purple Edition)', cat: 'cat_whisky', is_premium: true, desc: 'A prestigious, limited-edition blended Scotch whisky created in collaboration with celebrated fashion designer Harris Reed. Matured for a minimum of 21 years, it offers an incredibly rich and sweet profile filled with notes of red apples, rich honey, creamy toffee, and a whisper of warm kitchen spices, presented in a stunning theatrical purple bottle.', v: [{ size: '700ml', price: 199.99, stock: 1 }] },
  { brand: 'Royal Salute', name: '21 Years Old x Harris Reed (The Fashion Collection - Gold Edition)', cat: 'cat_whisky', is_premium: true, desc: 'Part of the exclusive Fashion Collection collaboration with Harris Reed, this premium 21-year-old blended Scotch is housed in a striking gold feather-themed flagon. It delivers an extraordinarily smooth palate layered with notes of autumn fruits, sweet golden syrup, poached pears, and a wonderfully complex, long-lasting finish.', v: [{ size: '700ml', price: 199.99, stock: 1 }] },
  { brand: 'Royal Salute', name: '21 Years Old - The Signature Blend (Kristjana S. Williams Edition)', cat: 'cat_whisky', is_premium: true, desc: "Royal Salute's flagship and iconic blended Scotch whisky matured for at least 21 years. Housed in a sapphire blue flagon inside a premium gift box illustrated by award-winning fine artist Kristjana S. Williams, depicting the British Royal Menagerie.", v: [{ size: '700ml', price: 299.99, stock: 2 }] },
  { brand: 'Glenfiddich', name: '18 Years Old Small Batch Single Malt', cat: 'cat_whisky', is_premium: true, desc: 'A distinguished single malt matured in finest Oloroso Sherry and Bourbon casks for 18 years. Married in small batches, it delivers an incredibly rich, elegant, and complex depth with notes of baked apple, cinnamon, and robust oak.', v: [{ size: '700ml', price: 199.99, stock: 1 }] },
  { brand: 'Jack Daniel\'s', name: 'Single Barrel - Barrel Strength Tennessee Whiskey', cat: 'cat_whisky', is_premium: true, desc: 'An intense, high-proof premium Tennessee whiskey bottled straight from a single select barrel without dilution. Offers a bold and robust flavor profile balanced with sweet brown sugar, toasted oak, and deep vanilla.', v: [{ size: '700ml', price: 109.99, stock: 1 }] },
  { brand: 'Chivas Regal', name: '18 Years Old - The Gold Signature Blended Scotch', cat: 'cat_whisky', is_premium: true, desc: 'A uniquely rich and multi-layered blend created by Master Blender Colin Scott. Matured for 18 years, it features indulgent velvet notes of dark chocolate, dried autumn fruits, and buttery toffee.', v: [{ size: '700ml', price: 119.99, stock: 1 }] },
  { brand: 'The Dalmore', name: '12 Years Old Highland Single Malt', cat: 'cat_whisky', is_premium: true, desc: 'An outstanding Highland single malt aged initially in American white oak ex-bourbon casks and beautifully finished in rare Oloroso sherry butts. Complex and rich, delivering citrus fruits, chocolate, and warm aromatic spices.', v: [{ size: '700ml', price: 119.99, stock: 1 }] },
  { brand: 'Don Julio', name: '1942 Añejo Tequila', cat: 'cat_tequila', is_premium: true, desc: 'An internationally celebrated, ultra-premium Añejo tequila crafted from 100% Blue Agave. Handcrafted in small batches and aged for a minimum of two and a half years in American white oak barrels, offering unmatched notes of warm oak, vanilla, and roasted agave in an iconic elongated tall bottle.', v: [{ size: '700ml', price: 275.00, stock: 1 }] },
  { brand: 'Glenfiddich', name: '15 Years Old Distillery Edition Single Malt', cat: 'cat_whisky', is_premium: true, desc: 'A higher-strength, non-chill-filtered expression of Glenfiddich aged for 15 years in traditional American and Spanish oak casks. Rich, robust, and highly concentrated with distinct peppery spices and sweet floral notes.', v: [{ size: '700ml', price: 199.99, stock: 1 }] },
  { brand: 'Cognac Frapin', name: 'V.I.P. XO Grande Champagne', cat: 'cat_dutch_gin_cognac', is_premium: true, desc: 'An exceptionally premium and exclusive XO Cognac crafted entirely from grapes grown in the premier Grande Champagne region of France. Aged over decades in historic family cellars, presented in a royal designer decanter with elegant chocolate, dried fruit, and rancio notes.', v: [{ size: '700ml', price: 279.99, stock: 1 }] },

  { brand: 'Chivas Regal', name: '25 Years Old - Original Legend Blended Scotch', cat: 'cat_whisky', is_premium: true, desc: "The world's first luxury whisky blend, meticulously brought back as an iconic limited masterpiece. Every single whisky in this blend is aged for at least 25 years. Housed in an exclusive red velvet luxury case, providing spectacular notes of apricot, peach, and creamy milk chocolate.", v: [{ size: '700ml', price: 499.99, stock: 1 }] },
  { brand: 'Johnnie Walker', name: '18 Years Old Blended Scotch Whisky', cat: 'cat_whisky', is_premium: true, desc: 'A masterful blend of up to 18 different whiskies that have matured for a minimum of 18 years. Highly sophisticated and extraordinarily smooth, with fruit sweetness, dark caramel, toffee, and a delicate hint of smoke.', v: [{ size: '700ml', price: 149.99, stock: 1 }] },

  { brand: 'Johnnie Walker', name: 'Gold Label Reserve Blended Scotch Whisky', cat: 'cat_whisky', is_premium: true, desc: 'A luxurious and festive blend renowned for its creamy sweetness. Built around the prestigious Clynelish single malt, it unfolds rich layers of maple syrup, golden honey, vibrant fruits, and subtle wood notes.', v: [{ size: '1000ml', price: 120.00, stock: 1 }, { size: '700ml', price: 94.99, stock: 1 }] },
  { brand: 'The GlenDronach', name: 'Port Wood Highland Single Malt', cat: 'cat_whisky', is_premium: true, desc: 'An exquisite Highland single malt distilled in traditional sherry casks and subsequently finished in the finest Port pipes from Portugal. Imparts a majestic deep ruby color and an intense flavor of baked plums, wild berries, and ginger spice.', v: [{ size: '700ml', price: 130.00, stock: 1 }] },
  { brand: 'Ballantine\'s', name: '21 Years Old Blended Scotch Whisky', cat: 'cat_whisky', is_premium: true, desc: 'An highly acclaimed, premium blended Scotch matured for over two decades. Possesses an aromatic, highly balanced profile of red apple, sweet liquorice, and aromatic spices with a prolonged, warm finish.', v: [{ size: '700ml', price: 189.99, stock: 1 }] },
  { brand: 'Glen Scanlan', name: 'Reserve Blended Scotch Whisky', cat: 'cat_whisky', is_premium: true, desc: 'A classic blended Scotch whisky matured in oak casks, presented in a magnificent extra-large display bottle. It offers a smooth and approachable character with a traditional harmony of malt and grain whiskies, featuring light peat, honeyed sweetness, and subtle oak undertones.', v: [{ size: '4500ml', price: 134.99, stock: 1 }] },
  { brand: 'Gérard Bertrand', name: 'L\'Hospitalitas La Clape 2020', cat: 'cat_wines', is_premium: true, desc: 'A prestigious and powerful red wine from the Sud de France. This exceptional blend boasts an intense, complex bouquet of ripe dark fruits, spices, and elegant roasted notes, offering a full-bodied texture with fine tannins and a long, luxurious finish.', v: [{ size: '750ml', price: 119.99, stock: 1 }] },
  { brand: 'Château Lafon-Rochet', name: 'Saint-Estèphe 2019', cat: 'cat_wines', is_premium: true, desc: 'A classic Grand Cru Classé red Bordeaux wine from the renowned Saint-Estèphe appellation. The 2019 vintage showcases an elegant and highly structured profile filled with deep expressions of blackcurrant, cedarwood, and earthy minerals, supported by firm yet refined tannins.', v: [{ size: '750ml', price: 99.99, stock: 1 }] },
  { brand: 'Tamnavulin', name: 'Sherry Cask Edition', cat: 'cat_whisky', is_premium: true, desc: 'A rich and inviting Speyside single malt whisky that has been matured in American oak barrels and expertly finished in three different types of sherry casks. It treats the palate to a sweet and smooth taste profile dominated by raisins, vanilla, and a warm hint of Christmas cake spices.', v: [{ size: '700ml', price: 57.99, stock: 1 }] },
  { brand: 'Château de Terrefort-Quancard', name: 'Bordeaux Supérieur 2015', cat: 'cat_wines', is_premium: true, desc: 'An elegant, well-aged Bordeaux Supérieur from an exceptional 2015 vintage. This red wine features an appealing ruby color with an aromatic bouquet of red berries, subtle oak integration, and mild spices, providing a smooth and well-rounded drinking experience.', v: [{ size: '750ml', price: 79.99, stock: 1 }] },
  { brand: 'Château Carbonnieux', name: 'Grand Cru Classé de Graves 2021', cat: 'cat_wines', is_premium: true, desc: 'A highly celebrated Pessac-Léognan Grand Cru Classé white wine. It offers an incredibly fresh, crisp, and aromatic profile packed with notes of citrus, white peach, flinty minerality, and a wonderfully vibrant acidity that makes it exceptionally refreshing on the palate.', v: [{ size: '750ml', price: 89.99, stock: 1 }] },
  { brand: 'Baron Nathaniel', name: 'Pauillac 2015', cat: 'cat_wines', is_premium: true, desc: 'A premium Pauillac red wine paying tribute to the historic Rothschild heritage. This 2015 vintage delivers a deeply intense palate rich in black fruits, subtle tobacco, leather, and oak spices, tightly bound by a robust structure and a complex, elegant finish.', v: [{ size: '750ml', price: 39.99, stock: 1 }] },
  { brand: 'Château Gloria', name: 'Saint-Julien 2021', cat: 'cat_wines', is_premium: true, desc: 'A highly esteemed red Bordeaux from the historic Saint-Julien appellation. The 2021 vintage boasts a vibrant and expressive character filled with juicy black fruits, liquorice, and elegant earthy undertones, balanced perfectly by refined tannins and a fresh acidity.', v: [{ size: '750ml', price: 99.99, stock: 1 }] },
  { brand: 'Château Capet-Guillier', name: 'Saint-Émilion Grand Cru 2015', cat: 'cat_wines', is_premium: true, desc: 'A premium Saint-Émilion Grand Cru produced by Antoine Moueix. Originating from the exceptional 2015 vintage, this Merlot-dominant blend offers a plush texture with layers of dark plum, black cherry, subtle tobacco, and a long, velvety finish.', v: [{ size: '750ml', price: 99.99, stock: 1 }] },
  { brand: 'Château Giscours', name: 'Margaux 2019', cat: 'cat_wines', is_premium: true, desc: 'A spectacular Grand Cru Classé red wine from the prestigious Margaux appellation. This 2019 vintage delivers outstanding aromatic complexity, featuring dark chocolate, ripe blackberries, cedar wood, and a luxurious, full-bodied structure that will age beautifully.', v: [{ size: '750ml', price: 159.99, stock: 1 }] },
  { brand: 'Château Talbot', name: 'Saint-Julien 2020', cat: 'cat_wines', is_premium: true, desc: 'A classic and powerful Fourth Growth Grand Cru Classé wine from Saint-Julien. The 2020 vintage showcases incredible depth and concentration, marked by robust flavors of cassis, leather, smoke, and fine-grained tannins that lead into a very persistent finish.', v: [{ size: '750ml', price: 179.99, stock: 1 }] },
  { brand: 'Château d\'Issan', name: 'Margaux 2019', cat: 'cat_wines', is_premium: true, desc: 'A historic Third Growth Grand Cru Classé from Margaux. This 2019 bottling is renowned for its quintessential elegance and silkiness, offering an exquisite bouquet of fresh violets, red currants, sweet spices, and a beautifully balanced mineral core.', v: [{ size: '750ml', price: 149.99, stock: 1 }] },

  // VODKA
  { brand: 'Absolut Vodka', name: 'Normal', cat: 'cat_vodka', v: [{ size: '1L', price: 41.99 }, { size: '700ml', price: 34.99 }, { size: '500ml', price: 27.99 }, { size: '350ml', price: 19.99 }] },
  { brand: 'Absolut Vodka', name: 'Sensations', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Absolut Vodka', name: 'Raspberri', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Absolut Vodka', name: 'Citron', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Absolut Vodka', name: 'Passionfruit', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Absolut Vodka', name: 'Lime', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Absolut Vodka', name: 'Warhol Edition', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Absolut Vodka', name: 'Vanilla', cat: 'cat_vodka', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Smirnoff', name: 'Normal', cat: 'cat_vodka', v: [{ size: '1L', price: 39.99 }, { size: '700ml', price: 27.99 }, { size: '500ml', price: 19.99 }, { size: '200ml', price: 11.99 }] },
  { brand: 'Smirnoff', name: 'Peach', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Smirnoff', name: 'Raspberry', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Smirnoff', name: 'Mango', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Smirnoff', name: 'North', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Smirnoff', name: 'Small Batch Vodka', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Smirnoff', name: 'Vanilla', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Grey Goose', name: 'Normal', cat: 'cat_vodka', v: [{ size: '700ml', price: 79.99 }, { size: '500ml', price: 41.99 }] },
  { brand: 'Grey Goose', name: 'La Poire', cat: 'cat_vodka', v: [{ size: '700ml', price: 79.99 }] },
  { brand: 'Grey Goose', name: 'Le Citron', cat: 'cat_vodka', v: [{ size: '700ml', price: 79.99 }] },
  { brand: 'Grey Goose', name: "L'Orange", cat: 'cat_vodka', v: [{ size: '700ml', price: 79.99 }] },
  { brand: 'Grey Goose', name: 'Peach & Rosemary', cat: 'cat_vodka', v: [{ size: '1L', price: 94.99 }] },
  { brand: 'AU Vodka', name: 'Normal', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Juicy Peach', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Black Grape', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Blue Raspberry', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Watermelon', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Strawberry Burst', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Fruit', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Pineapple Crush', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Bubble Gum', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Cosmic Berries', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'AU Vodka', name: 'Pink Lemonade', cat: 'cat_vodka', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'Ciroc Vodka', name: 'Normal', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Apple', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Peach', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Pineapple', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Coconut', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Summer Citrus', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Mango', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Summer Watermelon', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Ciroc Vodka', name: 'Red Berry', cat: 'cat_vodka', v: [{ size: '700ml', price: 61.99 }] },
  { brand: 'Finlandia', name: 'Finlandia', cat: 'cat_vodka', v: [{ size: '1L', price: 39.99 }, { size: '700ml', price: 29.99 }] },
  { brand: 'POLIAKOV', name: 'POLIAKOV', cat: 'cat_vodka', v: [{ size: '700ml', price: 23.99 }, { size: '500ml', price: 17.99 }, { size: '200ml', price: 11.99 }] },
  { brand: 'ESBJAERG', name: 'ESBJAERG', cat: 'cat_vodka', v: [{ size: '1L', price: 34.99 }, { size: '500ml', price: 19.99 }, { size: '200ml', price: 9.99 }] },
  { brand: 'SKYY Vodka', name: 'SKYY Vodka', cat: 'cat_vodka', v: [{ size: '700ml', price: 29.99 }] },
  { brand: 'Tito’s Vodka', name: 'Tito’s Vodka', cat: 'cat_vodka', v: [{ size: '1L', price: 51.99 }, { size: '700ml', price: 41.99 }] },
  { brand: 'Puschkin', name: 'Puschkin', cat: 'cat_vodka', v: [{ size: '1L', price: 31.99 }, { size: '700ml', price: 22.99 }] },
  { brand: 'Puschkin', name: 'Amorelie', cat: 'cat_vodka', v: [{ size: '700ml', price: 22.99 }] },

  // GIN
  { brand: 'Bombay Sapphire', name: 'Bombay Sapphire', cat: 'cat_gin', v: [{ size: '1L', price: 54.99 }, { size: '700ml', price: 42.99 }, { size: '500ml', price: 34.99 }] },
  { brand: 'Bombay Sapphire', name: 'East', cat: 'cat_gin', v: [{ size: '700ml', price: 42.99 }] },
  { brand: 'Bombay Sapphire', name: 'Premier', cat: 'cat_gin', v: [{ size: '1L', price: 59.99 }] },
  { brand: 'Star of Bombay', name: 'Star of Bombay', cat: 'cat_gin', v: [{ size: '1L', price: 54.99 }] },
  { brand: 'Bombay Sapphire', name: 'Sunset', cat: 'cat_gin', v: [{ size: '700ml', price: 49.99 }] },
  { brand: 'Still Gin', name: 'Still Gin', cat: 'cat_gin', v: [{ size: '700ml', price: 54.99 }] },
  { brand: 'Monkey 47', name: 'Monkey 47', cat: 'cat_gin', v: [{ size: '700ml', price: 69.99 }] },
  { brand: 'Hendrick’s', name: 'Hendrick’s', cat: 'cat_gin', v: [{ size: '1L', price: 79.99 }, { size: '700ml', price: 64.99 }, { size: '350ml', price: 44.50 }] },
  { brand: 'Beefeater', name: 'Beefeater', cat: 'cat_gin', v: [{ size: '1L', price: 44.99 }, { size: '700ml', price: 34.99 }] },
  { brand: 'Beefeater', name: 'Strawberry', cat: 'cat_gin', v: [{ size: '700ml', price: 34.99 }] },
  { brand: 'Tanqueray', name: 'London Dry Gin', cat: 'cat_gin', v: [{ size: '1L', price: 53.99 }, { size: '700ml', price: 35.99 }, { size: '350ml', price: 22.99 }] },

  // RUM
  { brand: 'Bacardi', name: 'White / Normal', cat: 'cat_rum', v: [{ size: '1L', price: 41.99 }, { size: '700ml', price: 27.99 }, { size: '500ml', price: 21.99 }, { size: '350ml', price: 17.99 }] },
  { brand: 'Bacardi', name: 'Limon', cat: 'cat_rum', v: [{ size: '1L', price: 38.99 }, { size: '700ml', price: 28.99 }] },
  { brand: 'Bacardi', name: 'Tropical', cat: 'cat_rum', v: [{ size: '700ml', price: 28.99 }] },
  { brand: 'Bacardi', name: 'Punch', cat: 'cat_rum', v: [{ size: '700ml', price: 28.99 }] },
  { brand: 'Bacardi', name: 'Coconut', cat: 'cat_rum', v: [{ size: '700ml', price: 28.99 }] },
  { brand: 'Bacardi', name: 'Mojito', cat: 'cat_rum', v: [{ size: '700ml', price: 28.99 }] },
  { brand: 'Bacardi', name: 'Passionfruit', cat: 'cat_rum', v: [{ size: '700ml', price: 28.99 }] },
  { brand: 'Bacardi', name: 'Carta Negra', cat: 'cat_rum', v: [{ size: '1L', price: 41.99 }, { size: '700ml', price: 32.99 }] },
  { brand: 'Bacardi', name: 'Anejo', cat: 'cat_rum', v: [{ size: '1L', price: 54.99 }, { size: '500ml', price: 41.99 }] },
  { brand: 'Bacardi', name: 'Spiced', cat: 'cat_rum', v: [{ size: '1L', price: 39.99 }, { size: '700ml', price: 28.99 }] },
  { brand: 'Captain Morgan', name: 'Captain Morgan', cat: 'cat_rum', v: [{ size: '1L', price: 39.99 }, { size: '700ml', price: 27.99 }] },
  { brand: 'Captain Morgan', name: 'White Rum', cat: 'cat_rum', v: [{ size: '700ml', price: 27.99 }] },
  { brand: 'Old Captain', name: 'Old Captain', cat: 'cat_rum', v: [{ size: '1L', price: 36.99 }, { size: '700ml', price: 27.99 }] },
  { brand: 'Havana Club', name: 'Havana Club', cat: 'cat_rum', v: [{ size: '1L', price: 41.99 }, { size: '700ml', price: 35.99 }] },

  // TEQUILA
  { brand: 'José Cuervo', name: 'José Cuervo', cat: 'cat_tequila', v: [{ size: '1L', price: 54.99 }, { size: '700ml', price: 45.99 }] },
  { brand: 'Sierra Tequila', name: 'Standard', cat: 'cat_tequila', v: [{ size: 'Standard', price: 29.99 }] },
  { brand: 'Patrón', name: 'Standard', cat: 'cat_tequila', v: [{ size: 'Standard', price: 89.99 }] },
  { brand: 'Don Julio', name: 'Don Julio', cat: 'cat_tequila', v: [{ size: '700ml', price: 109.0 }] },
  { brand: 'Tiscaz', name: 'Tiscaz', cat: 'cat_tequila', v: [{ size: '700ml', price: 43.99 }] },

  // DUTCH GIN (GENEVER) & COGNAC
  { brand: 'Ketel 1 Original', name: 'Ketel 1 Original', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 32.99 }, { size: '500ml', price: 19.99 }] },
  { brand: 'Bol’s Corenwijn 2 Jaar Vatgerijpt', name: 'Bol’s Corenwijn 2 Jaar Vatgerijpt', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 54.99 }, { size: '500ml', price: 29.99 }] },
  { brand: 'Bol’s', name: 'Jonge', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 31.99 }] },
  { brand: 'Hope Jonge', name: 'Hope Jonge', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 24.99 }] },
  { brand: 'Hope Vieux', name: 'Hope Vieux', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 26.99 }] },
  { brand: 'Oude Genever', name: '5 Jaar Vat Gelagerd (Blue)', cat: 'cat_dutch_gin_cognac', v: [{ size: '500ml', price: 34.99 }] },
  { brand: 'Oude Genever', name: '5 Jaar Vat Gelagerd (Red)', cat: 'cat_dutch_gin_cognac', v: [{ size: '500ml', price: 34.99 }] },
  { brand: 'Oude Genever', name: '5 Jaar Vat Gelagerd (Gray)', cat: 'cat_dutch_gin_cognac', v: [{ size: '500ml', price: 34.99 }] },
  { brand: 'Oude Genever', name: '5 Jaar Vat Gelagerd (Black)', cat: 'cat_dutch_gin_cognac', v: [{ size: '500ml', price: 34.99 }] },
  { brand: 'Oude Genever', name: '3 Jaar Vat Gelagerd', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 64.99 }] },
  { brand: 'Hennessy', name: 'Very Special', cat: 'cat_dutch_gin_cognac', v: [{ size: '1L', price: 99.99 }, { size: '700ml', price: 71.99 }, { size: '350ml', price: 44.99 }, { size: '200ml', price: 22.99 }] },

  // LIQUEURS / SHOTS
  { brand: 'Buzzball', name: 'Red', cat: 'cat_liqueurs_shots', v: [{ size: 'Standard', price: 8.00 }] },
  { brand: 'Buzzball', name: 'White', cat: 'cat_liqueurs_shots', v: [{ size: 'Standard', price: 8.00 }] },
  { brand: 'Buzzball', name: 'Yellow', cat: 'cat_liqueurs_shots', v: [{ size: 'Standard', price: 8.00 }] },
  { brand: 'Buzzball', name: 'Orange', cat: 'cat_liqueurs_shots', v: [{ size: 'Standard', price: 8.00 }] },

  // CHAMPAGNE / SPARKLING
  { brand: 'Moët & Chandon', name: 'Moët & Chandon', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 94.99 }] },
  { brand: 'Veuve Clicquot', name: 'Veuve Clicquot', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 59.99 }] },
  { brand: 'Piper Heidsieck', name: 'Piper Heidsieck', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 99.99 }] },
  { brand: 'Bernard Bijotat', name: 'Bernard Bijotat', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 59.99 }] },
  { brand: 'Freixenet', name: 'Freixenet', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 19.99 }] },
  { brand: 'Martini Prosecco', name: 'Martini Prosecco', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 19.99 }] },
  { brand: 'Asti', name: 'Asti', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 19.99 }] },
  { brand: 'Pronol Prosecco', name: 'Pronol Prosecco', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 19.99 }] },
  { brand: 'Prosecco Cuvee', name: 'Prosecco Cuvee', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 19.99 }] },
  { brand: 'Prosecco Rose', name: 'Prosecco Rose', cat: 'cat_champagne_sparkling', v: [{ size: 'Standard', price: 21.99 }] },

  // BEER BRANDS
  { brand: 'Heineken', name: 'Can/Bottle', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 3.50 }, { size: '330ml', price: 2.25 }, { size: '250ml', price: 2.75 }] },
  { brand: 'Amstel', name: 'Amstel', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 3.50 }, { size: '330ml', price: 2.25 }] },
  { brand: 'Grolsch', name: 'Grolsch', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 3.50 }, { size: '330ml', price: 2.25 }] },
  { brand: 'Grolsch', name: 'Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 4.75 }, { size: '330ml', price: 4.00 }] },
  { brand: 'Corona', name: 'Corona', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 3.50 }] },
  { brand: 'Hertog Jan', name: 'Hertog Jan', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 3.50 }, { size: '330ml', price: 2.25 }] },
  { brand: 'Brouwerij’TIJ', name: 'Can', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Brouwerij’TIJ', name: 'Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Guinness', name: 'Guinness', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 6.00 }] },
  { brand: 'Guinness', name: 'Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '350ml', price: 6.00 }] },
  { brand: 'Desperados', name: 'Red', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 5.00 }] },
  { brand: 'Desperados', name: 'Original', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 5.00 }] },
  { brand: 'Desperados', name: 'Mojito', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 5.00 }] },
  { brand: 'Desperados', name: 'Red Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Desperados', name: 'Original Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Desperados', name: 'Mojito Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Somersby', name: 'Apple Mango & Lime', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 4.00 }] },
  { brand: 'Somersby', name: 'Blackberry', cat: 'cat_beer_brands', v: [{ size: '500ml', price: 4.00 }] },
  { brand: 'Somersby', name: 'Apple Mango & Lime Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Somersby', name: 'Blackberry Glass Bottle', cat: 'cat_beer_brands', v: [{ size: '330ml', price: 5.00 }] },

  // CANS
  { brand: 'Smirnoff', name: 'Black Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Smirnoff', name: 'Original Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Smirnoff', name: 'Tropical Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Smirnoff', name: 'Raspberry Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Absolut', name: 'Sprite 5% Vodka Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Jack Daniel’s', name: 'Normal Can', cat: 'cat_cans', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Jack Daniel’s', name: 'Cherry Can', cat: 'cat_cans', v: [{ size: '330ml', price: 5.00 }] },
  { brand: 'Lavish', name: 'Whisky Cola', cat: 'cat_cans', v: [{ size: '250ml', price: 5.50 }] },
  { brand: 'Lavish', name: 'Mango', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Strawberry Vanilla', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Grape', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Mangorini', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Orange Spritz', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Fruit Punch', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Purple Grape', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Blue Raspberry', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Passiontini', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Raspberry Guava', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Cosmopolitan', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Green Apple', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: 'Pineapple', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: '10%', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: '17%', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Lavish', name: '21%', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'STELZ', name: 'Mango', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'STELZ', name: 'Peach', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'STELZ', name: 'Raspberry', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'STELZ', name: 'Lime', cat: 'cat_cans', v: [{ size: '250ml', price: 6.00 }] },
  { brand: 'Bacardi', name: 'Coca-Cola Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Razz & Up Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Cuba Libre Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Tropical Breeze Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Sunset Punch Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Limon & Lemonade Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Mojito Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Bacardi', name: 'Mango Mojito Can', cat: 'cat_cans', v: [{ size: '250ml', price: 5.00 }] },
  { brand: 'Smirnoff', name: '4% Original', cat: 'cat_cans', v: [{ size: '700ml', price: 9.99 }] },
  { brand: 'Smirnoff', name: '4% Raspberry', cat: 'cat_cans', v: [{ size: '700ml', price: 9.99 }] },
  { brand: 'Smirnoff', name: '4% (Flavor N/A)', cat: 'cat_cans', v: [{ size: '275ml', price: 4.00 }] },
  { brand: 'Breezer', name: 'Breezer', cat: 'cat_cans', v: [{ size: '275ml', price: 5.00 }] },

  // SEED DRINKS & INFUSED DRINKS
  { brand: 'Cannabis Drinks', name: 'Green Tea', cat: 'cat_seed_drinks_infused', v: [{ size: 'Standard', price: 6.00 }] },
  { brand: 'Cannabis Drinks', name: 'Energy Drink (Normal)', cat: 'cat_seed_drinks_infused', v: [{ size: 'Standard', price: 6.00 }] },
  { brand: 'Cannabis Drinks', name: 'Energy Drink (Power Amsterdam)', cat: 'cat_seed_drinks_infused', v: [{ size: 'Standard', price: 6.00 }] },
  { brand: 'Cannabis Drinks', name: 'Energy Drink (Sostned)', cat: 'cat_seed_drinks_infused', v: [{ size: 'Standard', price: 6.00 }] },

  // SOFT DRINKS
  { brand: 'Coca-Cola', name: 'Can', cat: 'cat_soft_drinks', v: [{ size: '330ml', price: 3.00 }] },
  { brand: 'Coca-Cola', name: 'Bottle', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }, { size: '1.5L', price: 4.75 }] },
  { brand: 'Coca-Cola Zero', name: 'Can', cat: 'cat_soft_drinks', v: [{ size: '330ml', price: 3.00 }] },
  { brand: 'Coca-Cola Zero', name: 'Bottle', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }, { size: '1.5L', price: 4.75 }] },
  { brand: 'Pepsi', name: 'Can', cat: 'cat_soft_drinks', v: [{ size: '330ml', price: 3.00 }] },
  { brand: 'Pepsi', name: 'Bottle', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }, { size: '1.5L', price: 4.75 }] },
  { brand: 'Sprite', name: 'Can', cat: 'cat_soft_drinks', v: [{ size: '330ml', price: 3.00 }] },
  { brand: 'Sprite', name: 'Bottle', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }, { size: '1.5L', price: 4.75 }] },
  { brand: '7UP', name: 'Can', cat: 'cat_soft_drinks', v: [{ size: '330ml', price: 3.00 }] },
  { brand: '7UP', name: 'Bottle', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }, { size: '1.5L', price: 4.75 }] },
  { brand: 'Fanta (All Flavors)', name: 'Can', cat: 'cat_soft_drinks', v: [{ size: '330ml', price: 3.00 }] },
  { brand: 'Fanta (All Flavors)', name: 'Bottle', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }, { size: '1.5L', price: 4.75 }] },
  { brand: 'Red Bull Original', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Sugarfree / Zero', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.50 }] },
  { brand: 'Red Bull Watermelon (Red Edition)', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Tropical (Yellow Edition)', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Blueberry (Blue Edition)', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Coconut Berry', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Strawberry Apricot (Amber Edition)', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Peach / White Peach', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Dragon Fruit', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull Juneberry', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull', name: 'Açaí (Purple Edition)', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull', name: 'Wild Berry', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull', name: 'Fuji Apple & Ginger', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Red Bull', name: 'Iced Vanilla Berry', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Tonic Water', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Ginger Ale Bottle', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Ginger Ale Can', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.25 }] },
  { brand: 'Soda Water', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 5.00 }] },
  { brand: 'Water Normal', name: 'Water Normal', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 2.50 }, { size: '1.5L', price: 3.50 }] },
  { brand: 'Water Sparkling', name: 'Water Sparkling', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 2.50 }, { size: '1.5L', price: 3.50 }] },
  { brand: 'Dimes Juice (Orange)', name: '1L', cat: 'cat_soft_drinks', v: [{ size: '1L', price: 5.00 }] },
  { brand: 'Dimes Juice (Apple)', name: '1L', cat: 'cat_soft_drinks', v: [{ size: '1L', price: 5.00 }] },
  { brand: 'Maaza Guava', name: '500ml', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }] },
  { brand: 'Maaza Lychee', name: '500ml', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 3.50 }] },
  { brand: 'Lipton Sparkling', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.50 }] },
  { brand: 'Lipton Peach', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.50 }] },
  { brand: 'Lipton Lemon', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.50 }] },
  { brand: 'PowerADE', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.25 }] },
  { brand: 'Vitamin Water Limoen', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.75 }] },
  { brand: 'Vitamin Water Framboos', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.75 }] },
  { brand: 'Vitamin Water Citroen', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.75 }] },
  { brand: 'Vitamin Water Mango', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.75 }] },
  { brand: 'Vitamin Water Peer Vlierbloesem', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 3.75 }] },
  { brand: 'Capri-Sun Orange', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 1.75 }] },
  { brand: 'Capri-Sun Cerise', name: 'Standard', cat: 'cat_soft_drinks', v: [{ size: 'Standard', price: 1.75 }] },
  { brand: 'Coconut Water', name: '1L', cat: 'cat_soft_drinks', v: [{ size: '1L', price: 10.00 }] },
  { brand: 'Coconut Water', name: '500ml', cat: 'cat_soft_drinks', v: [{ size: '500ml', price: 5.00 }] },
];

function sanitizeStr(str) {
  return str.replace(/'/g, "''");
}

function generateSlug(str) {
  return str.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
}

// Helper to parse size to ML
const parseSizeML = (sizeStr) => {
  const s = sizeStr.toLowerCase();
  if (s === 'standard') return 750;
  if (s.includes('l') && !s.includes('ml')) {
    const num = parseFloat(s.replace(/[^0-9.]/g, ''));
    return isNaN(num) ? 750 : Math.round(num * 1000);
  }
  if (s.includes('ml')) {
    const num = parseInt(s.replace(/[^0-9]/g, ''), 10);
    return isNaN(num) ? 750 : num;
  }
  return 750;
};

let sql = `-- ==============================================================
-- MASSIVE SEED FILE: BRANDS, PRODUCTS, VARIANTS
-- Execute in Supabase SQL Editor
-- ==============================================================\n\n`;

sql += `DELETE FROM public.product_variants;\n`;
sql += `DELETE FROM public.products;\n\n`;

sql += `DO $$\nDECLARE\n`;
for (const cat of categories) {
  sql += `  v_${cat.id} UUID;\n`;
}
sql += `  v_product_id UUID;\nBEGIN\n\n`;

sql += `-- Insert Categories\n`;
for (const cat of categories) {
  sql += `  INSERT INTO public.categories (name, slug) VALUES ('${sanitizeStr(cat.name)}', '${cat.slug}') ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name RETURNING id INTO v_${cat.id};\n`;
}

sql += `\n-- Insert Products and Variants\n`;

for (const p of productsData) {
  const slug = generateSlug(`${p.brand}-${p.name}`);
  sql += `  -- ${p.brand} ${p.name}\n`;
  sql += `  DECLARE v_product_id UUID;\n`;
  sql += `  BEGIN\n`;
  sql += `    INSERT INTO public.products (category_id, name, slug, brand, description, is_premium, is_featured, is_active)\n`;
  sql += `    VALUES (v_${p.cat}, '${sanitizeStr(p.name)}', '${slug}', '${sanitizeStr(p.brand)}', '${sanitizeStr(p.desc || "")}', ${p.is_premium || false}, true, true)\n`;
  sql += `    ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, brand = EXCLUDED.brand, description = EXCLUDED.description, is_premium = EXCLUDED.is_premium, is_featured = EXCLUDED.is_featured RETURNING id INTO v_product_id;\n\n`;

  p.v.forEach(variant => {
    const sizeML = parseSizeML(variant.size);
    const stockVal = variant.stock !== undefined ? variant.stock : 'floor(random() * 50) + 10';
    sql += `    INSERT INTO public.product_variants (product_id, size_ml, price, stock_quantity, sku)\n`;
    sql += `    VALUES (v_product_id, ${sizeML}, ${variant.price}, ${stockVal}, '${slug}-${variant.size.toLowerCase().replace(/ /g, "-")}')\n`;
    sql += `    ON CONFLICT (sku) DO NOTHING;\n`;
  });
  sql += `  END;\n\n`;
}

sql += `END $$;\n\n`;
sql += `-- Force schema cache refresh\nNOTIFY pgrst, 'reload schema';\n`;

fs.writeFileSync('seed_liquor_data.sql', sql);
console.log('Successfully generated seed_liquor_data.sql');
