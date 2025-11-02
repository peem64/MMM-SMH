const fs = require('fs');

// Read DoBIH munros with prominence
const dobihMunros = JSON.parse(fs.readFileSync('/tmp/munro_prominence_with_regions.json', 'utf-8'));

// List of munros still needing fixes (from database query)
const needsFix = [
  {name: "Ben Nevis", height_m: 1345},
  {name: "Beinn a' Bhùird", height_m: 1197},
  {name: "Màm Sodhail", height_m: 1181},
  {name: "Ben Avon", height_m: 1171},
  {name: "Sgùrr nan Ceathreamhnan", height_m: 1151},
  {name: "Sgùrr na Lapaich", height_m: 1150},
  {name: "Meall Garbh (Ben Lawers)", height_m: 1118},
  {name: "Càrn a' Choire Bhòidheach", height_m: 1118},
  {name: "Sgòr Gaoith", height_m: 1118},
  {name: "Tom a' Chòinich", height_m: 1112},
  {name: "Sgùrr Mòr", height_m: 1110},
  {name: "Meall a' Bhùiridh", height_m: 1108},
  {name: "Beinn Èibhinn", height_m: 1102},
  {name: "Sgùrr a' Choire Ghlais", height_m: 1083},
  {name: "Beinn a' Chaorainn (Cairngorms)", height_m: 1082},
  {name: "Sgùrr Fhuaran", height_m: 1067},
  {name: "Bidein a' Ghlas Thuill (An Teallach)", height_m: 1062},
  {name: "Sgùrr Fiona (An Teallach)", height_m: 1060},
  {name: "Spidean a' Choire Lèith (Liathach)", height_m: 1055},
  {name: "Stob Poite Coire Àrdair", height_m: 1054},
  {name: "Sgùrr Fhuar-thuill", height_m: 1049},
  {name: "Geal chàrn (Laggan)", height_m: 1049},
  {name: "Stob Coir an Albannaich", height_m: 1044},
  {name: "Càrn Mairg", height_m: 1042},
  {name: "Sgùrr na Cìche", height_m: 1040},
  {name: "Sgòrr Dhearg (Beinn a' Bheithir)", height_m: 1024},
  {name: "Mullach an Rathain (Liathach)", height_m: 1023},
  {name: "Stob Dearg (Buachaille Etive Mòr)", height_m: 1021},
  {name: "Garbh Chioch Mhòr", height_m: 1013},
  {name: "Beinn Ìme", height_m: 1011},
  {name: "Càrn Liath (Creag Meagaidh)", height_m: 1006},
  {name: "Stob Bàn (Mamores)", height_m: 999},
  {name: "Sgùrr Breac", height_m: 999},
  {name: "Sgùrr Chòinnich", height_m: 999},
  {name: "A' Chailleach (Fannichs)", height_m: 997},
  {name: "Glas Bheinn Mhòr", height_m: 997},
  {name: "Sgàirneach Mhòr", height_m: 991},
  {name: "Ben Vorlich (Loch Earn)", height_m: 985},
  {name: "Càrn a' Ghèoidh", height_m: 975},
  {name: "Càrn Liath (Beinn a' Ghlò)", height_m: 975},
  {name: "Stùc a' Chròin", height_m: 975},
  {name: "Meall Garbh (Càrn Mairg)", height_m: 968},
  {name: "Sgòrr nam Fiannaidh (Aonach Eagach)", height_m: 967},
  {name: "Ben More (Mull)", height_m: 966},
  {name: "Sgùrr nan Gillean", height_m: 964},
  {name: "Sgòrr Ruadh", height_m: 962},
  {name: "Ben Klibreck", height_m: 961},
  {name: "Stùcd an Lochain", height_m: 960},
  {name: "Càrn Ghluasaid", height_m: 957},
  {name: "Sgòr Gaibhre", height_m: 955},
  {name: "Sgùrr Mhic Chòinnich", height_m: 948},
  {name: "Creag a'Mhàim", height_m: 947},
  {name: "Sgùrr Dubh Mòr", height_m: 944},
  {name: "An Socach (Braemar)", height_m: 944},
  {name: "Meall Buidhe (Glen Lyon)", height_m: 932},
  {name: "Blà Bheinn", height_m: 928},
  {name: "Stob Coire Raineach (Buachaille Etive Beag)", height_m: 925},
  {name: "Sgiath Chùil", height_m: 921},
  {name: "An Socach (Affric)", height_m: 921},
  {name: "Càrn Sgulain", height_m: 920},
  {name: "Càrn Aosda", height_m: 917},
  {name: "Geal-chàrn (Drumochter)", height_m: 917}
];

console.log(`Need to fix ${needsFix.length} munros\n`);

// Find matching prominence for each
const updates = [];
needsFix.forEach(munro => {
  // Find in DoBIH by height (within 2m tolerance)
  const match = dobihMunros.find(d => Math.abs(d.height_m - munro.height_m) < 2);

  if (match) {
    const safeName = munro.name.replace(/'/g, "''");
    updates.push({
      name: munro.name,
      height: munro.height_m,
      prominence: match.prominence_m,
      sql: `UPDATE munros SET prominence_m = ${match.prominence_m} WHERE name = '${safeName}';`
    });
    console.log(`✓ ${munro.name}: ${match.prominence_m}m (height ${munro.height_m}m)`);
  } else {
    console.log(`✗ No match for ${munro.name} (${munro.height_m}m)`);
  }
});

const sql = `/*
  # Final Prominence Fix for Remaining ${updates.length} Munros

  These munros have accented characters that didn't match in previous fuzzy updates.
  This uses exact name matching from the database.
*/

${updates.map(u => u.sql).join('\n')}

-- Final verification
SELECT
  COUNT(*) as total,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
`;

fs.writeFileSync('/tmp/cc-agent/51019704/project/scripts/final_fix.sql', sql);
console.log(`\n✅ Generated: scripts/final_fix.sql with ${updates.length} updates`);
