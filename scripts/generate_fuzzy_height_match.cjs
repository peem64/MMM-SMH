const fs = require('fs');

const dobihMunros = JSON.parse(fs.readFileSync('/tmp/munro_prominence_with_regions.json', 'utf-8'));

console.log(`Generating SQL with fuzzy height matching for ${dobihMunros.length} Munros\n`);

// Generate UPDATE statements that match within 1m tolerance
const updates = dobihMunros.map(m => {
  const safeName = m.name.replace(/'/g, "''");
  return `UPDATE munros SET prominence_m = ${m.prominence_m}
WHERE ABS(height_m - ${m.height_m}) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%${safeName.split('[')[0].trim().substring(0, 15)}%');`;
});

const sql = `/*
  # Fix Remaining Munro Prominence - Fuzzy Height Matching

  Updates remaining 77 Munros where heights don't match exactly
  Uses 1m tolerance for height matching
*/

${updates.join('\n\n')}

-- Final verification
SELECT
  COUNT(*) as total_munros,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
`;

fs.writeFileSync('/tmp/cc-agent/51019704/project/scripts/fuzzy_prominence_fix.sql', sql);
console.log('✅ Generated: scripts/fuzzy_prominence_fix.sql');
console.log('   Uses fuzzy height matching with 1m tolerance\n');
