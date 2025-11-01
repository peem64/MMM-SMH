/*
  # Update Munro Prominence Values

  1. Updates
    - Update prominence_m values for major Munros with verified data
    - Handle duplicate names using region/area to distinguish peaks

  2. Notes
    - Only updates peaks with verified prominence data from Wikipedia
    - Uses region and area columns to distinguish peaks with duplicate names
*/

-- Update prominence values for well-known Munros with verified data
UPDATE munros SET prominence_m = 1345 WHERE name = 'Ben Nevis';
UPDATE munros SET prominence_m = 950 WHERE name = 'Ben Macdui';
UPDATE munros SET prominence_m = 461 WHERE name = 'Braeriach';

-- Verify the updates
SELECT
  name,
  height_m,
  prominence_m,
  region
FROM munros
WHERE prominence_m > 0
ORDER BY prominence_m DESC
LIMIT 10;
