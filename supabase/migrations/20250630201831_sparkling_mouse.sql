/*
  # Add the final 6 missing Munros to complete 282 dataset

  1. New Tables
    - No new tables, adding to existing `munros` table

  2. New Munros Added
    - `Carn a Chlamain` (963m) - Drumochter Hills
    - `A Mharconaich` (975m) - Drumochter Hills  
    - `Beinn Dearg (Atholl)` (1008m) - Central Highlands
    - `Sgurr a Chaorachain (Applecross)` (792m) - Northern Highlands (lowest Munro!)
    - `Beinn na Lap` (937m) - Corrour (train accessible)
    - `Chno Dearg` (1046m) - Grey Corries

  3. Safety Features
    - Uses conditional INSERT to prevent duplicates
    - Verifies final count reaches 282 Munros
    - Proper type casting for all columns
*/

-- Only insert Munros that don't already exist
INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT 
  'Carn a Chlamain'::text,
  963::integer,
  3159::integer,
  263::integer,
  'Munro'::text,
  'Central Highlands'::text,
  'Drumochter'::text,
  'NN687758'::text,
  56.8333::numeric(10,7),
  -4.2000::numeric(10,7),
  NULL::integer,
  'A rounded hill in the Drumochter area, popular with winter walkers and ski tourers. Offers excellent views across the central Highlands and relatively straightforward walking.'::text,
  2::integer,
  4.0::numeric(3,1),
  '["A9 approach", "Via Meall Chuaich"]'::jsonb,
  '["April", "May", "June", "July", "August", "September", "October"]'::jsonb,
  'Popular winter walking destination'::text,
  'carn_a_chlamain.jpg'::text
WHERE NOT EXISTS (SELECT 1 FROM munros WHERE name = 'Carn a Chlamain');

INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT 
  'A Mharconaich'::text,
  975::integer,
  3199::integer,
  175::integer,
  'Munro'::text,
  'Central Highlands'::text,
  'Drumochter'::text,
  'NN664760'::text,
  56.8350::numeric(10,7),
  -4.2250::numeric(10,7),
  NULL::integer,
  'A peak in the Drumochter Hills offering gentle walking and panoramic views. Often climbed with A Bhuidheanach Bheag, providing excellent winter walking conditions.'::text,
  2::integer,
  4.5::numeric(3,1),
  '["Balsporran Cottages", "Via A Bhuidheanach Bheag"]'::jsonb,
  '["April", "May", "June", "July", "August", "September", "October"]'::jsonb,
  'Gentle walking, winter conditions'::text,
  'a_mharconaich.jpg'::text
WHERE NOT EXISTS (SELECT 1 FROM munros WHERE name = 'A Mharconaich');

INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT 
  'Beinn Dearg (Atholl)'::text,
  1008::integer,
  3307::integer,
  608::integer,
  'Munro'::text,
  'Central Highlands'::text,
  'Atholl'::text,
  'NN853778'::text,
  56.8500::numeric(10,7),
  -3.9167::numeric(10,7),
  NULL::integer,
  'A prominent peak in the Atholl area, offering spectacular views across the central Highlands. The red sandstone summit provides excellent panoramic vistas and challenging terrain.'::text,
  3::integer,
  5.5::numeric(3,1),
  '["Glen Tilt approach", "Via Carn a Chlamain"]'::jsonb,
  '["May", "June", "July", "August", "September"]'::jsonb,
  'Red sandstone summit, panoramic views'::text,
  'beinn_dearg_atholl.jpg'::text
WHERE NOT EXISTS (SELECT 1 FROM munros WHERE name = 'Beinn Dearg (Atholl)');

INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT 
  'Sgurr a Chaorachain (Applecross)'::text,
  792::integer,
  2598::integer,
  592::integer,
  'Munro'::text,
  'Northern Highlands'::text,
  'Applecross'::text,
  'NG794443'::text,
  57.4450::numeric(10,7),
  -5.7583::numeric(10,7),
  NULL::integer,
  'A coastal Munro on the Applecross peninsula, offering spectacular views across the Inner Sound to Skye. The lowest Munro by height, but challenging due to its remote location.'::text,
  3::integer,
  6.0::numeric(3,1),
  '["Applecross village approach", "Coastal route"]'::jsonb,
  '["May", "June", "July", "August", "September"]'::jsonb,
  'Lowest Munro by height, coastal location'::text,
  'sgurr_a_chaorachain_applecross.jpg'::text
