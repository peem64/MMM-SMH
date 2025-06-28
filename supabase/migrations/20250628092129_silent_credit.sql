/*
  # Complete Scottish Munros Database Setup

  1. New Tables
    - `munros` (if not exists)
      - Complete table structure for all Scottish Munros
      - All necessary columns for mountain data
      - Proper constraints and indexes

  2. Data Population
    - Insert comprehensive dataset of major Scottish Munros
    - Covers all key mountain ranges and regions
    - Includes detailed climbing information and metadata

  3. Security
    - Enable RLS on munros table
    - Add policy for public read access
*/

-- Create the munros table if it doesn't exist
CREATE TABLE IF NOT EXISTS munros (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  height_m integer NOT NULL,
  height_ft integer NOT NULL,
  prominence_m integer NOT NULL,
  classification text NOT NULL DEFAULT 'Munro',
  region text NOT NULL,
  area text NOT NULL,
  grid_ref text NOT NULL,
  latitude numeric(10, 7) NOT NULL,
  longitude numeric(10, 7) NOT NULL,
  first_ascent_year integer,
  description text NOT NULL,
  difficulty_rating integer CHECK (difficulty_rating >= 1 AND difficulty_rating <= 5) NOT NULL,
  estimated_time_hours numeric(3, 1) NOT NULL,
  popular_routes jsonb NOT NULL DEFAULT '[]',
  best_seasons jsonb NOT NULL DEFAULT '[]',
  significant_info text DEFAULT '',
  image_filename text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS if not already enabled
ALTER TABLE munros ENABLE ROW LEVEL SECURITY;

-- Create policy if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE tablename = 'munros' AND policyname = 'Public read access for munros'
  ) THEN
    CREATE POLICY "Public read access for munros"
      ON munros
      FOR SELECT
      TO anon, authenticated
      USING (true);
  END IF;
END $$;

-- Create indexes if they don't exist
CREATE INDEX IF NOT EXISTS idx_munros_random ON munros USING btree (id);
CREATE INDEX IF NOT EXISTS idx_munros_location ON munros USING btree (region, area);

-- Insert Scottish Munros data
INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) VALUES 

-- Ben Nevis and surrounding peaks
('Ben Nevis', 1345, 4413, 1345, 'Munro', 'Highlands', 'Lochaber', 'NN166712', 56.7967, -5.0037, 1771, 'The highest mountain in Scotland and the British Isles, Ben Nevis is a challenging climb with spectacular views. The summit plateau can be treacherous in poor weather conditions.', 4, 7.5, '["Tourist Path (Pony Track)", "Carn Mor Dearg Arete", "Tower Ridge", "North Face routes"]', '["Late Spring", "Summer", "Early Autumn"]', 'Home to Ben Nevis Observatory ruins. Popular with both tourists and serious mountaineers. Can experience arctic conditions even in summer.', 'ben_nevis.jpg'),

('Carn Mor Dearg', 1220, 4003, 123, 'Munro', 'Highlands', 'Lochaber', 'NN177722', 56.8058, -4.9775, 1847, 'Connected to Ben Nevis by the famous CMD Arete, this peak offers spectacular views and is often climbed as part of a traverse with Ben Nevis.', 4, 8.0, '["CMD Arete from Ben Nevis", "Direct ascent from Glen Nevis", "Allt a Mhuilinn approach"]', '["Late Spring", "Summer", "Early Autumn"]', 'The CMD Arete is considered one of the finest ridge walks in Scotland. Name means Big Red Cairn.', 'carn_mor_dearg.jpg'),

('Aonach Beag', 1234, 4049, 130, 'Munro', 'Highlands', 'Lochaber', 'NN196717', 56.8019, -4.9856, 1847, 'Often climbed together with Ben Nevis, Aonach Beag offers spectacular views and is less crowded than its famous neighbor. The name means Little Ridge.', 3, 6.0, '["Via Aonach Mor", "CMD Arete approach", "Direct from Glen Nevis"]', '["Late Spring", "Summer", "Early Autumn"]', 'Fourth highest mountain in Scotland. Popular winter climbing destination.', 'aonach_beag.jpg'),

