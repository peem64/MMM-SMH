// Database verification script for MMM-SMH
// Run this with: node verify-database.js

const { createClient } = require('@supabase/supabase-js');

// You need to set these to your actual Supabase credentials
const SUPABASE_URL = 'YOUR_SUPABASE_URL_HERE';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY_HERE';

if (SUPABASE_URL === 'YOUR_SUPABASE_URL_HERE' || SUPABASE_ANON_KEY === 'YOUR_SUPABASE_ANON_KEY_HERE') {
  console.log('❌ Please edit verify-database.js and add your Supabase credentials');
  console.log('   Get them from: https://supabase.com/dashboard/project/YOUR_PROJECT/settings/api');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function verifyDatabase() {
  console.log('🔍 MMM-SMH Database Verification');
  console.log('================================');
  console.log('');

  try {
    // Check Munros
    console.log('📊 Checking Munros table...');
    const { count: munroCount, error: munroError } = await supabase
      .from('munros')
      .select('*', { count: 'exact', head: true });

    if (munroError) {
      console.log('❌ Munros table error:', munroError.message);
      if (munroError.code === 'PGRST116') {
        console.log('   → Table "munros" does not exist');
        console.log('   → Run the database migrations in Supabase SQL Editor');
      }
    } else {
      const expected = 282;
      const status = munroCount === expected ? '✅' : '⚠️';
      console.log(`${status} Munros: ${munroCount}/${expected}`);
      
      if (munroCount < expected) {
        console.log(`   → Missing ${expected - munroCount} Munros`);
      }
    }

    // Check Corbetts
    console.log('📊 Checking Corbetts table...');
    const { count: corbettCount, error: corbettError } = await supabase
      .from('corbetts')
      .select('*', { count: 'exact', head: true });

    if (corbettError) {
      console.log('❌ Corbetts table error:', corbettError.message);
      if (corbettError.code === 'PGRST116') {
        console.log('   → Table "corbetts" does not exist');
        console.log('   → Run the database migrations in Supabase SQL Editor');
      }
    } else {
      const expected = 222;
      const status = corbettCount === expected ? '✅' : '⚠️';
      console.log(`${status} Corbetts: ${corbettCount}/${expected}`);
      
      if (corbettCount < expected) {
        console.log(`   → Missing ${expected - corbettCount} Corbetts`);
      }
    }

    // Get sample data
    if (!munroError && munroCount > 0) {
      const { data: munroSample } = await supabase
        .from('munros')
        .select('name, height_m')
        .order('height_m', { ascending: false })
        .limit(3);
      
      console.log('🏔️ Top 3 Munros:', munroSample?.map(m => `${m.name} (${m.height_m}m)`));
    }

    if (!corbettError && corbettCount > 0) {
      const { data: corbettSample } = await supabase
        .from('corbetts')
        .select('name, height')
        .order('height', { ascending: false })
        .limit(3);
      
      console.log('⛰️ Top 3 Corbetts:', corbettSample?.map(c => `${c.name} (${c.height}m)`));
    }

    console.log('');
    
    // Provide recommendations
    const totalIssues = [];
    if (munroError || (munroCount && munroCount < 282)) {
      totalIssues.push('Munros incomplete');
    }
    if (corbettError || (corbettCount && corbettCount < 222)) {
      totalIssues.push('Corbetts incomplete');
    }

    if (totalIssues.length > 0) {
      console.log('🚨 ISSUES FOUND:');
      totalIssues.forEach(issue => console.log(`   - ${issue}`));
      console.log('');
      console.log('💡 SOLUTIONS:');
      console.log('   1. Go to your Supabase dashboard: https://supabase.com/dashboard');
      console.log('   2. Navigate to SQL Editor');
      console.log('   3. Run all migration files from supabase/migrations/ in order');
      console.log('   4. Check that RLS policies allow public read access');
      console.log('   5. Verify tables exist and have data');
    } else {
      console.log('🎉 Database is complete and ready!');
      console.log('   Your MMM-SMH module should work perfectly.');
    }

  } catch (error) {
    console.log('💥 Connection failed:', error.message);
    console.log('   → Check your Supabase URL and API key');
    console.log('   → Verify your Supabase project is active');
  }
}

verifyDatabase();