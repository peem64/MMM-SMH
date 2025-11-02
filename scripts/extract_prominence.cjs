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

// Extract Munros (Column 48, index 47 = '1' for Munros)
const munros = [];
for (let i = 1; i < lines.length; i++) {
  if (!lines[i].trim()) continue;

  const fields = parseCSVLine(lines[i]);
  const name = fields[1]; // Name column
  const height = parseFloat(fields[13]); // Metres column
  const drop = parseFloat(fields[17]); // Drop column
  const mColumn = fields[47]; // M column (1=Munro)

  if (mColumn === '1' && !isNaN(height) && !isNaN(drop) && name) {
    munros.push({
      name: name.trim(),
      height_m: parseFloat(height.toFixed(1)),
      prominence_m: parseFloat(drop.toFixed(1))
    });
  }
}

console.log(`Found ${munros.length} Munros with prominence data`);

// Write to JSON file
fs.writeFileSync('/tmp/munro_prominence.json', JSON.stringify(munros, null, 2));
console.log('Wrote data to /tmp/munro_prominence.json');
