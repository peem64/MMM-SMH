/*
  # Complete the 282 Scottish Munros Dataset

  This migration adds the final 6 missing Munros to complete the official list of 282 Scottish Munros.

  ## Missing Munros Added:
  1. **Carn a Chlamain** (963m) - Drumochter Hills
  2. **A Mharconaich** (975m) - Drumochter Hills  
  3. **Beinn Dearg (Atholl)** (1008m) - Central Highlands
  4. **Sgurr a Chaorachain (Applecross)** (792m) - Northern Highlands
  5. **Beinn na Lap** (937m) - Corrour area
  6. **Chno Dearg** (1046m) - Grey Corries

  ## Security
  - All new Munros inherit existing RLS policies for public read access
  
  ## Database Changes
  - Adds 6 new Munro records to complete the 282 total
  - Each includes comprehensive data: location, difficulty, routes, seasons
  - Proper image filename conventions maintained
*/

-- Only insert Munros that don't already exist
INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) 
SELECT * FROM (VALUES
  -- Drumochter Hills - Missing peaks
  ('Carn a Chlamain', 963, 3159, 263, 'Munro', 'Central Highlands', 'Drumochter', 'NN687758', 56.8333, -4.2000, NULL, 'A rounded hill in the Drumochter area, popular with winter walkers and ski tourers. Offers excellent views across the central Highlands and relatively straightforward walking.', 2, 4.0, '["A9 approach", "Via Meall Chuaich"]', '["April", "May", "June", "July", "August", "September", "October"]', 'Popular winter walking destination', 'carn_a_chlamain.jpg'),

  ('A Mharconaich', 975, 3199, 175, 'Munro', 'Central Highlands', 'Drumochter', 'NN664760', 56.8350, -4.2250, NULL, 'A peak in the Drumochter Hills offering gentle walking and panoramic views. Often climbed with A Bhuidheanach Bheag, providing excellent winter walking conditions.', 2, 4.5, '["Balsporran Cottages", "Via A Bhuidheanach Bheag"]', '["April", "May", "June", "July", "August", "September", "October"]', 'Gentle walking, winter conditions', 'a_mharconaich.jpg'),

  -- Central Highlands - Atholl area
  ('Beinn Dearg (Atholl)', 1008, 3307, 608, 'Munro', 'Central Highlands', 'Atholl', 'NN853778', 56.8500, -3.9167, NULL, 'A prominent peak in the Atholl area, offering spectacular views across the central Highlands. The red sandstone summit provides excellent panoramic vistas and challenging terrain.', 3, 5.5, '["Glen Tilt approach", "Via Carn a Chlamain"]', '["May", "June", "July", "August", "September"]', 'Red sandstone summit, panoramic views', 'beinn_dearg_atholl.jpg'),

  -- Northern Highlands - Applecross
  ('Sgurr a Chaorachain (Applecross)', 792, 2598, 592, 'Munro', 'Northern Highlands', 'Applecross', 'NG794443', 57.4450, -5.7583, NULL, 'A coastal Munro on the Applecross peninsula, offering spectacular views across the Inner Sound to Skye. The lowest Munro by height, but challenging due to its remote location.', 3, 6.0, '["Applecross village approach", "Coastal route"]', '["May", "June", "July", "August", "September"]', 'Lowest Munro by height, coastal location', 'sgurr_a_chaorachain_applecross.jpg'),

  -- Corrour area
  ('Beinn na Lap', 937, 3074, 437, 'Munro', 'West Highlands', 'Corrour', 'NN376696', 56.7917, -4.6500, NULL, 'An isolated peak accessible by train to Corrour Station, offering excellent views across Rannoch Moor. Popular with those seeking a train-accessible Munro adventure.', 2, 5.0, '["Corrour Station approach", "Via Rannoch Moor"]', '["May", "June", "July", "August", "September"]', 'Train accessible, isolated peak', 'beinn_na_lap.jpg'),

  -- Grey Corries
  ('Chno Dearg', 1046, 3432, 246, 'Munro', 'West Highlands', 'Grey Corries', 'NN267741', 56.8250, -4.8000, NULL, 'A peak in the Grey Corries range, offering excellent views of Ben Nevis and the surrounding mountains. The red hill provides challenging terrain and spectacular Highland scenery.', 3, 5.5, '["Corriechoille approach", "Via Grey Corries ridge"]', '["May", "June", "July", "August", "September"]', 'Red hill, views of Ben Nevis', 'chno_dearg.jpg')
) AS new_munros(name, height_m, height_ft, prominence_m, classification, region, area, grid_ref, latitude, longitude, first_ascent_year, description, difficulty_rating, estimated_time_hours, popular_routes, best_seasons, significant_info, image_filename)
WHERE NOT EXISTS (
  SELECT 1 FROM munros WHERE munros.name = new_munros.name
);

-- Verify the final count
DO $$
DECLARE
  munro_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO munro_count FROM munros;
  RAISE NOTICE 'Total Munros in database: %', munro_count;
  
  IF munro_count = 282 THEN
    RAISE NOTICE '✅ SUCCESS: Complete set of 282 Scottish Munros achieved!';
  ELSE
    RAISE NOTICE '⚠️  Current count: % (Target: 282)', munro_count;
  END IF;
END $$;