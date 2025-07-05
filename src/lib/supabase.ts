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
  console.error('Missing Supabase configuration. Please check your environment variables or MagicMirror config.');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

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
    popular_routes: munro.popular_routes,
    best_seasons: munro.best_seasons,
    image_filename: munro.image_filename,
    classification: munro.classification
  };
}

// Convert Corbett to Mountain format
function corbettToMountain(corbett: Corbett): Mountain {
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
    popular_routes: corbett.popular_routes,
    best_seasons: corbett.best_seasons,
    image_filename: corbett.image_filename,
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
      console.error('Error getting munro count:', error);
      return 0;
    }

    console.log(`Total Munros in database: ${count}`);
    return count || 0;
  } catch (error) {
    console.error('Network error getting munro count:', error);
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
        console.error('Error getting corbett count:', error);
        return 0;
      }

      console.log(`Total Corbetts in database: ${count}`);
      return count || 0;
    }
  } catch (error) {
    console.error('Network error getting mountain count:', error);
    return 0;
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