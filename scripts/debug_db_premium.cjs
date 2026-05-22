const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

const envLocal = fs.readFileSync('.env.local', 'utf8');
const envVars = {};
envLocal.split('\n').forEach(line => {
  const [key, ...rest] = line.split('=');
  if (key && rest.length) envVars[key.trim()] = rest.join('=').trim().replace(/['"]/g, '');
});

const supabaseUrl = envVars['NEXT_PUBLIC_SUPABASE_URL'];
const supabaseKey = envVars['NEXT_PUBLIC_SUPABASE_ANON_KEY'];
const supabase = createClient(supabaseUrl, supabaseKey);

async function checkData() {
  console.log("Fetching premium products...");
  const { data: premiumProducts, error: prodErr } = await supabase.from('product_details_view').select('*').eq('premium', true);
  if (prodErr) console.error("Products error:", prodErr);
  else {
    console.log(`Found ${premiumProducts.length} premium products.`);
    if (premiumProducts.length > 0) {
       premiumProducts.forEach(p => console.log(`- ${p.product_name} (premium: ${p.premium})`));
    }
  }
}

checkData();
