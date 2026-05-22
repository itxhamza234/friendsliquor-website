-- Remove delivery_address column from orders table if it exists
-- This column was renamed to shipping_address

DO $$
BEGIN
    -- Check if delivery_address column exists
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'orders' 
        AND column_name = 'delivery_address'
    ) THEN
        -- Drop the column
        ALTER TABLE orders DROP COLUMN delivery_address;
        RAISE NOTICE 'delivery_address column dropped from orders table';
    ELSE
        RAISE NOTICE 'delivery_address column does not exist in orders table';
    END IF;
END $$;

-- Verify the column is removed
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'orders' 
AND column_name IN ('delivery_address', 'shipping_address');
