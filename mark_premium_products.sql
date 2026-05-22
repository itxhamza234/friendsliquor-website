-- Run in Supabase SQL Editor
-- Keeps Royal Salute & Glenfiddich 18 in Premium only (hidden from Whisky/category pages)

UPDATE products
SET is_premium = true
WHERE name ILIKE '%Royal Salute 21 Years Old x Harris Reed%'
   OR name ILIKE '%Glenfiddich 18 Years Old Small Batch%';
