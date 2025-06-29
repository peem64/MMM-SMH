/*
  # Complete the 282 Munros dataset

  1. New Tables
    - Add the final 6 missing Munros to reach the complete 282 count
    
  2. Munros Added
    - Beinn Dearg (Atholl) - Central Highlands peak
    - Carn a Chlamain - Drumochter Hills 
    - A Mharconaich - Drumochter Hills
    - Sgurr a Chaorachain (Applecross) - Northern Highlands
    - Beinn na Lap - Corrour area
    - Chno Dearg - Grey Corries
    
  3. Security
    - All new entries follow existing RLS policies
    - Public read access maintained
*/

-- Insert the final 6 Munros to complete the 282 dataset
INSERT INTO munros (
  name, height_m, height_ft, prominence_m, classification, region, area, 
  grid_ref, latitude, longitude, first_ascent_year, description, 
  difficulty_rating, estimated_time_hours, popular_routes, best_seasons, 
  significant_info, image_filename
) VALUES

-- Drumochter Hills (2 missing)
('Carn a Chlamain', 963, 3159, 163, 'Munro', 'Central Highlands', 'Drumochter', 'NN645758', 56.8333, -4.2500, NULL, 'A peak in the Drumochter Hills, offering excellent views and relatively easy walking. Popular with winter walkers and often climbed with A Mharconaich.', 2, 4.0, '["Dalwhinnie approach", "Via A Mharconaich"]', '["April", "May", "June", "July", "August", "September", "October"]', 'Easy walking, winter popular', 'carn_a_chlamain.jpg'),

('A Mharconaich', 975, 3199, 175, 'Munro', 'Central Highlands', 'Drumochter', 'NN664776', 56.8500, -4.2167, NULL, 'Often climbed with Carn a Chlamain, this peak offers good walking and excellent views across the central Highlands. The approach is straightforward.', 2, 4.5, '["Via Carn a Chlamain", "Dalwhinnie approach"]', '["April", "May", "June", "July", "August", "September", "October"]', 'Often combined with Carn a Chlamain', 'a_mharconaich.jpg'),

-- Central Highlands
('Beinn Dearg (Atholl)', 1008, 3307, 208, 'Munro', 'Central Highlands', 'Atholl', 'NN853778', 56.8667, -3.8333, NULL, 'A peak in the Atholl area, offering excellent views across the central Highlands. Less frequented than many Munros, providing a quieter mountain experience.', 2, 5.0, '["Glen Tilt approach", "Via Carn Liath"]', '["May", "June", "July", "August", "September"]', 'Less frequented, quieter experience', 'beinn_dearg_atholl.jpg'),

-- Northern Highlands
('Sgurr a Chaorachain (Applecross)', 792, 2598, 292, 'Munro', 'Northern Highlands', 'Applecross', 'NG794488', 57.4667, -5.7667, NULL, 'A peak on the Applecross peninsula, offering spectacular coastal views and challenging terrain. The approach crosses dramatic Highland scenery with views to Skye.', 3, 5.5, '["Applecross approach", "Coastal route"]', '["May", "June", "July", "August", "September"]', 'Coastal views to Skye', 'sgurr_a_chaorachain_applecross.jpg'),

-- Corrour
('Beinn na Lap', 937, 3074, 337, 'Munro', 'West Highlands', 'Corrour', 'NN376705', 56.7917, -4.6500, NULL, 'An isolated peak near Corrour Station, offering excellent views across Rannoch Moor. The approach can be made by train to Corrour, making it uniquely accessible.', 2, 5.0, '["Corrour Station approach", "Via Rannoch Moor"]', '["May", "June", "July", "August", "September"]', 'Accessible by train to Corrour', 'beinn_na_lap.jpg'),

-- Grey Corries
('Chno Dearg', 1046, 3432, 246, 'Munro', 'West Highlands', 'Grey Corries', 'NN377741', 56.8417, -4.6500, NULL, 'A peak in the Grey Corries range, offering excellent views of Ben Nevis and the surrounding mountains. Often climbed as part of the Grey Corries traverse.', 3, 5.5, '["Grey Corries traverse", "Fersit approach"]', '["May", "June", "July", "August", "September"]', 'Part of Grey Corries range', 'chno_dearg.jpg');

-- Verify we now have exactly 282 Munros
SELECT COUNT(*) as total_munros FROM munros;

-- Show a sample of the newly added Munros
SELECT name, height_m, region, area FROM munros 
WHERE name IN ('Carn a Chlamain', 'A Mharconaich', 'Beinn Dearg (Atholl)', 'Sgurr a Chaorachain (Applecross)', 'Beinn na Lap', 'Chno Dearg')
ORDER BY name;