('Aonach Mor', 1221, 4006, 121, 'Munro', 'Highlands', 'Lochaber', 'NN193730', 56.8139, -4.9889, 1847, 'Home to the Nevis Range ski area, Aonach Mor provides easy access via gondola and excellent views of Ben Nevis and the surrounding peaks.', 2, 3.0, '["Nevis Range Gondola", "Tourist path from gondola", "Direct ascent from Glen Nevis"]', '["All seasons - winter sports popular"]', 'Accessible via gondola making it popular with families. Excellent skiing in winter.', 'aonach_mor.jpg'),

-- Cairngorms National Park
('Ben Macdui', 1309, 4295, 950, 'Munro', 'Highlands', 'Cairngorms', 'NJ989989', 57.0703, -3.6689, 1810, 'The second highest mountain in Scotland, Ben Macdui is shrouded in mist and legend. The summit plateau is vast and can be disorienting in poor weather.', 3, 7.0, '["Lairig Ghru approach", "Derry Cairngorm route", "Coire Sputan Dearg"]', '["Summer", "Early Autumn"]', 'Associated with the legend of the Big Grey Man (Am Fear Liath Mor). Remote and wild feeling despite accessibility.', 'ben_macdui.jpg'),

('Braeriach', 1296, 4252, 758, 'Munro', 'Highlands', 'Cairngorms', 'NN953999', 57.0781, -3.7289, 1810, 'The third highest mountain in Scotland, Braeriach offers stunning views over the Lairig Ghru. Known for its corries and arctic-alpine vegetation.', 3, 8.0, '["Lairig Ghru approach", "Chalamain Gap", "Sron na Lairige"]', '["Summer", "Early Autumn"]', 'Contains some of the highest cliffs in Scotland. Important for rare alpine plants.', 'braeriach.jpg'),

('Cairn Toul', 1291, 4236, 501, 'Munro', 'Highlands', 'Cairngorms', 'NN964972', 57.0606, -3.7111, 1810, 'Part of the Braeriach massif, Cairn Toul offers spectacular cliff scenery and is often climbed with Braeriach. Remote and wild character.', 3, 8.5, '["Via Braeriach", "Lairig Ghru approach", "Corrour Bothy route"]', '["Summer", "Early Autumn"]', 'Name means Hill of the Barn. Features impressive corries and cliff faces.', 'cairn_toul.jpg'),

('Sgor an Lochain Uaine', 1258, 4127, 82, 'Munro', 'Highlands', 'Cairngorms', 'NN954976', 57.0644, -3.7200, 1810, 'Known as the Angels Peak, this mountain is often climbed with Cairn Toul and offers stunning views of the Lairig Ghru.', 3, 8.0, '["Via Cairn Toul", "Lairig Ghru approach", "Corrour Bothy route"]', '["Summer", "Early Autumn"]', 'The Angels Peak - named for its ethereal appearance. Part of the Braeriach horseshoe.', 'sgor_an_lochain_uaine.jpg'),

('Cairn Gorm', 1245, 4085, 757, 'Munro', 'Highlands', 'Cairngorms', 'NJ005040', 57.1117, -3.6778, 1810, 'Part of the Cairngorms National Park, this mountain offers excellent skiing in winter and beautiful plateau walking. The name means Blue Cairn in Gaelic.', 2, 4.5, '["Northern Corries", "Fiacaill a Choire Chais", "Windy Ridge"]', '["All seasons - winter sports popular"]', 'Accessible via Cairngorm Mountain Railway. Important habitat for ptarmigan and mountain hare.', 'cairn_gorm.jpg'),

('Ben Lawers', 1214, 3983, 901, 'Munro', 'Highlands', 'Perthshire', 'NN636414', 56.5656, -4.2267, 1878, 'The highest mountain in the southern Highlands, Ben Lawers is famous for its rare alpine flora and excellent views over Loch Tay.', 2, 5.0, '["Tourist path from visitor centre", "Beinn Ghlas traverse", "Lawers village approach"]', '["Late Spring", "Summer", "Early Autumn"]', 'National Nature Reserve with rare arctic-alpine plants. Visitor centre and nature trails.', 'ben_lawers.jpg'),

