import { supabase } from './supabase';

export async function checkDatabaseStatus() {
  console.log('🔍 Checking database status...');
  
  try {
    // Check Munros
    const { count: munroCount, error: munroError } = await supabase
      .from('munros')
      .select('*', { count: 'exact', head: true });
    
    if (munroError) {
      console.error('❌ Error checking Munros:', munroError);
    } else {
      console.log(`🏔️ Munros: ${munroCount}/282 ${munroCount === 282 ? '✅' : '⚠️'}`);
    }
    
    // Check Corbetts
    const { count: corbettCount, error: corbettError } = await supabase
      .from('corbetts')
      .select('*', { count: 'exact', head: true });
    
    if (corbettError) {
      console.error('❌ Error checking Corbetts:', corbettError);
    } else {
      console.log(`⛰️ Corbetts: ${corbettCount}/222 ${corbettCount === 222 ? '✅' : '⚠️'}`);
    }
    
    // Get sample data
    const { data: munroSample } = await supabase
      .from('munros')
      .select('name, height_m')
      .order('height_m', { ascending: false })
      .limit(3);
    
    const { data: corbettSample } = await supabase
      .from('corbetts')
      .select('name, height')
      .order('height', { ascending: false })
      .limit(3);
    
    console.log('📊 Sample data:');
    console.log('Top 3 Munros:', munroSample);
    console.log('Top 3 Corbetts:', corbettSample);
    
    return {
      munros: { count: munroCount || 0, expected: 282 },
      corbetts: { count: corbettCount || 0, expected: 222 }
    };
    
  } catch (error) {
    console.error('💥 Database check failed:', error);
    return null;
  }
}

// Auto-run verification in development
if (import.meta.env.DEV) {
  checkDatabaseStatus();
}