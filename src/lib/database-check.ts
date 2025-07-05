import { supabase } from './supabase';

export async function checkAndReportDatabaseStatus() {
  console.log('🔍 MMM-SMH: Comprehensive Database Check');
  console.log('=====================================');
  
  try {
    // Check Munros table
    const { count: munroCount, error: munroError } = await supabase
      .from('munros')
      .select('*', { count: 'exact', head: true });
    
    if (munroError) {
      console.error('❌ Munros table error:', munroError);
      return { munros: 0, corbetts: 0, issues: ['Munros table error'] };
    }
    
    // Check Corbetts table
    const { count: corbettCount, error: corbettError } = await supabase
      .from('corbetts')
      .select('*', { count: 'exact', head: true });
    
    if (corbettError) {
      console.error('❌ Corbetts table error:', corbettError);
      return { munros: munroCount || 0, corbetts: 0, issues: ['Corbetts table error'] };
    }
    
    const actualMunros = munroCount || 0;
    const actualCorbetts = corbettCount || 0;
    const expectedMunros = 282;
    const expectedCorbetts = 222;
    
    // Report status
    console.log(`🏔️ MUNROS: ${actualMunros}/${expectedMunros} ${actualMunros === expectedMunros ? '✅ Complete' : '⚠️ Incomplete'}`);
    console.log(`⛰️ CORBETTS: ${actualCorbetts}/${expectedCorbetts} ${actualCorbetts === expectedCorbetts ? '✅ Complete' : '⚠️ Incomplete'}`);
    
    // Get sample data to verify quality
    const { data: munroSample } = await supabase
      .from('munros')
      .select('name, height_m, region')
      .order('height_m', { ascending: false })
      .limit(5);
    
    const { data: corbettSample } = await supabase
      .from('corbetts')
      .select('name, height, region')
      .order('height', { ascending: false })
      .limit(5);
    
    console.log('📊 Sample Munros:', munroSample?.map(m => `${m.name} (${m.height_m}m)`));
    console.log('📊 Sample Corbetts:', corbettSample?.map(c => `${c.name} (${c.height}m)`));
    
    // Identify issues
    const issues: string[] = [];
    if (actualMunros < expectedMunros) {
      issues.push(`Missing ${expectedMunros - actualMunros} Munros`);
    }
    if (actualCorbetts < expectedCorbetts) {
      issues.push(`Missing ${expectedCorbetts - actualCorbetts} Corbetts`);
    }
    
    if (issues.length > 0) {
      console.log('🚨 ISSUES FOUND:');
      issues.forEach(issue => console.log(`   - ${issue}`));
      console.log('');
      console.log('💡 SOLUTION:');
      console.log('   1. Check if all migration files ran successfully in Supabase');
      console.log('   2. Run the remaining migrations manually in Supabase SQL Editor');
      console.log('   3. Verify RLS policies allow public read access');
    } else {
      console.log('🎉 Database is complete and ready!');
    }
    
    return {
      munros: actualMunros,
      corbetts: actualCorbetts,
      issues,
      munroSample: munroSample?.map(m => m.name) || [],
      corbettSample: corbettSample?.map(c => c.name) || []
    };
    
  } catch (error) {
    console.error('💥 Database check failed:', error);
    return { munros: 0, corbetts: 0, issues: ['Database connection failed'] };
  }
}

// Auto-run in development
if (typeof window !== 'undefined' && import.meta.env.DEV) {
  setTimeout(() => {
    checkAndReportDatabaseStatus();
  }, 1000);
}