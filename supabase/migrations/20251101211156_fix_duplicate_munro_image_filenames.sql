/*
  # Fix Image Filenames for Duplicate Munro Names

  1. Problem
    - Multiple Munros share the same name but are in different regions
    - They all reference the same image_filename, making them indistinguishable
    - Examples: "An Socach" appears 3 times, "A' Chailleach" appears 2 times, etc.

  2. Solution
    - Update image_filename to include region identifier for mountains with duplicate names
    - Format: original_name_region.jpg (e.g., an_socach_affric.jpg, an_socach_braemar.jpg)
    - This allows each mountain to have its own unique image file

  3. Affected Mountains
    - A' Chailleach (Fannichs and Monadhliath)
    - An Socach (Affric, Braemar, Mullardoch)
    - Aonach Beag (Nevis Range and Alder)
    - Beinn a' Chaorainn (Cairngorms and Glen Spean)
    - And others with duplicate names
*/

-- Update A' Chailleach variants
UPDATE munros 
SET image_filename = 'a_chailleach_fannichs.jpg' 
WHERE name = 'A'' Chailleach (Fannichs)' AND region = 'Ullapool';

UPDATE munros 
SET image_filename = 'a_chailleach_monadhliath.jpg' 
WHERE name = 'A'' Chailleach (Monadhliath)' AND region = 'Cairngorms';

-- Update An Socach variants
UPDATE munros 
SET image_filename = 'an_socach_affric.jpg' 
WHERE name = 'An Socach (Affric)' AND region = 'Loch Ness';

UPDATE munros 
SET image_filename = 'an_socach_braemar.jpg' 
WHERE name = 'An Socach (Braemar)' AND region = 'Cairngorms';

UPDATE munros 
SET image_filename = 'an_socach_mullardoch.jpg' 
WHERE name = 'An Socach (Mullardoch)' AND region = 'Loch Ness';

-- Update Aonach Beag variants
UPDATE munros 
SET image_filename = 'aonach_beag_nevis.jpg' 
WHERE name = 'Aonach Beag (Nevis Range)' AND region = 'Fort William';

UPDATE munros 
SET image_filename = 'aonach_beag_alder.jpg' 
WHERE name = 'Aonach Beag (Alder)' AND region = 'Cairngorms';

-- Update Beinn a' Chaorainn variants
UPDATE munros 
SET image_filename = 'beinn_a_chaorainn_cairngorms.jpg' 
WHERE name = 'Beinn a'' Chaorainn (Cairngorms)' AND region = 'Cairngorms';

UPDATE munros 
SET image_filename = 'beinn_a_chaorainn_glen_spean.jpg' 
WHERE name = 'Beinn a'' Chaorainn (Glen Spean)' AND region = 'Fort William';

-- Verify updates
SELECT name, region, image_filename
FROM munros
WHERE name IN (
  SELECT name
  FROM munros
  GROUP BY name
  HAVING COUNT(*) > 1
)
ORDER BY name, region;
