/*
  # Add Popular Routes to Additional Famous Munros

  1. Changes
    - Updates popular_routes for additional famous munros with correct database names
    - Covers Torridon peaks, Glen Coe peaks, and other iconic mountains
    
  2. Coverage
    - Liathach peaks (Mullach an Rathain, Spidean a' Choire Leith)
    - Beinn Alligin peaks (Sgurr Mor, Tom na Gruagaich)
    - Buachaille Etive Mor peaks (Stob Dearg, Stob na Broige)
    - Glen Coe peaks including Bidean nam Bian
*/

-- Liathach - Mullach an Rathain (western summit)
UPDATE munros SET popular_routes = ARRAY['Coire Dubh Mor approach', 'Via Fasarinen Pinnacles']
WHERE name = 'Mullach an Rathain (Liathach)';

-- Liathach - Spidean a' Choire Leith (main summit)
UPDATE munros SET popular_routes = ARRAY['Coire Dubh Mor to summit', 'Ridge traverse from Mullach an Rathain']
WHERE name = 'Spidean a'' Choire Lèith (Liathach)';

-- Beinn Alligin - Sgurr Mor (main summit)
UPDATE munros SET popular_routes = ARRAY['Coire Mhic Nobuil approach', 'Horns of Alligin traverse']
WHERE name = 'Sgùrr Mòr (Beinn Alligin)';

-- Beinn Alligin - Tom na Gruagaich
UPDATE munros SET popular_routes = ARRAY['Via Coire nan Laogh', 'Ridge from Sgurr Mor']
WHERE name = 'Tom na Gruagaich (Beinn Alligin)';

-- Buachaille Etive Mor - Stob Dearg (the iconic peak)
UPDATE munros SET popular_routes = ARRAY['Coire na Tulaich path', 'Curved Ridge scramble']
WHERE name = 'Stob Dearg (Buachaille Etive Mòr)';

-- Buachaille Etive Mor - Stob na Broige
UPDATE munros SET popular_routes = ARRAY['Via Lairig Gartain', 'Ridge from Stob Dearg']
WHERE name = 'Stob na Bròige (Buachaille Etive Mòr)';

-- Bidean nam Bian - Highest in Glen Coe
UPDATE munros SET popular_routes = ARRAY['Lost Valley (Coire Gabhail)', 'An t-Sron ridge']
WHERE name = 'Bidean nam Bian';

-- Beinn Eighe - First National Nature Reserve (if exists with different spelling)
UPDATE munros SET popular_routes = ARRAY['Coire Mhic Fhearchair', 'Triple Buttress approach']
WHERE name LIKE 'Beinn Eighe%' OR name LIKE 'Ruadh-stac Mòr%';

-- Ben Vorlich Loch Lomond (if different from Loch Earn)
UPDATE munros SET popular_routes = ARRAY['Inveruglas approach', 'Via Little Hills']
WHERE name = 'Ben Vorlich (Loch Lomond)';

-- Stob Coire Sgreamhach (Glen Coe)
UPDATE munros SET popular_routes = ARRAY['Via Bidean nam Bian', 'Coire Gabhail approach']
WHERE name = 'Stob Coire Sgreamhach';

-- An Teallach peaks (if they exist)
UPDATE munros SET popular_routes = ARRAY['Corrie Hallie approach', 'Via Sail Liath']
WHERE name LIKE 'Bidein a'' Ghlas Thuill%' OR name LIKE 'Sgurr Fiona%';