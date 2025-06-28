import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || '';
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || '';

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
  const { data, error } = await supabase
    .from('munros')
    .select('*')
    .order('name');

  if (error) {
    console.error('Error fetching munros:', error);
    return [];
  }

  return data || [];
}

export async function getRandomMunro(): Promise<Munro | null> {
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
}

export async function getMunroByIndex(index: number): Promise<Munro | null> {
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
}

export async function getMunroCount(): Promise<number> {
  const { count, error } = await supabase
    .from('munros')
    .select('*', { count: 'exact', head: true });

  if (error) {
    console.error('Error getting munro count:', error);
    return 0;
  }

  return count || 0;
}