-- Perthshire Munros
('Schiehallion', 1083, 3553, 718, 'Munro', 'Highlands', 'Perthshire', 'NN714548', 56.6553, -4.1067, 1769, 'The Fairy Hill of the Caledonians is famous for its perfect cone shape and historical significance in determining the Earths mass. Excellent all-round views.', 2, 4.0, '["East Ridge (normal route)", "Braes of Foss approach"]', '["All seasons"]', 'Used in 1774 Maskelyne experiment to determine Earths density. Replanted with native trees.', 'schiehallion.jpg'),

('Ben More (Crianlarich)', 1174, 3852, 966, 'Munro', 'Highlands', 'Perthshire', 'NN432244', 56.3978, -4.5689, NULL, 'A prominent peak visible from much of central Scotland, Ben More offers excellent views and is often climbed with neighbouring Stob Binnein.', 3, 5.5, '["Benmore Farm approach", "Glen Dochart route", "Stob Binnein traverse"]', '["Spring", "Summer", "Autumn"]', 'Most southerly Munro over 1000m. Excellent viewpoint for central Scotland.', 'ben_more_crianlarich.jpg'),

('Stob Binnein', 1165, 3822, 319, 'Munro', 'Highlands', 'Perthshire', 'NN434227', 56.3956, -4.5667, NULL, 'Often climbed with Ben More, Stob Binnein offers a fine ridge walk and excellent views. The name means Peak of the Anvil.', 3, 6.0, '["Via Ben More", "Inverlochlarig approach", "Glen Dochart route"]', '["Spring", "Summer", "Autumn"]', 'Connected to Ben More by a fine ridge. Name means Peak of the Anvil.', 'stob_binnein.jpg'),

-- West Highlands
('Ben Cruachan', 1126, 3694, 918, 'Munro', 'Highlands', 'Argyll', 'NN069304', 56.4267, -5.1556, NULL, 'The highest peak in Argyll, Ben Cruachan dominates the landscape around Loch Awe. Known for its dramatic ridges and corries.', 3, 6.0, '["Falls of Cruachan route", "Reservoir dam approach", "Stob Dearg traverse"]', '["Spring", "Summer", "Autumn"]', 'Hollow mountain contains Cruachan Power Station. Excellent views over Loch Awe.', 'ben_cruachan.jpg'),

('Bidean nam Bian', 1150, 3773, 870, 'Munro', 'Highlands', 'Lochaber', 'NN143542', 56.6700, -5.0700, NULL, 'The highest peak in Argyll, hidden in Glen Coe. A complex mountain with multiple ridges and corries offering challenging climbing.', 4, 7.0, '["Coire Gabhail (Hidden Valley)", "An t-Sron ridge", "Coire nan Lochan"]', '["Late Spring", "Summer", "Early Autumn"]', 'Highest peak in Argyll. Complex mountain with multiple tops and challenging navigation.', 'bidean_nam_bian.jpg'),

('Ben Starav', 1078, 3537, 675, 'Munro', 'Highlands', 'Argyll', 'NN125427', 56.5533, -5.0833, NULL, 'A fine mountain at the head of Loch Etive, Ben Starav offers excellent rock climbing and beautiful corrie scenery.', 3, 6.5, '["Glen Etive approach", "Coileitir approach", "Glas Bheinn traverse"]', '["Spring", "Summer", "Autumn"]', 'Excellent rock climbing on Gully Face. Beautiful position at head of Loch Etive.', 'ben_starav.jpg'),

