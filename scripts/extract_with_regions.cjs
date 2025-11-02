const fs = require('fs');

// Read the DoBIH CSV file
const csvContent = fs.readFileSync('/tmp/DoBIH_v18_3.csv', 'utf-8');
const lines = csvContent.split('\n');

// Parse CSV properly handling quoted fields
function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;

  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  result.push(current.trim());
  return result;
}

// Extract Munros with region info
const munros = [];
for (let i = 1; i < lines.length; i++) {
  if (!lines[i].trim()) continue;

  const fields = parseCSVLine(lines[i]);
  const name = fields[1]; // Name
  const section = fields[4]; // Section
  const region = fields[5]; // Region
  const height = parseFloat(fields[13]); // Metres
  const drop = parseFloat(fields[17]); // Drop
  const mColumn = fields[47]; // M column (1=Munro)

  if (mColumn === '1' && !isNaN(height) && !isNaN(drop) && name) {
    munros.push({
      name: name.trim(),
      section: section.trim(),
      region: region.trim(),
      height_m: parseFloat(height.toFixed(1)),
      prominence_m: parseFloat(drop.toFixed(1))
    });
  }
}

console.log(`Found ${munros.length} Munros\n`);

// Check for duplicates
const nameCount = new Map();
munros.forEach(m => {
  nameCount.set(m.name, (nameCount.get(m.name) || 0) + 1);
});

console.log('Munros with duplicate base names:');
nameCount.forEach((count, name) => {
  if (count > 1) {
    console.log(`\n${name} (${count} entries):`);
    munros.filter(m => m.name === name).forEach(m => {
      console.log(`  ${m.section}: ${m.region} - ${m.height_m}m, prominence: ${m.prominence_m}m`);
    });
  }
});

fs.writeFileSync('/tmp/munro_prominence_with_regions.json', JSON.stringify(munros, null, 2));
console.log('\n\nWrote data to /tmp/munro_prominence_with_regions.json');
