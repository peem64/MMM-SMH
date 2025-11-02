const fs = require('fs');

// Read the prominence data from DoBIH
const dobihMunros = JSON.parse(fs.readFileSync('/tmp/munro_prominence.json', 'utf-8'));

console.log(`Loaded ${dobihMunros.length} Munros from DoBIH\n`);

// Normalize name for matching
function normalizeName(name) {
  return name
    .toLowerCase()
    .replace(/\[.*?\]/g, '') // Remove [alternative names]
    .replace(/\s*-\s*/g, ' ') // Normalize dashes
    .replace(/['']/g, "'") // Normalize apostrophes
    .replace(/\s+/g, ' ') // Normalize whitespace
    .trim();
}

// Create prominence lookup by normalized name
const prominenceLookup = new Map();
dobihMunros.forEach(m => {
  const key = normalizeName(m.name);
  prominenceLookup.set(key, {
    original_name: m.name,
    prominence_m: m.prominence_m,
    height_m: m.height_m
  });
});

console.log(`Created lookup with ${prominenceLookup.size} entries\n`);

// Generate SQL to update by ID after fetching from database
// We'll output a query that can be run to get IDs, then generate updates
const outputSQL = [];

outputSQL.push(`
-- Step 1: Create temporary mapping table
CREATE TEMP TABLE IF NOT EXISTS prominence_updates (
  munro_name TEXT,
  new_prominence NUMERIC
);

-- Step 2: Insert all prominence mappings
`);

dobihMunros.forEach(m => {
  const safeName = m.name.replace(/'/g, "''");
  outputSQL.push(`INSERT INTO prominence_updates VALUES ('${safeName}', ${m.prominence_m});`);
});

outputSQL.push(`
-- Step 3: Update munros using fuzzy matching
-- This handles variations in naming between DoBIH and our database

-- First, try exact matches (after normalization)
UPDATE munros m
SET prominence_m = pu.new_prominence
FROM prominence_updates pu
WHERE LOWER(REGEXP_REPLACE(REGEXP_REPLACE(m.name, '\\[.*?\\]', '', 'g'), '\\s+', ' ', 'g')) =
      LOWER(REGEXP_REPLACE(REGEXP_REPLACE(pu.munro_name, '\\[.*?\\]', '', 'g'), '\\s+', ' ', 'g'));

-- Then handle names with location qualifiers like "Ben Vorlich (Loch Earn)"
-- by matching the base name and checking if location appears in the munro name
UPDATE munros m
SET prominence_m = pu.new_prominence
FROM prominence_updates pu
WHERE m.prominence_m = m.height_m  -- Only update those not yet fixed
AND (
  -- Match pattern: "Name (Location)" in DB vs just "Name" in DoBIH
  LOWER(REGEXP_REPLACE(m.name, ' \\(.*?\\)', '')) LIKE LOWER(REGEXP_REPLACE(pu.munro_name, '\\[.*?\\]', ''))
  OR
  -- Match with hyphens/spaces normalized
  LOWER(REGEXP_REPLACE(REGEXP_REPLACE(m.name, '[\\s-]+', '', 'g'), '[''']', '''', 'g')) =
  LOWER(REGEXP_REPLACE(REGEXP_REPLACE(pu.munro_name, '[\\s-]+', '', 'g'), '[''']', '''', 'g'))
);

-- Clean up
DROP TABLE prominence_updates;

-- Verify results
SELECT
  COUNT(*) as total,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_need_fixing,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct
FROM munros;
`);

const sqlContent = outputSQL.join('\n');
fs.writeFileSync('/tmp/cc-agent/51019704/project/scripts/update_prominence_fuzzy.sql', sqlContent);

console.log('✅ Generated SQL file: scripts/update_prominence_fuzzy.sql');
console.log('   This uses fuzzy matching to handle name variations\n');
