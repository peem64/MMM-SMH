import fs from 'fs';
import path from 'path';

// Read and parse the CSV file
function parseCSV(filePath) {
  try {
    const csvContent = fs.readFileSync(filePath, 'utf8');
    const lines = csvContent.split('\n').filter(line => line.trim());
    
    if (lines.length === 0) {
      console.error('❌ CSV file is empty');
      return [];
    }
    
    // Get headers from first line
    const headers = lines[0].split(',').map(h => h.trim().replace(/"/g, ''));
    console.log('📊 CSV Headers:', headers);
    
    // Parse data rows
    const munros = [];
    for (let i = 1; i < lines.length; i++) {
      const values = lines[i].split(',').map(v => v.trim().replace(/"/g, ''));
      
      if (values.length >= headers.length) {
        const munro = {};
        headers.forEach((header, index) => {
          munro[header] = values[index] || '';
        });
        munros.push(munro);
      }
    }
    
    console.log(`✅ Parsed ${munros.length} Munros from CSV`);
    return munros;
    
  } catch (error) {
    console.error('❌ Error reading CSV file:', error.message);
    return [];
  }
}

// Generate SQL migration from CSV data
function generateMigration(munros) {
  if (munros.length === 0) {
    console.error('❌ No Munros data to process');
    return;
  }
  
  console.log('🔍 Sample Munro data:');
  console.log(JSON.stringify(munros[0], null, 2));
  
  let sql = `/*
  # Rebuild Munros Database from Authentic CSV Data
  
  This migration completely rebuilds the Munros table with authentic data from munrotab_v8.0.1.csv
  
  1. Drops existing corrupted table
  2. Creates new table with proper structure
  3. Inserts all ${munros.length} authentic Scottish Munros
  4. Sets up proper RLS and policies
  
  Expected result: Exactly ${munros.length} authentic Munros
*/

-- Drop existing corrupted table
DROP TABLE IF EXISTS munros CASCADE;

-- Create new Munros table with proper structure
CREATE TABLE munros (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  height_m integer NOT NULL,
  height_ft integer NOT NULL,
  prominence_m integer NOT NULL DEFAULT 0,
  classification text NOT NULL DEFAULT 'Munro',
  region text NOT NULL,
  area text NOT NULL DEFAULT '',
  grid_ref text NOT NULL DEFAULT '',
  latitude numeric(10,7) NOT NULL DEFAULT 0,
  longitude numeric(10,7) NOT NULL DEFAULT 0,
  first_ascent_year integer,
  description text NOT NULL DEFAULT '',
  difficulty_rating integer NOT NULL DEFAULT 3 CHECK (difficulty_rating >= 1 AND difficulty_rating <= 5),
  estimated_time_hours numeric(3,1) NOT NULL DEFAULT 6.0,
  popular_routes jsonb NOT NULL DEFAULT '[]'::jsonb,
  best_seasons jsonb NOT NULL DEFAULT '["Spring", "Summer", "Autumn"]'::jsonb,
  significant_info text DEFAULT '',
  image_filename text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE munros ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Public read access for munros"
  ON munros
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- Create indexes for performance
CREATE INDEX idx_munros_name ON munros (name);
CREATE INDEX idx_munros_height ON munros (height_m DESC);
CREATE INDEX idx_munros_region ON munros (region);
CREATE INDEX idx_munros_location ON munros (region, area);

-- Insert authentic Munros data
INSERT INTO munros (
  name, height_m, height_ft, region, area, grid_ref, 
  description, difficulty_rating, estimated_time_hours, image_filename
) VALUES\n`;

  // Process each Munro
  munros.forEach((munro, index) => {
    // Map CSV fields to our database structure
    const name = munro.Name || munro.name || `Unknown Munro ${index + 1}`;
    const heightM = parseInt(munro.Height || munro.height_m || munro['Height(m)'] || '914');
    const heightFt = parseInt(munro['Height(ft)'] || munro.height_ft || Math.round(heightM * 3.28084));
    const region = munro.Region || munro.region || munro.Area || 'Unknown';
    const area = munro.Area || munro.area || munro.Section || region;
    const gridRef = munro['Grid Ref'] || munro.grid_ref || munro.GridRef || '';
    
    // Generate description and image filename
    const description = `${name} is a ${heightM}m Munro located in ${region}. This peak offers excellent views and is a popular destination for hillwalkers.`;
    const imageFilename = name.toLowerCase()
      .replace(/[^a-z0-9\s]/g, '')
      .replace(/\s+/g, '_')
      .replace(/_+/g, '_')
      .replace(/^_|_$/g, '') + '.jpg';
    
    // Estimate difficulty and time based on height
    const difficulty = heightM > 1200 ? 4 : heightM > 1000 ? 3 : 2;
    const estimatedTime = heightM > 1200 ? 8.0 : heightM > 1000 ? 6.5 : 5.5;
    
    sql += `  ('${name.replace(/'/g, "''")}', ${heightM}, ${heightFt}, '${region.replace(/'/g, "''")}', '${area.replace(/'/g, "''")}', '${gridRef}', '${description.replace(/'/g, "''")}', ${difficulty}, ${estimatedTime}, '${imageFilename}')`;
    
    if (index < munros.length - 1) {
      sql += ',\n';
    } else {
      sql += ';\n';
    }
  });

  sql += `
-- Verify the data
SELECT 
  COUNT(*) as total_munros,
  MIN(height_m) as min_height,
  MAX(height_m) as max_height,
  COUNT(DISTINCT region) as regions
FROM munros;

-- Show sample data
SELECT name, height_m, region FROM munros ORDER BY height_m DESC LIMIT 10;
`;

  return sql;
}

// Main execution
function main() {
  console.log('🏔️ Rebuilding Munros Database from CSV');
  console.log('=====================================');
  
  const csvPath = path.join(__dirname, '..', 'public', 'data', 'munrotab_v8.0.1.csv');
  console.log('📁 Reading CSV file:', csvPath);
  
  if (!fs.existsSync(csvPath)) {
    console.error('❌ CSV file not found:', csvPath);
    console.log('💡 Available files in public/data/:');
    const dataDir = path.join(__dirname, '..', 'public', 'data');
    if (fs.existsSync(dataDir)) {
      fs.readdirSync(dataDir).forEach(file => {
        console.log(`   - ${file}`);
      });
    }
    return;
  }
  
  const munros = parseCSV(csvPath);
  
  if (munros.length === 0) {
    console.error('❌ No Munros data found in CSV');
    return;
  }
  
  console.log(`✅ Found ${munros.length} Munros in CSV`);
  
  if (munros.length !== 282) {
    console.warn(`⚠️ Expected 282 Munros, found ${munros.length}`);
  }
  
  const migration = generateMigration(munros);
  
  if (migration) {
    const migrationPath = path.join(__dirname, '..', 'supabase', 'migrations', 'rebuild_authentic_munros.sql');
    fs.writeFileSync(migrationPath, migration);
    console.log('✅ Migration created:', migrationPath);
    console.log('🚀 Run this migration in Supabase to fix the database');
  }
}

main();