-- Torridon
('Liathach', 1055, 3461, 671, 'Munro', 'Highlands', 'Torridon', 'NG929580', 57.5500, -5.4833, NULL, 'One of the most spectacular mountains in Scotland, Liathach offers a challenging ridge traverse with incredible exposure and views.', 5, 8.0, '["Northern Pinnacles traverse", "Coire Dubh Mor", "Am Fasarinen traverse"]', '["Summer", "Early Autumn"]', 'Quartzite and sandstone mountain. One of the most challenging Munro traverses in Scotland.', 'liathach.jpg'),

('Beinn Eighe', 1010, 3314, 632, 'Munro', 'Highlands', 'Torridon', 'NG951595', 57.5667, -5.4500, NULL, 'Britains first National Nature Reserve, Beinn Eighe offers spectacular quartzite ridges and ancient Caledonian pine forest.', 4, 7.0, '["Coire Dubh approach", "Glen Torridon route", "Triple Buttress"]', '["Summer", "Early Autumn"]', 'First National Nature Reserve in Britain. Ancient Caledonian pine forest at base.', 'beinn_eighe.jpg'),

('Beinn Alligin', 985, 3232, 885, 'Munro', 'Highlands', 'Torridon', 'NG866613', 57.5833, -5.5500, NULL, 'The Jewelled Mountain offers one of the finest ridge walks in Scotland with the famous Horns of Alligin providing spectacular scrambling.', 4, 6.5, '["Coire nan Laogh", "Horns of Alligin traverse", "Tom na Gruagaich route"]', '["Summer", "Early Autumn"]', 'The Jewelled Mountain. Famous for the Horns of Alligin scramble.', 'beinn_alligin.jpg'),

-- Skye Cuillin
('Sgurr Alasdair', 992, 3255, 992, 'Munro', 'Highlands', 'Skye', 'NG450208', 57.2083, -6.2167, 1873, 'The highest peak on Skye and in the Cuillin, Sgurr Alasdair requires rock climbing skills to reach the summit. Spectacular gabbro climbing.', 5, 10.0, '["Stone Shoot", "South West Ridge", "Great Stone Chute"]', '["Summer"]', 'Highest peak on Skye. Requires rock climbing skills. Named after Alexander Nicolson.', 'sgurr_alasdair.jpg'),

('Sgurr Dearg (Inaccessible Pinnacle)', 986, 3235, 26, 'Munro', 'Highlands', 'Skye', 'NG444215', 57.2150, -6.2233, 1880, 'The only Munro requiring rock climbing to complete, the Inaccessible Pinnacle is a dramatic blade of gabbro offering the most technical Munro ascent.', 5, 12.0, '["East Ridge (Moderate)", "West Ridge (Difficult)"]', '["Summer"]', 'Only Munro requiring rock climbing. Most technical Munro ascent. Blade of gabbro rock.', 'sgurr_dearg_inaccessible_pinnacle.jpg'),

-- Affric and Cannich
('Mam Sodhail', 1181, 3875, 988, 'Munro', 'Highlands', 'Affric', 'NH120253', 57.2833, -5.1500, NULL, 'The highest peak in the Affric area, Mam Sodhail offers excellent views and is often climbed as part of the South Glen Shiel Ridge.', 3, 7.0, '["Glen Affric approach", "Cluanie Inn route", "An Riabhachan traverse"]', '["Spring", "Summer", "Autumn"]', 'Highest peak in Glen Affric area. Excellent views of surrounding peaks and lochs.', 'mam_sodhail.jpg'),

('Carn Eighe', 1183, 3881, 672, 'Munro', 'Highlands', 'Affric', 'NH123262', 57.2917, -5.1417, NULL, 'One of the most remote Munros, Carn Eighe offers a challenging approach through beautiful Glen Affric and spectacular summit views.', 3, 8.0, '["Glen Affric approach", "Loch Mullardoch route", "Beinn Fhionnlaidh traverse"]', '["Summer", "Early Autumn"]', 'One of the most remote Munros. Long approach through beautiful Glen Affric.', 'carn_eighe.jpg'),

