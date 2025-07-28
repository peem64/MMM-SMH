import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// You need to add your Supabase credentials here
const SUPABASE_URL = process.env.VITE_SUPABASE_URL || 'https://rdllpquzaxauhwbtejel.supabase.co';
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkbGxwcXV6YXhhdWh3YnRlamVsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMDEwNDUsImV4cCI6MjA2NjY3NzA0NX0.wKTlZ2-4TpcHSgXI__yNETnPh7mqhL4gbPQ1PRPtga8';

// Check if credentials are set
if (!SUPABASE_URL || SUPABASE_URL === 'YOUR_SUPABASE_URL_HERE' || !SUPABASE_ANON_KEY || SUPABASE_ANON_KEY === 'YOUR_SUPABASE_ANON_KEY_HERE') {
  console.log('❌ Please edit scripts/diagnose-database.js and add your Supabase credentials');
  console.log('   Get them from: https://supabase.com/dashboard/project/YOUR_PROJECT/settings/api');
  console.log('   Or set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in your .env file');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function diagnoseMunrosDatabase() {
  console.log('🔍 MMM-SMH Database Diagnosis');
  console.log('============================');
  console.log('');

  try {
    // Check if table exists and get count
    console.log('📊 Checking Munros table...');
    const { count, error: countError } = await supabase
      .from('munros')
      .select('*', { count: 'exact', head: true });

    if (countError) {
      console.log('❌ Error accessing Munros table:', countError.message);
      if (countError.code === 'PGRST116') {
        console.log('   → Table "munros" does not exist');
        console.log('   → The migration may not have run successfully');
      }
      return;
    }

    console.log(`📈 Total Munros in database: ${count}`);
    console.log(`📈 Expected: 282`);
    
    if (count === 282) {
      console.log('✅ Count is correct!');
    } else if (count === 0) {
      console.log('❌ No Munros found - migration may have failed');
    } else {
      console.log(`⚠️ Missing ${282 - count} Munros`);
    }

    // Get sample data to verify structure
    console.log('');
    console.log('📋 Sample Munros data:');
    const { data: sampleData, error: sampleError } = await supabase
      .from('munros')
      .select('name, height_m, region, image_filename')
      .order('height_m', { ascending: false })
      .limit(5);

    if (sampleError) {
      console.log('❌ Error fetching sample data:', sampleError.message);
    } else if (sampleData && sampleData.length > 0) {
      sampleData.forEach((munro, index) => {
        console.log(`${index + 1}. ${munro.name} (${munro.height_m}m) - ${munro.region} - ${munro.image_filename}`);
      });
    }

    // Check for duplicates
    console.log('');
    console.log('🔍 Checking for duplicates...');
    const { data: duplicates, error: dupError } = await supabase
      .from('munros')
      .select('name, count(*)')
      .group('name')
      .having('count(*) > 1');

    if (dupError) {
      console.log('❌ Error checking duplicates:', dupError.message);
    } else if (duplicates && duplicates.length > 0) {
      console.log(`⚠️ Found ${duplicates.length} duplicate names:`);
      duplicates.forEach(dup => {
        console.log(`   - ${dup.name} (appears ${dup.count} times)`);
      });
    } else {
      console.log('✅ No duplicates found');
    }

    // Check regions
    console.log('');
    console.log('🗺️ Regions breakdown:');
    const { data: regions, error: regionError } = await supabase
      .from('munros')
      .select('region, count(*)')
      .group('region')
      .order('count', { ascending: false });

    if (regionError) {
      console.log('❌ Error checking regions:', regionError.message);
    } else if (regions && regions.length > 0) {
      regions.forEach(region => {
        console.log(`   - ${region.region}: ${region.count} Munros`);
      });
    }

    // Compare with source file
    console.log('');
    console.log('📄 Comparing with source file...');
    const txtPath = path.join(__dirname, '..', 'public', 'data', 'allmunros.txt');
    
    if (fs.existsSync(txtPath)) {
      const txtContent = fs.readFileSync(txtPath, 'utf8');
      const lines = txtContent.split('\n').filter(line => line.trim());
      const sourceCount = lines.length - 1; // Subtract header
      
      console.log(`📄 Source file has: ${sourceCount} Munros`);
      console.log(`💾 Database has: ${count} Munros`);
      
      if (sourceCount === count) {
        console.log('✅ Counts match perfectly!');
      } else {
        console.log(`⚠️ Mismatch: ${Math.abs(sourceCount - count)} difference`);
      }
    } else {
      console.log('❌ Source file not found at:', txtPath);
    }

    // Test the app's query method
    console.log('');
    console.log('🧪 Testing app query method...');
    const { data: testData, error: testError } = await supabase
      .from('munros')
      .select('*')
      .order('name', { ascending: true })
      .limit(1)
      .range(0, 0);

    if (testError) {
      console.log('❌ App query method failed:', testError.message);
    } else if (testData && testData.length > 0) {
      console.log(`✅ App query works: ${testData[0].name} at index 0`);
    } else {
      console.log('❌ App query returned no data');
    }

    // Final recommendations
    console.log('');
    console.log('💡 RECOMMENDATIONS:');
    
    if (count === 0) {
      console.log('   1. Check if the migration actually ran in Supabase SQL Editor');
      console.log('   2. Look for any error messages in the SQL Editor');
      console.log('   3. Verify you ran the migration in the correct database');
    } else if (count < 282) {
      console.log('   1. Check the Supabase SQL Editor for any error messages');
      console.log('   2. The INSERT statements may have partially failed');
      console.log('   3. Try running the migration again');
    } else if (count === 282) {
      console.log('   1. Database looks complete!');
      console.log('   2. Check your app configuration (SUPABASE_URL and SUPABASE_ANON_KEY)');
      console.log('   3. Verify RLS policies allow public read access');
      console.log('   4. Try refreshing your MMM-SMH module');
    }

  } catch (error) {
    console.log('💥 Diagnosis failed:', error.message);
    console.log('   → Check your Supabase credentials');
    console.log('   → Verify your Supabase project is active');
  }
}

diagnoseMunrosDatabase();