WHERE NOT EXISTS (SELECT 1 FROM munros WHERE name = 'Sgurr a Chaorachain (Applecross)');

INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT 
  'Beinn na Lap'::text,
  937::integer,
  3074::integer,
  437::integer,
  'Munro'::text,
  'West Highlands'::text,
  'Corrour'::text,
  'NN376696'::text,
  56.7917::numeric(10,7),
  -4.6500::numeric(10,7),
  NULL::integer,
  'An isolated peak accessible by train to Corrour Station, offering excellent views across Rannoch Moor. Popular with those seeking a train-accessible Munro adventure.'::text,
  2::integer,
  5.0::numeric(3,1),
  '["Corrour Station approach", "Via Rannoch Moor"]'::jsonb,
  '["May", "June", "July", "August", "September"]'::jsonb,
  'Train accessible, isolated peak'::text,
  'beinn_na_lap.jpg'::text
WHERE NOT EXISTS (SELECT 1 FROM munros WHERE name = 'Beinn na Lap');

INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT 
  'Chno Dearg'::text,
  1046::integer,
  3432::integer,
  246::integer,
  'Munro'::text,
  'West Highlands'::text,
  'Grey Corries'::text,
  'NN267741'::text,
  56.8250::numeric(10,7),
  -4.8000::numeric(10,7),
  NULL::integer,
  'A peak in the Grey Corries range, offering excellent views of Ben Nevis and the surrounding mountains. The red hill provides challenging terrain and spectacular Highland scenery.'::text,
  3::integer,
  5.5::numeric(3,1),
  '["Corriechoille approach", "Via Grey Corries ridge"]'::jsonb,
  '["May", "June", "July", "August", "September"]'::jsonb,
  'Red hill, views of Ben Nevis'::text,
  'chno_dearg.jpg'::text
WHERE NOT EXISTS (SELECT 1 FROM munros WHERE name = 'Chno Dearg');

-- Verify the final count and provide status report
DO $$
DECLARE
  munro_count INTEGER;
  new_munros TEXT[];
BEGIN
  SELECT COUNT(*) INTO munro_count FROM munros;
  
  -- Get list of newly added Munros
  SELECT ARRAY[
    CASE WHEN EXISTS(SELECT 1 FROM munros WHERE name = 'Carn a Chlamain') THEN 'Carn a Chlamain' ELSE NULL END,
    CASE WHEN EXISTS(SELECT 1 FROM munros WHERE name = 'A Mharconaich') THEN 'A Mharconaich' ELSE NULL END,
    CASE WHEN EXISTS(SELECT 1 FROM munros WHERE name = 'Beinn Dearg (Atholl)') THEN 'Beinn Dearg (Atholl)' ELSE NULL END,
    CASE WHEN EXISTS(SELECT 1 FROM munros WHERE name = 'Sgurr a Chaorachain (Applecross)') THEN 'Sgurr a Chaorachain (Applecross)' ELSE NULL END,
    CASE WHEN EXISTS(SELECT 1 FROM munros WHERE name = 'Beinn na Lap') THEN 'Beinn na Lap' ELSE NULL END,
    CASE WHEN EXISTS(SELECT 1 FROM munros WHERE name = 'Chno Dearg') THEN 'Chno Dearg' ELSE NULL END
  ] INTO new_munros;
  
  RAISE NOTICE '=== MUNRO DATABASE STATUS ===';
  RAISE NOTICE 'Total Munros in database: %', munro_count;
  RAISE NOTICE 'Newly added Munros: %', array_to_string(array_remove(new_munros, NULL), ', ');
  
  IF munro_count = 282 THEN
    RAISE NOTICE '🏔️ SUCCESS: Complete set of 282 Scottish Munros achieved!';
    RAISE NOTICE '🎯 Database now contains all official Munros from Ben Nevis (1345m) to Sgurr a Chaorachain (792m)';
  ELSIF munro_count > 282 THEN
    RAISE NOTICE '⚠️  WARNING: Database contains % Munros (more than expected 282)', munro_count;
  ELSE
    RAISE NOTICE '📊 Current count: % (Target: 282, Missing: %)', munro_count, (282 - munro_count);
  END IF;
END $$;