-- Knoydart
('Ladhar Bheinn', 1020, 3346, 820, 'Munro', 'Highlands', 'Knoydart', 'NG824040', 57.0667, -5.6833, NULL, 'The most westerly Munro on the mainland, Ladhar Bheinn offers spectacular coastal views and requires a boat trip or long walk to access.', 4, 8.0, '["Barrisdale approach", "Inverie route", "Coire Dhorrcail"]', '["Spring", "Summer", "Autumn"]', 'Most westerly mainland Munro. Spectacular coastal views. Remote Knoydart peninsula.', 'ladhar_bheinn.jpg'),

-- Morvern and Ardgour
('Garbh Bheinn', 885, 2903, 885, 'Munro', 'Highlands', 'Ardgour', 'NM904601', 56.7167, -5.7500, NULL, 'A dramatic peak overlooking Loch Linnhe, Garbh Bheinn offers excellent rock climbing and spectacular views across to Mull.', 3, 6.0, '["Coire an Iubhair", "Great Ridge", "Pinnacle Ridge"]', '["Spring", "Summer", "Autumn"]', 'Dramatic peak overlooking Loch Linnhe. Excellent rock climbing opportunities.', 'garbh_bheinn.jpg'),

-- Mull
('Ben More (Mull)', 966, 3169, 966, 'Munro', 'Highlands', 'Mull', 'NM526331', 56.4167, -6.0167, NULL, 'The only Munro on Mull, Ben More offers spectacular island views and a challenging ascent from sea level. Often combined with A Chioch.', 3, 6.5, '["Dhiseig approach", "Glen More route", "A Chioch traverse"]', '["Spring", "Summer", "Autumn"]', 'Only Munro on an island. Spectacular views across the Inner Hebrides.', 'ben_more_mull.jpg'),

-- Mamores
('Binnein Mor', 1130, 3707, 450, 'Munro', 'Highlands', 'Mamores', 'NN212663', 56.7833, -4.9667, NULL, 'The highest peak in the Mamores, Binnein Mor offers excellent ridge walking and spectacular views of Ben Nevis and the surrounding peaks.', 3, 6.0, '["Kinlochleven approach", "Mamore Lodge route", "Na Gruagaichean traverse"]', '["Spring", "Summer", "Autumn"]', 'Highest peak in the Mamores. Excellent ridge walking with spectacular views.', 'binnein_mor.jpg'),

('Na Gruagaichean', 1056, 3465, 56, 'Munro', 'Highlands', 'Mamores', 'NN203652', 56.7750, -4.9750, NULL, 'Part of the Mamores ridge, Na Gruagaichean offers excellent walking with spectacular views. Often climbed with Binnein Mor.', 3, 6.5, '["Via Binnein Mor", "Kinlochleven approach", "Mamore Lodge route"]', '["Spring", "Summer", "Autumn"]', 'Part of the excellent Mamores ridge walk. Name means The Maidens.', 'na_gruagaichean.jpg'),

('An Gearanach', 982, 3222, 82, 'Munro', 'Highlands', 'Mamores', 'NN188670', 56.7917, -4.9917, NULL, 'A fine peak in the Mamores offering excellent ridge walking and spectacular views. Often climbed as part of the Mamores traverse.', 3, 7.0, '["Ring of Steall", "Kinlochleven approach", "An Garbhanach traverse"]', '["Spring", "Summer", "Autumn"]', 'Part of the famous Ring of Steall walk. Excellent ridge walking.', 'an_gearanach.jpg'),

('Stob Coire a Chairn', 981, 3218, 81, 'Munro', 'Highlands', 'Mamores', 'NN185661', 56.7833, -4.9917, NULL, 'A prominent peak in the Mamores offering excellent views and ridge walking. Part of the classic Mamores traverse.', 3, 7.0, '["Ring of Steall", "Kinlochleven approach", "Am Bodach traverse"]', '["Spring", "Summer", "Autumn"]', 'Prominent peak in the Mamores. Part of the classic Ring of Steall.', 'stob_coire_a_chairn.jpg'),

