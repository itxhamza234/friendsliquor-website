-- Run once: set your account as admin to access /admin
-- Replace with your login email

UPDATE public.users
SET role = 'admin'
WHERE email = 'your-email@example.com';
