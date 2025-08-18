import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

// Define __dirname for ES module
const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Read and parse the text file
function parseMunrosTxt(filePath) {
  try {
    const txtContent = fs.readFileSync(filePath, 'utf8');
    const lines = txtContent.split('\n').filter(line => line.trim());
    
    if (lines.length === 0) {
      console.error('❌ Text file is empty');
      return [];
    }
    
    // Skip header line and parse data
    console.log('📊 Processing Munros text file...');
    
    // Parse data rows
    const munros = [];
    for (let i = 1; i < lines.length; i++) {
      const values = lines[i].split('\t').map(v => v.trim());
      
      if (values.length >= 3) {
        const munro = {
          Mountain: values[0],
          Region: values[1],
          Altitude: parseInt(values[2].replace('m', ''), 10)
        };
        munros.push(munro);
      }
    }
    
    console.log(`✅ Parsed ${munros.length} Munros from text file`);
    return munros;
    
  } catch (error) {
    console.error('❌ Error reading text file:', error.message);
    return [];
  }
}

// Generate SQL migration from text data
function generateMigration(munros) {
  if (munros.length === 0) {
    console.error('❌ No Munros data to process');
    return;
  }
  
  console.log('🔍 Sample Munro data:');
  console.log(JSON.stringify(munros[0], null, 2));
  
  let sql = `/*
  # Rebuild Munros Database from Authentic Text Data
  
  This migration completely rebuilds the Munros table with authentic data from allmunros.txt
  
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
    const name = munro.Mountain;
    const heightM = munro.Altitude;
    const heightFt = Math.round(heightM * 3.28084);
    const region = munro.Region;
    const area = ''; // Leave area empty to prevent duplication with region
    const gridRef = ''; // No grid ref in this file, so default to empty
    
    // Generate description and image filename
    const description = `${name} is a ${heightM}m Munro located in ${region}. This peak offers excellent views and is a popular destination for hillwalkers.`;
    
    // Better filename generation that handles Gaelic characters properly
    const imageFilename = name.toLowerCase()
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
  
  const munrosTxtPath = path.join(__dirname, '..', 'public', 'data', 'allmunros.txt');
  console.log('📁 Reading text file:', munrosTxtPath);
  
  if (!fs.existsSync(munrosTxtPath)) {
    console.error('❌ Text file not found:', munrosTxtPath);
    console.log('💡 Available files in public/data/:');
    const dataDir = path.join(__dirname, '..', 'public', 'data');
    if (fs.existsSync(dataDir)) {
      fs.readdirSync(dataDir).forEach(file => {
        console.log(`   - ${file}`);
      });
    }
    return;
  }
  
  const munros = parseMunrosTxt(munrosTxtPath);
  
  if (munros.length === 0) {
    console.error('❌ No Munros data found in text file');
    return;
  }
  
  console.log(`✅ Found ${munros.length} Munros in text file`);
  
  if (munros.length !== 282) {
    console.warn(`⚠️ Expected 282 Munros, found ${munros.length}`);
  }
  
  const migration = generateMigration(munros);
  
  if (migration) {
    const migrationPath = path.join(__dirname, '..', 'supabase', 'migrations', 'rebuild_authentic_munros_from_txt.sql');
    fs.writeFileSync(migrationPath, migration);
    console.log('✅ Migration created:', migrationPath);
    console.log('🚀 Run this migration in Supabase to fix the database');
  }
}

main();