('Am Bodach', 1032, 3386, 132, 'Munro', 'Highlands', 'Mamores', 'NN169651', 56.7750, -5.0083, NULL, 'The Old Man offers spectacular views down Glen Nevis and across to Ben Nevis. Part of the excellent Mamores ridge.', 3, 6.5, '["Ring of Steall", "Glen Nevis approach", "Sgurr a Mhaim traverse"]', '["Spring", "Summer", "Autumn"]', 'The Old Man - spectacular views down Glen Nevis. Part of Ring of Steall.', 'am_bodach.jpg'),

('Sgurr a Mhaim', 1099, 3606, 399, 'Munro', 'Highlands', 'Mamores', 'NN164667', 56.7833, -5.0167, NULL, 'A spectacular peak offering one of the finest views of Ben Nevis. The Devils Ridge provides an exciting scramble to the summit.', 4, 6.0, '["Devils Ridge", "Glen Nevis approach", "Sgor an Iubhair traverse"]', '["Spring", "Summer", "Autumn"]', 'Spectacular views of Ben Nevis. Famous Devils Ridge scramble.', 'sgurr_a_mhaim.jpg'),

('Sgor an Iubhair', 1001, 3284, 101, 'Munro', 'Highlands', 'Mamores', 'NN165658', 56.7750, -5.0167, NULL, 'The Peak of the Yew offers excellent views and is often climbed with Sgurr a Mhaim. Part of the western Mamores.', 3, 6.5, '["Via Sgurr a Mhaim", "Glen Nevis approach", "Steall Falls route"]', '["Spring", "Summer", "Autumn"]', 'The Peak of the Yew. Often climbed with Sgurr a Mhaim.', 'sgor_an_iubhair.jpg'),

-- Grey Corries
('Stob Choire Claurigh', 1177, 3862, 777, 'Munro', 'Highlands', 'Lochaber', 'NN262739', 56.8250, -4.9000, NULL, 'The highest peak in the Grey Corries, offering excellent ridge walking and spectacular views of Ben Nevis and the surrounding peaks.', 3, 7.0, '["Corriechoille approach", "Lairig Leacach", "Stob Ban traverse"]', '["Spring", "Summer", "Autumn"]', 'Highest peak in the Grey Corries. Excellent ridge walking with quartzite summits.', 'stob_choire_claurigh.jpg'),

('Stob Coire an Laoigh', 1116, 3661, 216, 'Munro', 'Highlands', 'Lochaber', 'NN240724', 56.8083, -4.9250, NULL, 'Part of the Grey Corries ridge, offering excellent walking on quartzite peaks with spectacular views.', 3, 7.5, '["Via Stob Choire Claurigh", "Corriechoille approach", "Sgurr Choinnich Mor traverse"]', '["Spring", "Summer", "Autumn"]', 'Part of the Grey Corries ridge. Beautiful quartzite peaks.', 'stob_coire_an_laoigh.jpg'),

('Sgurr Choinnich Mor', 1095, 3593, 195, 'Munro', 'Highlands', 'Lochaber', 'NN227714', 56.7917, -4.9417, NULL, 'A fine peak in the Grey Corries offering excellent ridge walking and spectacular views. The quartzite summit provides excellent grip.', 3, 7.5, '["Grey Corries traverse", "Corriechoille approach", "Stob Ban route"]', '["Spring", "Summer", "Autumn"]', 'Fine peak in Grey Corries. Quartzite summit provides excellent grip.', 'sgurr_choinnich_mor.jpg'),

('Stob Ban', 977, 3205, 77, 'Munro', 'Highlands', 'Lochaber', 'NN266722', 56.8083, -4.8917, NULL, 'The White Peak is famous for its quartzite summit that gleams white in sunlight. Offers excellent views and ridge walking.', 3, 6.5, '["Corriechoille approach", "Grey Corries traverse", "Lairig Leacach route"]', '["Spring", "Summer", "Autumn"]', 'The White Peak - quartzite summit gleams white in sunlight.', 'stob_ban.jpg'),

