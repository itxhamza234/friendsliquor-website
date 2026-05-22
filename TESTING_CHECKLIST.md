# Website Testing Checklist - Friends Liquor Store

## 1. Authentication & User Management

### 1.1 Sign Up / Registration
- [ ] New user signup with valid email and password
- [ ] Verify user profile is created in database
- [ ] Check if full name is saved correctly
- [ ] Test with duplicate email (should show error)
- [ ] Test with weak password (if validation exists)
- [ ] Verify browser autofill is disabled on signup form
- [ ] After signup, user should be redirected to login

### 1.2 Login
- [ ] Login with correct credentials
- [ ] Login with wrong password (should show error)
- [ ] Login with non-existent email (should show error)
- [ ] Verify browser autofill is disabled on login form
- [ ] After login, redirect to home page
- [ ] Check if user session is maintained

### 1.3 Logout
- [ ] Click logout button
- [ ] Verify user is redirected to home page
- [ ] Verify cart is cleared after logout
- [ ] Try to access protected routes after logout (should redirect)
- [ ] Check if session is properly destroyed

### 1.4 18+ Age Verification
- [ ] Clear localStorage: `localStorage.removeItem('friends-liquor-age-verified')`
- [ ] Refresh page - age verification modal should appear
- [ ] Click "Yes, I am 18+" - modal should close and site should load
- [ ] Refresh again - modal should NOT appear (localStorage set)
- [ ] Click "No, I am under 18" - should redirect to Google
- [ ] Verify no liquor symbols (🥃🍷🍺🍸) are visible

## 2. Homepage

### 2.1 Hero Section
- [ ] Hero image loads correctly
- [ ] "Order Now" button works and redirects to correct page
- [ ] "Explore Collections" button works
- [ ] Text is readable and properly aligned

### 2.2 Premium Drinks Section
- [ ] Premium products load from database
- [ ] Product cards display correctly with images
- [ ] Product names, prices, and details are correct
- [ ] "View All Premium Drinks" button works
- [ ] Hover effects work on product cards

### 2.3 Our Collections Section
- [ ] 5 categories display correctly
- [ ] Each category has background image
- [ ] Images are appropriate for each category:
  - [ ] Whisky/Whiskey - whiskey bottle image
  - [ ] Vodka - vodka bottle image
  - [ ] Gin - whiskey image (as requested)
  - [ ] Rum - rum bottle image
  - [ ] Cans - beer cans image (NOT chair or glass)
  - [ ] Champagne - champagne/sparkling wine
  - [ ] Dutch Gin Genever Cognac - cognac/brandy image
- [ ] Hover effects work (image zoom, text color change)
- [ ] Clicking category redirects to correct category page
- [ ] "View All Categories" button works

### 2.4 Delivery Section
- [ ] Delivery image loads correctly (NOT restaurant photo)
- [ ] Image matches color scheme (dark/red tones)
- [ ] Text is readable
- [ ] Feature badges display correctly

## 3. Product Pages

### 3.1 Product Listing
- [ ] Navigate to /shop or /premium-drinks
- [ ] Products load correctly
- [ ] Filters work (if any)
- [ ] Pagination works (if applicable)
- [ ] Product images load
- [ ] Add to cart buttons work

### 3.2 Product Detail Page
- [ ] Click on a product to view details
- [ ] Product image loads
- [ ] Product name, description, price display correctly
- [ ] Variants (sizes) display correctly
- [ ] Size in ml is shown
- [ ] Add to cart button works
- [ ] Quantity selector works
- [ ] Check for console errors

## 4. Cart & Checkout

### 4.1 Add to Cart
- [ ] Add product to cart
- [ ] Verify cart icon updates with item count
- [ ] Add multiple items
- [ ] Add same product with different variants
- [ ] Check cart in localStorage

### 4.2 Cart Page
- [ ] Navigate to cart page
- [ ] All items display correctly
- [ ] Quantities can be updated
- [ ] Items can be removed
- [ ] Total price calculates correctly
- [ ] Continue to checkout button works

### 4.3 Checkout Process
- [ ] User must be logged in to checkout
- [ ] If not logged in, redirect to login
- [ ] Shipping address form displays
- [ ] Form validation works
- [ ] Shipping address is saved correctly
- [ ] Order is created in database with:
  - [ ] total_amount (NOT NULL)
  - [ ] shipping_address (NOT NULL, renamed from delivery_address)
  - [ ] payment_status = 'pending'
- [ ] Order items are created with:
  - [ ] product_variant_id
  - [ ] quantity
  - [ ] price
  - [ ] price_at_time (NOT NULL)
  - [ ] size_ml (NOT NULL)
- [ ] Stripe checkout session is created
- [ ] User is redirected to Stripe

### 4.4 Payment Completion
- [ ] Complete payment in Stripe test mode
- [ ] Webhook receives checkout.session.completed event
- [ ] Order payment_status updates to 'paid'
- [ ] stripe_payment_id is saved
- [ ] User is redirected back to site
- [ ] Success message displays
- [ ] Cart is cleared after successful payment

### 4.5 Order History
- [ ] Check if user can view past orders
- [ ] Order details display correctly
- [ ] Shipping address shows correctly
- [ ] Order items display with correct details

## 5. Database Checks

### 5.1 Orders Table
- [ ] Check columns exist: total_amount, shipping_address
- [ ] Verify no delivery_address column exists (or is renamed)
- [ ] Check all orders have non-null total_amount
- [ ] Check all orders have non-null shipping_address
- [ ] Verify shipping_address is stored as JSON

