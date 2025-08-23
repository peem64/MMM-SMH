import { createClient } from '@supabase/supabase-js';

// Get environment variables from different sources
function getEnvVar(name: string): string {
  // Try Vite environment variables first (for development)
  if (typeof import.meta !== 'undefined' && import.meta.env) {
    const viteVar = import.meta.env[name];
    if (viteVar) return viteVar;
  }
  
  // Try window object (for MagicMirror)
  if (typeof window !== 'undefined') {
    const windowVar = (window as any)[name];
    if (windowVar) return windowVar;
  }
  
  // Try process.env (for Node.js environments)
  if (typeof process !== 'undefined' && process.env) {
    const processVar = process.env[name];
    if (processVar) return processVar;
  }
  
  return '';
}

const supabaseUrl = getEnvVar('VITE_SUPABASE_URL');
const supabaseAnonKey = getEnvVar('VITE_SUPABASE_ANON_KEY');

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('Missing Supabase configuration:', {
    supabaseUrl: supabaseUrl ? 'Present' : 'Missing',
    supabaseAnonKey: supabaseAnonKey ? 'Present' : 'Missing',
    windowVars: typeof window !== 'undefined' ? {
      VITE_SUPABASE_URL: !!(window as any).VITE_SUPABASE_URL,
      VITE_SUPABASE_ANON_KEY: !!(window as any).VITE_SUPABASE_ANON_KEY
    } : 'Window not available',
    viteEnv: typeof import.meta !== 'undefined' && import.meta.env ? {
      VITE_SUPABASE_URL: !!import.meta.env.VITE_SUPABASE_URL,
      VITE_SUPABASE_ANON_KEY: !!import.meta.env.VITE_SUPABASE_ANON_KEY
    } : 'Vite env not available'
  });
}

// Create a fallback client that will show meaningful errors
const createSupabaseClient = () => {
  if (!supabaseUrl || !supabaseAnonKey) {
    // Return a mock client that returns proper error responses
    return {
      from: () => ({
        select: () => ({
          order: () => ({
            limit: () => ({
              range: () => Promise.resolve({ data: null, error: { message: 'Supabase not configured. Please set credentials in MagicMirror config.' }, count: 0 }),
              then: () => Promise.resolve({ data: null, error: { message: 'Supabase not configured. Please set credentials in MagicMirror config.' }, count: 0 })
            }),
            then: () => Promise.resolve({ data: null, error: { message: 'Supabase not configured. Please set credentials in MagicMirror config.' }, count: 0 })
          }),
          then: () => Promise.resolve({ data: null, error: { message: 'Supabase not configured. Please set credentials in MagicMirror config.' }, count: 0 }),
          count: 'exact',
          head: true
        })
      })
    } as any;
  }
  
  return createClient(supabaseUrl, supabaseAnonKey);
};

export const supabase = createSupabaseClient();


export interface MountainCompletion {
  id: string;
  mountain_id: string;
  mountain_type: 'munros' | 'corbetts';
  user_id: string;
  completed_at: string;
  notes: string;
  created_at: string;
  updated_at: string;
}

export interface CompletionStats {
  total_mountains: number;
  completed_mountains: number;
  completion_percentage: number;
  recent_completions: number;
}

export interface Munro {
  id: string;
  name: string;
  height_m: number;
  height_ft: number;
  prominence_m: number;
  classification: string;
  region: string;
  area: string;
  grid_ref: string;
  latitude: number;
  longitude: number;
  first_ascent_year?: number;
  description: string;
  difficulty_rating: number;
  estimated_time_hours: number;
  popular_routes: string[];
  best_seasons: string[];
  significant_info: string;
  image_filename: string;
  created_at: string;
  updated_at: string;
}

export interface Corbett {
  id: number;
  name: string;
  location: string;
  region: string;
  height: number;
  prominence: number;
  classification: string;
  estimated_time: string;
  description: string;
  difficulty_rating: number;
  popular_routes: string[];
  best_seasons: string[];
  grid_reference: string;
  nearest_town: string;
  parking_info: string;
  image_filename: string;
  created_at: string;
  updated_at: string;
}

// Generic mountain type that works for both
export interface Mountain {
  id: string | number;
  name: string;
  height: number;
  prominence: number;
  region: string;
  area?: string;
  location?: string;
  description: string;
  difficulty_rating: number;
  estimated_time: number | string;
  popular_routes: string[];
  best_seasons: string[];
  image_filename: string;
  classification: string;
}

