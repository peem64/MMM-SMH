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
    const { data, error } = await supabase
      .from('munros')
      .select('*')
      .order('name')
      .limit(1)
      .range(index, index);

    if (error) {
      console.error('Error fetching munro by index:', error);
      return null;
    }

    return data?.[0] || null;
  } catch (error) {
    console.error('Network error fetching munro by index:', error);
    return null;
  }
}

export async function getMunroCount(): Promise<number> {
  try {
    const { count, error } = await supabase
      .from('munros')
      .select('*', { count: 'exact', head: true });

    if (error) {
      console.error('Error getting munro count:', error);
      return 0;
    }

    return count || 0;
  } catch (error) {
    console.error('Network error getting munro count:', error);
    return 0;
  }
}