### 5.2 Order Items Table
- [ ] Check columns exist: size_ml, price_at_time
- [ ] Verify all order items have non-null size_ml
- [ ] Verify all order items have non-null price_at_time
- [ ] Check price_at_time matches price at time of order

### 5.3 Categories Table
- [ ] Check all categories have correct slugs
- [ ] Verify Gin category is filtered from homepage (if implemented)
- [ ] Check category images are set correctly

### 5.4 Products Table
- [ ] Check premium products have is_premium = true
- [ ] Verify product images are set
- [ ] Check product variants exist

## 6. Stripe Integration

### 6.1 Test Mode
- [ ] Use Stripe test keys
- [ ] Test with test card: 4242 4242 4242 4242
- [ ] Test with failing card: 4000 0000 0000 0002
- [ ] Verify webhook endpoint is reachable
- [ ] Check webhook signature verification

### 6.2 Webhook Events
- [ ] checkout.session.completed - order marked as paid
- [ ] payment_intent.succeeded - (if used)
- [ ] Check webhook logs in Stripe dashboard

## 7. Responsive Design

### 7.1 Mobile (< 768px)
- [ ] Homepage displays correctly
- [ ] Navigation menu works (hamburger)
- [ ] Product cards stack correctly
- [ ] Cart page is usable
- [ ] Checkout form is usable
- [ ] Age verification modal fits screen

### 7.2 Tablet (768px - 1024px)
- [ ] Layout adjusts correctly
- [ ] Grid displays properly
- [ ] Touch targets are large enough

### 7.3 Desktop (> 1024px)
- [ ] Full layout displays
- [ ] Hover effects work
- [ ] All features accessible

## 8. Performance

### 8.1 Load Time
- [ ] Homepage loads in < 3 seconds
- [ ] Product pages load quickly
- [ ] Images are optimized
- [ ] No console errors on load

### 8.2 Console Errors
- [ ] Check browser console for errors
- [ ] Fix any hydration errors
- [ ] Fix any TypeScript errors
- [ ] Fix any network errors

## 9. Security

### 9.1 Authentication
- [ ] Passwords are hashed (bcrypt)
- [ ] Sessions are secure
- [ ] Protected routes redirect unauthenticated users

### 9.2 Data Validation
- [ ] Form inputs are validated
- [ ] SQL injection protection (Supabase RLS)
- [ ] XSS protection

### 9.3 Environment Variables
- [ ] Supabase URL and anon key are set
- [ ] Stripe keys are set (test mode)
- [ ] No sensitive data in client code

## 10. Edge Cases

### 10.1 Empty States
- [ ] What happens when cart is empty?
- [ ] What happens when no products exist?
- [ ] What happens when category has no products?

### 10.2 Error States
- [ ] Network error handling
- [ ] Database error handling
- [ ] Stripe error handling
- [ ] Image load failure handling

### 10.3 User Behavior
- [ ] User adds item, logs out, logs back in - cart should persist
- [ ] User adds item, clears localStorage - what happens?
- [ ] User closes browser during checkout
- [ ] User refreshes during payment

## 11. Browser Compatibility

- [ ] Test in Chrome
- [ ] Test in Firefox
- [ ] Test in Safari
- [ ] Test in Edge
- [ ] Test on mobile browsers

## 12. SEO & Metadata

- [ ] Page titles are correct
- [ ] Meta descriptions exist
- [ ] Open Graph tags (if needed)
- [ ] Favicon loads

## Pre-Launch Final Checks

- [ ] All TypeScript errors resolved
- [ ] All console errors resolved
- [ ] Database migration SQL has been run
- [ ] Stripe webhook is configured in production
- [ ] Environment variables are set for production
- [ ] SSL certificate is active
- [ ] Domain is pointed correctly
- [ ] Backup strategy is in place
- [ ] Monitoring is set up (if applicable)

## How to Test Each Feature

### Testing Age Verification
```javascript
// In browser console
localStorage.removeItem('friends-liquor-age-verified')
location.reload()
```

### Testing Cart Clear on Logout
```javascript
// 1. Add items to cart
// 2. Open console and check:
localStorage.getItem('cart')
// 3. Logout
// 4. Check again - should be null or empty
```

### Testing Database Columns
```sql
-- Check orders table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'orders';

-- Check order_items table  
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'order_items';

-- Check for null values
SELECT COUNT(*) FROM orders WHERE total_amount IS NULL;
SELECT COUNT(*) FROM orders WHERE shipping_address IS NULL;
SELECT COUNT(*) FROM order_items WHERE size_ml IS NULL;
SELECT COUNT(*) FROM order_items WHERE price_at_time IS NULL;
```

### Testing Stripe Webhook
Use Stripe CLI to test webhooks locally:
```bash
stripe listen --forward-to localhost:3000/api/webhooks/stripe
stripe trigger checkout.session.completed
```

## Critical Path Test (Happy Path)

1. Clear all data (localStorage, logout)
2. Visit site → Age verification appears
3. Verify age → Site loads
4. Browse products
5. Add items to cart
6. Go to cart
7. Checkout (login if needed)
8. Fill shipping address
9. Complete payment with Stripe test card
10. Verify order is created in database
11. Verify order is marked as paid
12. Verify cart is cleared
13. Check order history

## Known Issues to Monitor

- [ ] Image loading delays
- [ ] Stripe webhook latency
- [ ] Database connection issues
- [ ] Session timeout behavior