// Convert Munro to Mountain format
function munroToMountain(munro: Munro): Mountain {
  // Generate consistent image filename from name
  const generateImageFilename = (name: string): string => {
    return name.toLowerCase()
      // Handle common Gaelic characters
      .replace(/à/g, 'a')
      .replace(/á/g, 'a')
      .replace(/è/g, 'e')
      .replace(/é/g, 'e')
      .replace(/ì/g, 'i')
      .replace(/í/g, 'i')
      .replace(/ò/g, 'o')
      .replace(/ó/g, 'o')
      .replace(/ù/g, 'u')
      .replace(/ú/g, 'u')
      // Handle special apostrophes and quotes
      .replace(/'/g, '')
      .replace(/'/g, '')
      .replace(/'/g, '')
      // Remove parentheses and their contents
      .replace(/\([^)]*\)/g, '')
      // Replace spaces and remaining special characters with underscores
      .replace(/[^a-z0-9]/g, '_')
      // Clean up multiple underscores
      .replace(/_+/g, '_')
      // Remove leading/trailing underscores
      .replace(/^_|_$/g, '') + '.jpg';
  };

  // Ensure popular_routes is an array
  let popularRoutes = [];
  if (Array.isArray(munro.popular_routes)) {
    popularRoutes = munro.popular_routes;
  } else if (typeof munro.popular_routes === 'string') {
    try {
      popularRoutes = JSON.parse(munro.popular_routes);
    } catch {
      popularRoutes = munro.popular_routes ? [munro.popular_routes] : [];
    }
  }

  // Ensure best_seasons is an array
  let bestSeasons = [];
  if (Array.isArray(munro.best_seasons)) {
    bestSeasons = munro.best_seasons;
  } else if (typeof munro.best_seasons === 'string') {
    try {
      bestSeasons = JSON.parse(munro.best_seasons);
    } catch {
      bestSeasons = munro.best_seasons ? [munro.best_seasons] : [];
    }
  }

  return {
    id: munro.id,
    name: munro.name,
    height: munro.height_m,
    prominence: munro.prominence_m,
    region: munro.region,
    area: munro.area,
    description: munro.description,
    difficulty_rating: munro.difficulty_rating,
    estimated_time: munro.estimated_time_hours,
    popular_routes: popularRoutes,
    best_seasons: bestSeasons,
    image_filename: munro.image_filename || generateImageFilename(munro.name),
    classification: munro.classification
  };
}

// Convert Corbett to Mountain format
function corbettToMountain(corbett: Corbett): Mountain {
  // Generate consistent image filename from name
  const generateImageFilename = (name: string): string => {
    return name.toLowerCase()
      // Handle common Gaelic characters
      .replace(/à/g, 'a')
      .replace(/á/g, 'a')
      .replace(/è/g, 'e')
      .replace(/é/g, 'e')
      .replace(/ì/g, 'i')
      .replace(/í/g, 'i')
      .replace(/ò/g, 'o')
      .replace(/ó/g, 'o')
      .replace(/ù/g, 'u')
      .replace(/ú/g, 'u')
      // Handle special apostrophes and quotes
      .replace(/'/g, '')
      .replace(/'/g, '')
      .replace(/'/g, '')
      // Remove parentheses and their contents
      .replace(/\([^)]*\)/g, '')
      // Replace spaces and remaining special characters with underscores
      .replace(/[^a-z0-9]/g, '_')
      // Clean up multiple underscores
      .replace(/_+/g, '_')
      // Remove leading/trailing underscores
      .replace(/^_|_$/g, '') + '.jpg';
  };

  // Ensure popular_routes is an array
  let popularRoutes = [];
  if (Array.isArray(corbett.popular_routes)) {
    popularRoutes = corbett.popular_routes;
  } else if (typeof corbett.popular_routes === 'string') {
    try {
      popularRoutes = JSON.parse(corbett.popular_routes);
    } catch {
      popularRoutes = corbett.popular_routes ? [corbett.popular_routes] : [];
    }
  }

  // Ensure best_seasons is an array
  let bestSeasons = [];
  if (Array.isArray(corbett.best_seasons)) {
    bestSeasons = corbett.best_seasons;
  } else if (typeof corbett.best_seasons === 'string') {
    try {
      bestSeasons = JSON.parse(corbett.best_seasons);
    } catch {
      bestSeasons = corbett.best_seasons ? [corbett.best_seasons] : [];
    }
  }

  return {
    id: corbett.id,
    name: corbett.name,
    height: corbett.height,
    prominence: corbett.prominence,
    region: corbett.region,
    location: corbett.location,
    description: corbett.description,
    difficulty_rating: corbett.difficulty_rating,
    estimated_time: corbett.estimated_time,
    popular_routes: popularRoutes,
    best_seasons: bestSeasons,
    image_filename: corbett.image_filename || generateImageFilename(corbett.name),
    classification: corbett.classification
  };
}

export async function getMunros(): Promise<Munro[]> {
  try {
    const { data, error } = await supabase
      .from('munros')
      .select('*')
      .order('name');

    if (error) {
      console.error('Error fetching munros:', error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error('Network error fetching munros:', error);
    return [];
  }
}

export async function getRandomMunro(): Promise<Munro | null> {
  try {
    const { data, error } = await supabase
      .from('munros')
      .select('*')
      .limit(1)
      .order('id', { ascending: false });

    if (error) {
      console.error('Error fetching random munro:', error);
      return null;
    }

    return data?.[0] || null;
  } catch (error) {
    console.error('Network error fetching random munro:', error);
    return null;
  }
}

export async function getMunroByIndex(index: number): Promise<Munro | null> {
  try {
    console.log(`Fetching Munro at index ${index}`);
    
    // Use consistent ordering to ensure same Munro for same index
    const { data, error } = await supabase
      .from('munros')
      .select('*')
      .order('name', { ascending: true }) // Consistent alphabetical ordering
      .limit(1)
      .range(index, index);

    if (error) {
      console.error('Error fetching munro by index:', error);
      return null;
    }

    if (!data || data.length === 0) {
      console.error(`No Munro found at index ${index}`);
      return null;
    }

    console.log(`Successfully fetched Munro: ${data[0].name} at index ${index}`);
    return data[0];
  } catch (error) {
    console.error('Network error fetching munro by index:', error);
    return null;
  }
}

export async function getMunroCount(): Promise<number> {
  try {
    console.log('Fetching total Munro count...');
    
    const { count, error } = await supabase
      .from('munros')
      .select('*', { count: 'exact', head: true });

    if (error) {
      console.error('Error getting munro count:', error.message || error);
      return 0;
    }

    console.log(`Total Munros in database: ${count}`);
    return count || 0;
  } catch (error) {
    console.error('Network error getting munro count:', error instanceof Error ? error.message : error);
    return 0;
  }
}

// Generic functions that work with both mountain types
export async function getMountainByIndex(index: number, type: 'munros' | 'corbetts'): Promise<Mountain | null> {
  try {
    console.log(`Fetching ${type} at index ${index}`);
    
    if (type === 'munros') {
      const munro = await getMunroByIndex(index);
      return munro ? munroToMountain(munro) : null;
    } else {
      const { data, error } = await supabase
        .from('corbetts')
        .select('*')
        .order('name', { ascending: true })
        .limit(1)
        .range(index, index);

      if (error) {
        console.error('Error fetching corbett by index:', error);
        return null;
      }

      if (!data || data.length === 0) {
        console.error(`No Corbett found at index ${index}`);
        return null;
      }

      console.log(`Successfully fetched Corbett: ${data[0].name} at index ${index}`);
      return corbettToMountain(data[0]);
    }
  } catch (error) {
    console.error('Network error fetching mountain by index:', error);
    return null;
  }
}

export async function getMountainCount(type: 'munros' | 'corbetts'): Promise<number> {
  try {
    console.log(`Fetching total ${type} count...`);
    
    if (type === 'munros') {
      return await getMunroCount();
    } else {
      const { count, error } = await supabase
        .from('corbetts')
        .select('*', { count: 'exact', head: true });

      if (error) {
        console.error('Error getting corbett count:', error.message || error);
        return 0;
      }

      const actualCount = count || 0;
      console.log(`Total Corbetts in database: ${actualCount}`);
      return count || 0;
    }
  } catch (error) {
    console.error('Network error getting mountain count:', error instanceof Error ? error.message : error);
    return 0;
  }
}

// Add function to verify and report database status
export async function verifyMountainDatabase(type: 'munros' | 'corbetts'): Promise<{
  actualCount: number;
  expectedCount: number;
  isComplete: boolean;
  sampleNames: string[];
}> {
  try {
    const expectedCount = type === 'munros' ? 282 : 222;
    const actualCount = await getMountainCount(type);
    
    // Get sample names to verify data quality
    const { data, error } = await supabase
      .from(type)
      .select('name')
      .order('name', { ascending: true })
      .limit(5);

    if (error) {
      console.error(`Error getting sample ${type}:`, error);
      return {
        actualCount: 0,
        expectedCount,
        isComplete: false,
        sampleNames: []
      };
    }

    const sampleNames = data?.map(item => item.name) || [];
    const isComplete = actualCount === expectedCount;
    
    console.log(`${type.toUpperCase()} Database Status:`, {
      actualCount,
      expectedCount,
      isComplete,
      sampleNames
    });
    
    return {
      actualCount,
      expectedCount,
      isComplete,
      sampleNames
    };
  } catch (error) {
    console.error(`Error verifying ${type} database:`, error);
    return {
      actualCount: 0,
      expectedCount: type === 'munros' ? 282 : 222,
      isComplete: false,
      sampleNames: []
    };
  }
}

// Completion tracking functions
export async function toggleMountainCompletion(
  mountainId: string | number,
  mountainType: 'munros' | 'corbetts',
  notes: string = ''
): Promise<{ action: string; completed: boolean; completion_date: string | null } | null> {
  try {
    console.log('🔄 Starting completion toggle for:', { 
      mountainId, 
      mountainType, 
      notes, 
      idType: typeof mountainId,
      rawId: mountainId 
    });
    
    // Ensure we have a valid user
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      console.error('❌ No authenticated user for completion toggle');
      return null;
    }
    
    console.log('✅ User authenticated:', user.id);
    
    // Handle different ID types for different mountain types
    let mountainIdParam;
    if (mountainType === 'munros') {
      // Munros use UUID strings
      mountainIdParam = String(mountainId);
    } else {
      // Corbetts use integers
      mountainIdParam = typeof mountainId === 'string' ? parseInt(mountainId, 10) : mountainId;
      console.log('🔢 Corbett ID conversion:', mountainId, '->', mountainIdParam, 'isNaN:', isNaN(mountainIdParam));
    }
    
    console.log('🔍 Processing mountain ID:', mountainId, '->', mountainIdParam, 'for', mountainType);
    
    // Use direct table operations instead of RPC to handle different ID types
    // First, check if completion already exists
    console.log('🔍 Checking for existing completion with params:', {
      mountain_id: mountainIdParam,
      mountain_type: mountainType,
      user_id: user.id
    });
    
    const { data: existingCompletion, error: checkError } = await supabase
      .from('mountain_completions')
      .select('*')
      .eq('mountain_id', mountainIdParam)
      .eq('mountain_type', mountainType)
      .eq('user_id', user.id)
      .single();

    console.log('🔍 Check result:', { existingCompletion, checkError });

    if (checkError && checkError.code !== 'PGRST116') {
      console.error('❌ Error checking existing completion:', checkError);
      return null;
    }

    let result;
    if (existingCompletion) {
      console.log('🗑️ Removing existing completion:', existingCompletion.id);
      // Remove completion
      const { error: deleteError } = await supabase
        .from('mountain_completions')
        .delete()
        .eq('id', existingCompletion.id);

      if (deleteError) {
        console.error('❌ Error removing completion:', deleteError);
        return null;
      }

      console.log('✅ Successfully removed completion');
      result = {
        action: 'removed',
        completed: false,
        completion_date: null
      };
    } else {
      console.log('➕ Adding new completion with data:', {
        mountain_id: mountainIdParam,
        mountain_type: mountainType,
        user_id: user.id,
        notes: notes
      });
      
      // Add completion
      const { data: newCompletion, error: insertError } = await supabase
        .from('mountain_completions')
        .insert({
          mountain_id: mountainIdParam,
          mountain_type: mountainType,
          user_id: user.id,
          notes: notes,
          completed_at: new Date().toISOString()
        })
        .select()
        .single();

      if (insertError) {
        console.error('❌ Error adding completion:', insertError);
        console.error('❌ Insert error details:', {
          code: insertError.code,
          message: insertError.message,
          details: insertError.details,
          hint: insertError.hint
        });
        return null;
      }

      console.log('✅ Successfully added completion:', newCompletion);
      result = {
        action: 'added',
        completed: true,
        completion_date: newCompletion.completed_at
      };
    }

    console.log('✅ Final result:', result);
    
    return result;
  } catch (error) {
    console.error('💥 Network error toggling completion:', error);
    console.error('💥 Error details:', {
      name: error.name,
      message: error.message,
      stack: error.stack
    });
    return null;
  }
}

export async function getUserCompletionStats(
  mountainType: 'munros' | 'corbetts' = 'munros'
): Promise<CompletionStats | null> {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      console.log('ℹ️ No authenticated user for completion stats');
      return null;
    }

    console.log('📊 Getting completion stats for user:', user.id, 'type:', mountainType);
    
    const { data, error } = await supabase.rpc('get_user_completion_stats', {
      user_uuid: user.id,
      mountain_type_param: mountainType
    });

    if (error) {
      console.error('❌ Error getting completion stats:', error);
      return null;
    }

    console.log('✅ Completion stats result:', data);
    
    if (!data || data.length === 0) {
      console.log('ℹ️ No completion stats data returned');
      return null;
    }
    
    return data[0];
  } catch (error) {
    console.error('💥 Network error getting completion stats:', error);
    return null;
  }
}

export async function getMountainCompletion(
  mountainId: string | number,
  mountainType: 'munros' | 'corbetts'
): Promise<MountainCompletion | null> {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      return null;
    }

    // Handle different ID types for different mountain types
    let mountainIdParam;
    if (mountainType === 'munros') {
      // Munros use UUID strings
      mountainIdParam = String(mountainId);
    } else {
      // Corbetts use integers
      mountainIdParam = typeof mountainId === 'string' ? parseInt(mountainId, 10) : mountainId;
    }

    const { data, error } = await supabase
      .from('mountain_completions')
      .select('*')
      .eq('mountain_id', mountainIdParam)
      .eq('mountain_type', mountainType)
      .eq('user_id', user.id)
      .single();

    if (error && error.code !== 'PGRST116') {
      console.error('Error getting mountain completion:', error);
      return null;
    }

    return data || null;
  } catch (error) {
    console.error('Network error getting mountain completion:', error);
    return null;
  }
}

export async function getUserCompletions(
  mountainType: 'munros' | 'corbetts' = 'munros'
): Promise<MountainCompletion[]> {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      return [];
    }

    const { data, error } = await supabase
      .from('mountain_completions')
      .select('*')
      .eq('user_id', user.id)
      .eq('mountain_type', mountainType)
      .order('completed_at', { ascending: false });

    if (error) {
      console.error('Error getting user completions:', error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error('Network error getting user completions:', error);
    return [];
  }
}

// Authentication helpers
export async function signInWithEmail(email: string, password: string) {
  try {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    });
    
    if (error) {
      console.error('Error signing in with email:', error);
      return null;
    }
    
    return data.user;
  } catch (error) {
    console.error('Network error signing in with email:', error);
    return null;
  }
}

export async function signUpWithEmail(email: string, password: string) {
  try {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: undefined // Disable email confirmation
      }
    });
    
    if (error) {
      console.error('Error signing up with email:', error);
      return null;
    }
    
    return data.user;
  } catch (error) {
    console.error('Network error signing up with email:', error);
    return null;
  }
}

export async function getCurrentUser() {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    return user;
  } catch (error) {
    console.error('Error getting current user:', error);
    return null;
  }
}

// Helper function to verify database connectivity and data
export async function verifyDatabase(): Promise<{ success: boolean; count: number; sampleMunros: string[] }> {
  try {
    const count = await getMunroCount();
    
    // Get first 5 Munros to verify data
    const { data, error } = await supabase
      .from('munros')
      .select('name')
      .order('name', { ascending: true })
      .limit(5);

    if (error) {
      console.error('Error verifying database:', error);
      return { success: false, count: 0, sampleMunros: [] };
    }

    const sampleNames = data?.map(m => m.name) || [];
    
    return {
      success: true,
      count,
      sampleMunros: sampleNames
    };
  } catch (error) {
    console.error('Network error verifying database:', error);
    return { success: false, count: 0, sampleMunros: [] };
  }
}