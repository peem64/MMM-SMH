const fs = require('fs');

const dobihMunros = JSON.parse(fs.readFileSync('/tmp/munro_prominence_with_regions.json', 'utf-8'));

console.log(`Generating efficient SQL for ${dobihMunros.length} Munros\n`);

// Generate a single UPDATE with CASE statement
const cases = [];

dobihMunros.forEach(m => {
  const safeName = m.name.replace(/'/g, "''");
  cases.push(`  WHEN height_m = ${m.height_m} THEN ${m.prominence_m}`);
});

const sql = `/*
  # Fix All Munro Prominence Values - Efficient Single UPDATE

  Updates all ${dobihMunros.length} Munros with correct prominence using a single CASE statement
  Data source: Database of British and Irish Hills v18.3
*/

UPDATE munros
SET prominence_m = CASE
${cases.join('\n')}
  ELSE prominence_m
END
WHERE height_m IN (${dobihMunros.map(m => m.height_m).join(', ')});

-- Verify results
SELECT
  COUNT(*) as total_munros,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
`;

fs.writeFileSync('/tmp/cc-agent/51019704/project/scripts/efficient_prominence_update.sql', sql);
console.log('✅ Generated efficient SQL: scripts/efficient_prominence_update.sql');
console.log(`   Single UPDATE statement with ${cases.length} CASE conditions\n`);