-- Arrochar Alps
('Ben Vorlich (Loch Lomond)', 943, 3094, 666, 'Munro', 'Highlands', 'Arrochar', 'NN295124', 56.2333, -4.7500, NULL, 'A popular Munro easily accessible from central Scotland, Ben Vorlich offers excellent views over Loch Lomond and the surrounding hills.', 2, 4.5, '["Ardlui approach", "Inveruglas route", "Little Hills traverse"]', '["All seasons"]', 'Popular with day walkers from Glasgow. Excellent views over Loch Lomond.', 'ben_vorlich_loch_lomond.jpg'),

('Ben Vane', 915, 3002, 315, 'Munro', 'Highlands', 'Arrochar', 'NN278098', 56.2083, -4.7750, NULL, 'A steep and challenging Munro in the Arrochar Alps, Ben Vane offers excellent views despite its modest height.', 3, 5.0, '["Inveruglas approach", "Coiregrogain route", "Ben Vorlich traverse"]', '["Spring", "Summer", "Autumn"]', 'Steep and challenging despite modest height. Part of Arrochar Alps.', 'ben_vane.jpg'),

('Ben Ime', 1011, 3317, 611, 'Munro', 'Highlands', 'Arrochar', 'NN255085', 56.1917, -4.8083, NULL, 'The highest peak in the Arrochar Alps, Ben Ime offers excellent views and challenging climbing. Often approached via the Cobbler.', 3, 5.5, '["Succoth approach", "Butterbridge route", "The Cobbler traverse"]', '["Spring", "Summer", "Autumn"]', 'Highest peak in Arrochar Alps. Often combined with The Cobbler.', 'ben_ime.jpg'),

('Beinn Bhuidhe', 948, 3110, 648, 'Munro', 'Highlands', 'Arrochar', 'NN204187', 56.2667, -4.8833, NULL, 'A remote Munro offering excellent views over Loch Fyne and the surrounding hills. Less crowded than other Arrochar peaks.', 2, 5.0, '["Glen Fyne approach", "Inverchorachan route", "Loch Sloy approach"]', '["Spring", "Summer", "Autumn"]', 'Remote peak with excellent views over Loch Fyne. Less crowded.', 'beinn_bhuidhe.jpg'),

-- Trossachs
('Ben Lomond', 974, 3196, 974, 'Munro', 'Highlands', 'Trossachs', 'NN367028', 56.1917, -4.6333, NULL, 'Scotlands most southerly Munro and one of the most popular, Ben Lomond offers spectacular views over Loch Lomond and easy access from Glasgow.', 2, 4.0, '["Tourist path from Rowardennan", "Ptarmigan route", "Ben Lomond Way"]', '["All seasons"]', 'Most southerly Munro. Most popular mountain in Scotland. Easy access from Glasgow.', 'ben_lomond.jpg'),

-- More Cairngorms
('Derry Cairngorm', 1155, 3789, 155, 'Munro', 'Highlands', 'Cairngorms', 'NO017980', 57.0583, -3.6417, NULL, 'A fine peak in the heart of the Cairngorms, offering excellent plateau walking and spectacular corrie scenery.', 3, 7.0, '["Linn of Dee approach", "Glen Derry route", "Ben Macdui traverse"]', '["Summer", "Early Autumn"]', 'Heart of Cairngorms. Excellent plateau walking and corrie scenery.', 'derry_cairngorm.jpg'),

('Beinn a Chaorainn', 1082, 3550, 582, 'Munro', 'Highlands', 'Cairngorms', 'NJ045013', 57.0833, -3.6083, NULL, 'A remote Munro in the eastern Cairngorms, offering excellent views and challenging navigation across the plateau.', 3, 8.0, '["Glen Avon approach", "Tomintoul route", "Beinn Bhreac traverse"]', '["Summer", "Early Autumn"]', 'Remote eastern Cairngorms peak. Challenging plateau navigation.', 'beinn_a_chaorainn.jpg'),

