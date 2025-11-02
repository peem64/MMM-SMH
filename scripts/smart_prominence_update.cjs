const fs = require('fs');

// Read DoBIH data with regions
const dobihMunros = JSON.parse(fs.readFileSync('/tmp/munro_prominence_with_regions.json', 'utf-8'));

console.log(`Processing ${dobihMunros.length} Munros from DoBIH\n`);

// For munros with duplicate names, use height as the matching key
const prominenceLookup = new Map();

dobihMunros.forEach(m => {
  const baseName = m.name.replace(/\[.*?\]/g, '').trim().toLowerCase();

  // Create a key using both name and height for precise matching
  const key = `${baseName}|${m.height_m}`;
  prominenceLookup.set(key, m.prominence_m);
});

console.log(`Created ${prominenceLookup.size} unique name+height combinations\n`);

// Generate SQL that matches by name AND height
const sqlStatements = [];

sqlStatements.push(`/*
  # Fix Remaining Munro Prominence Values Using Height Matching

  1. Strategy
    - Match Munros by BOTH name and height for precise identification
    - This handles duplicates like "Ben Vorlich" which appear twice with different heights

  2. Updates
    - Updates all remaining Munros where prominence still equals height
    - Uses height as the discriminator for duplicate names
*/

`);

dobihMunros.forEach(m => {
  const safeName = m.name.replace(/'/g, "''");

  // Update using both name and height for precise matching
  const sql = `UPDATE munros SET prominence_m = ${m.prominence_m} WHERE height_m = ${m.height_m} AND (
  name ILIKE '%${safeName.split('[')[0].trim()}%' OR
  LOWER(REGEXP_REPLACE(name, '\\[.*?\\]', '')) = LOWER('${safeName.replace(/\[.*?\]/g, '').trim()}')
);`;

  sqlStatements.push(sql);
});

sqlStatements.push(`
-- Verify the fix
SELECT
  COUNT(*) as total,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
`);

const outputSQL = sqlStatements.join('\n');
fs.writeFileSync('/tmp/cc-agent/51019704/project/scripts/fix_prominence_by_height.sql', outputSQL);

console.log('✅ Generated: scripts/fix_prominence_by_height.sql');
console.log('   Uses height + name matching for precise updates\n');
