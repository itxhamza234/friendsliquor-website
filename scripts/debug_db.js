import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing Supabase credentials in .env.local");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkData() {
  console.log("Fetching categories...");
  const { data: categories, error: catErr } = await supabase.from('categories').select('*').order('name');
  if (catErr) console.error("Categories error:", catErr);
  else console.log(`Found ${categories.length} categories:`, categories.map(c => c.name).join(', '));

  console.log("\nFetching products...");
  const { data: products, error: prodErr } = await supabase.from('product_details_view').select('*');
  if (prodErr) console.error("Products error:", prodErr);
  else {
    console.log(`Found ${products.length} products.`);
    
    // Check Whisky (assuming slug is 'whisky')
    const whiskyCat = categories.find(c => c.slug === 'whisky');
    if (whiskyCat) {
      const whiskies = products.filter(p => p.category_id === whiskyCat.id);
      console.log(`\nProducts with category_id matching WHISKY (${whiskyCat.id}): ${whiskies.length}`);
      if (whiskies.length > 0) {
        console.log(`First whisky: ${whiskies[0].product_name}, premium: ${whiskies[0].premium}`);
      }
    } else {
      console.log("\nWHISKY category not found in DB!");
    }
  }
}

checkData();