('Beinn Bhreac', 931, 3054, 331, 'Munro', 'Highlands', 'Cairngorms', 'NJ058971', 57.0500, -3.5917, NULL, 'A rounded hill in the eastern Cairngorms, often climbed with Beinn a Chaorainn. Offers excellent views across the Cairngorm plateau.', 2, 7.5, '["Via Beinn a Chaorainn", "Glen Avon approach", "Tomintoul route"]', '["Summer", "Early Autumn"]', 'Rounded hill in eastern Cairngorms. Often combined with Beinn a Chaorainn.', 'beinn_bhreac.jpg'),

-- Additional major peaks to expand the dataset
('Lochnagar', 1155, 3789, 755, 'Munro', 'Highlands', 'Cairngorms', 'NO244861', 56.9583, -3.2417, NULL, 'A magnificent mountain with spectacular corries and cliffs, Lochnagar is famous for its dramatic north face and royal connections.', 3, 6.5, '["Spittal of Glenmuick", "Glen Muick approach", "Cac Carn Beag traverse"]', '["Spring", "Summer", "Autumn"]', 'Royal connections - beloved by Queen Victoria. Spectacular corries and granite cliffs.', 'lochnagar.jpg'),

('Mount Keen', 939, 3081, 939, 'Munro', 'Highlands', 'Cairngorms', 'NO409869', 56.9667, -2.9833, NULL, 'The most easterly Munro, Mount Keen offers excellent views and is often climbed via the historic Mounth Road.', 2, 5.5, '["Glen Tanar approach", "Invermark route", "Mounth Road"]', '["Spring", "Summer", "Autumn"]', 'Most easterly Munro. Historic Mounth Road crossing. Excellent views to North Sea.', 'mount_keen.jpg'),

-- Fisherfield Forest
('An Teallach', 1062, 3484, 762, 'Munro', 'Highlands', 'Fisherfield', 'NH069844', 57.7667, -5.3167, NULL, 'One of the finest mountains in Scotland, An Teallach offers spectacular ridge walking with dramatic pinnacles and corries.', 5, 9.0, '["Dundonnell approach", "Corrie Hallie route", "Pinnacle Ridge traverse"]', '["Summer", "Early Autumn"]', 'One of the finest mountains in Scotland. Spectacular pinnacle ridge. Remote Fisherfield location.', 'an_teallach.jpg'),

('Mullach Coire Mhic Fhearchair', 1019, 3343, 219, 'Munro', 'Highlands', 'Fisherfield', 'NH052842', 57.7583, -5.3333, NULL, 'Part of the An Teallach massif, this peak offers spectacular views and challenging ridge walking in remote Fisherfield.', 4, 9.5, '["Via An Teallach", "Dundonnell approach", "Corrie Hallie route"]', '["Summer", "Early Autumn"]', 'Part of An Teallach massif. Remote Fisherfield location with spectacular ridge walking.', 'mullach_coire_mhic_fhearchair.jpg'),

-- Fannichs
('Sgurr Mor', 1110, 3642, 710, 'Munro', 'Highlands', 'Fannichs', 'NH203718', 57.6833, -4.9667, NULL, 'The highest peak in the Fannichs, Sgurr Mor offers excellent ridge walking and spectacular views across the northwest Highlands.', 3, 7.5, '["Fannich Lodge approach", "Loch Fannich route", "Beinn Liath Mhor traverse"]', '["Spring", "Summer", "Autumn"]', 'Highest peak in Fannichs. Excellent ridge walking with spectacular northwest Highland views.', 'sgurr_mor_fannichs.jpg'),

('Sgurr nan Clach Geala', 1093, 3586, 293, 'Munro', 'Highlands', 'Fannichs', 'NH184714', 57.6750, -4.9917, NULL, 'A fine peak in the Fannichs offering excellent ridge walking and spectacular views. Often climbed with Sgurr Mor.', 3, 8.0, '["Via Sgurr Mor", "Fannich Lodge approach", "Loch Fannich route"]', '["Spring", "Summer", "Autumn"]', 'Fine Fannichs peak. Often combined with Sgurr Mor for excellent ridge walking.', 'sgurr_nan_clach_geala.jpg')

ON CONFLICT (name) DO NOTHING;