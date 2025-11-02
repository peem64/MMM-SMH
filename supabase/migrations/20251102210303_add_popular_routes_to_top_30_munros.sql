/*
  # Add Popular Routes to Top 30 Most Famous Munros

  1. Changes
    - Updates popular_routes for 30 of the most famous and frequently climbed munros
    - Routes are based on well-documented and commonly used approaches
    - Each munro receives 2 popular route descriptions matching corbetts format
    
  2. Coverage
    - Includes iconic peaks: Ben Nevis, Ben Lomond, Ben Macdui, Cairn Gorm
    - Covers major mountain ranges: Cairngorms, Glen Coe, Mamores, Grey Corries
    - Routes sourced from established hiking resources and guidebooks
    
  3. Format
    - Routes stored as text[] array (consistent with corbetts table)
    - Simple, descriptive route names (e.g., "Mountain Track", "Northern Corries")
*/

-- Ben Nevis - Scotland's highest, most popular munro
UPDATE munros SET popular_routes = ARRAY['Mountain Track (Tourist Path)', 'CMD Arête via Carn Mor Dearg']
WHERE name = 'Ben Nevis';

-- Ben Lomond - Most southerly munro, extremely popular
UPDATE munros SET popular_routes = ARRAY['Tourist Path from Rowardennan', 'Ptarmigan Ridge route']
WHERE name = 'Ben Lomond';

-- Cairn Gorm - Accessible from ski centre
UPDATE munros SET popular_routes = ARRAY['Northern Corries circuit', 'Fiacaill Ridge route']
WHERE name = 'Cairn Gorm';

-- Ben Macdui - Second highest in Scotland
UPDATE munros SET popular_routes = ARRAY['Via Cairn Gorm plateau', 'Linn of Dee via Sron Riach']
WHERE name = 'Ben Macdui';

-- Aonach Mor - Part of Nevis range
UPDATE munros SET popular_routes = ARRAY['Gondola approach', 'Via Aonach Beag ridge']
WHERE name = 'Aonach Mòr';

-- Aonach Beag (Nevis Range) - Fourth highest
UPDATE munros SET popular_routes = ARRAY['From Aonach Mor', 'Glen Nevis horseshoe']
WHERE name = 'Aonach Beag (Nevis Range)';

-- Braeriach - Third highest, remote Cairngorm
UPDATE munros SET popular_routes = ARRAY['Chalamain Gap approach', 'Lairig Ghru from Linn of Dee']
WHERE name = 'Braeriach';

-- Cairn Toul - Fourth highest, very remote
UPDATE munros SET popular_routes = ARRAY['Via Braeriach traverse', 'Lairig Ghru from Corrour Bothy']
WHERE name = 'Cairn Toul';

-- Ben Lawers - Prominent peak in Perthshire
UPDATE munros SET popular_routes = ARRAY['Visitor Centre path', 'Via Beinn Ghlas ridge']
WHERE name = 'Ben Lawers';

-- Ben More (Crianlarich) - Popular training peak
UPDATE munros SET popular_routes = ARRAY['Benmore Farm direct route', 'Via Stob Binnein traverse']
WHERE name = 'Ben More (Crianlarich)';

-- Buachaille Etive Mor - Iconic Glen Coe peak
UPDATE munros SET popular_routes = ARRAY['Coire na Tulaich path', 'Curved Ridge scramble']
WHERE name = 'Buachaille Etive Mòr';

-- Bidean nam Bian - Highest in Glen Coe
UPDATE munros SET popular_routes = ARRAY['Lost Valley approach', 'Coire Gabhail route']
WHERE name = 'Bidean nam Bian';

-- Ben Cruachan - Hollow mountain with power station
UPDATE munros SET popular_routes = ARRAY['Cruachan Dam route', 'Ridge traverse']
WHERE name = 'Ben Cruachan';

-- Schiehallion - Distinctive conical peak
UPDATE munros SET popular_routes = ARRAY['Braes of Foss path', 'East ridge route']
WHERE name = 'Schiehallion';

-- Ben Lui - Queen of Scottish Mountains
UPDATE munros SET popular_routes = ARRAY['Cononish approach', 'Via Beinn a Chleibh']
WHERE name = 'Ben Lui';

-- Carn Mor Dearg - Part of CMD Arête to Ben Nevis
UPDATE munros SET popular_routes = ARRAY['CMD Arête to Ben Nevis', 'North Face car park route']
WHERE name = 'Càrn Mòr Dearg';

-- Sgurr nan Gillean - Classic Skye Cuillin peak
UPDATE munros SET popular_routes = ARRAY['Tourist Route via Pinnacle Basin', 'West Ridge scramble']
WHERE name = 'Sgurr nan Gillean';

-- Ben Vorlich (Loch Earn) - Popular Southern Highland
UPDATE munros SET popular_routes = ARRAY['Ardvorlich approach', 'Glen Vorlich route']
WHERE name = 'Ben Vorlich (Loch Earn)';

-- Stob Binnein - Twin of Ben More Crianlarich
UPDATE munros SET popular_routes = ARRAY['Via Ben More traverse', 'Direct from Inverlochlarig']
WHERE name = 'Stob Binnein';

-- The Cobbler - Not a munro but updating anyway if exists
UPDATE munros SET popular_routes = ARRAY['Narnain Boulders path', 'Via North Peak scramble']
WHERE name LIKE '%Cobbler%' OR name LIKE '%Ben Arthur%';

-- Liathach - Dramatic Torridon peak
UPDATE munros SET popular_routes = ARRAY['Via Coire Dubh Mor', 'Am Fasarinen pinnacles traverse']
WHERE name = 'Liathach';

-- Beinn Alligin - Torridon beauty
UPDATE munros SET popular_routes = ARRAY['Coire Mhic Nobuil approach', 'Horns of Alligin traverse']
WHERE name = 'Beinn Alligin';

-- Beinn Eighe - First National Nature Reserve
UPDATE munros SET popular_routes = ARRAY['Coire Mhic Fhearchair', 'Triple Buttress route']
WHERE name = 'Beinn Eighe';

-- Sgor Gaoith - Cairngorm with spectacular views
UPDATE munros SET popular_routes = ARRAY['Glen Feshie approach', 'Via Carn Ban Mor']
WHERE name = 'Sgor Gaoith';

-- Carn a'' Mhaim - Gateway to Ben Macdui
UPDATE munros SET popular_routes = ARRAY['Linn of Dee via Derry Lodge', 'Ridge approach from Luibeg']
WHERE name = 'Carn a'' Mhaim';

-- Bynack More - Remote Cairngorm
UPDATE munros SET popular_routes = ARRAY['Glenmore Lodge approach', 'Via Strath Nethy']
WHERE name = 'Bynack More';

-- Ben Avon - Massive Cairngorm plateau
UPDATE munros SET popular_routes = ARRAY['Beinn a Bhuird approach', 'Glen Avon from Tomintoul']
WHERE name = 'Ben Avon';

-- Derry Cairngorm - Eastern Cairngorm
UPDATE munros SET popular_routes = ARRAY['Via Ben Macdui', 'Derry Lodge direct route']
WHERE name = 'Derry Cairngorm';

-- Beinn a'' Bhuird - High Cairngorm plateau
UPDATE munros SET popular_routes = ARRAY['Quoich Water approach', 'Glen Derry route']
WHERE name = 'Beinn a'' Bhùird';

-- Lochnagar - Royal Deeside peak
UPDATE munros SET popular_routes = ARRAY['Spittal of Glen Muick', 'Via Meikle Pap']
WHERE name = 'Lochnagar';