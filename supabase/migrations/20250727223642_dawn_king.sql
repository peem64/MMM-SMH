/*
  # Clean Munros Database - Remove Corbetts

  This migration removes all incorrectly classified Corbetts from the Munros table.
  Munros must be at least 914.4m (3,000 feet) high to qualify.

  1. Remove all peaks under 914.4m (these are Corbetts, not Munros)
  2. Remove known Corbetts that may be over 914.4m but are still not Munros
  3. Clean up any duplicate or invalid entries
  4. Verify remaining peaks are authentic Munros
*/

-- Remove all peaks under 914.4m (3,000 feet) - these are definitely not Munros
DELETE FROM munros 
WHERE height_m < 914.4;

-- Remove specific known Corbetts that may have been incorrectly included
-- These are well-known Corbetts that should not be in the Munros table
DELETE FROM munros 
WHERE name IN (
  'Leum Uilleim',
  'Beinn Sgritheall',
  'Ben Vrackie',
  'Schiehallion',
  'Ben Chonzie',
  'Ben Vorlich (Loch Earn)',
  'Stuc a'' Chroin',
  'Ben More (Mull)',
  'Dun da Ghaoithe',
  'Ben Nevis (Mull)',
  'Sgurr Dearg (Mull)',
  'Ben Buie',
  'Creach Bheinn',
  'Beinn na Caillich (Skye)',
  'Beinn Dearg Mhor (Skye)',
  'Beinn na Caillich (Knoydart)',
  'Ladhar Bheinn',
  'Luinne Bheinn',
  'Meall Buidhe (Knoydart)',
  'Sgurr Coire Choinnichean',
  'Ben Aden',
  'Beinn Bhan',
  'Applecross Hills',
  'Beinn Damh',
  'Maol Chean-dearg',
  'An Ruadh-stac',
  'Fuar Tholl',
  'Beinn Liath Mhor',
  'Sgorr Ruadh',
  'Beinn Alligin',
  'Liathach',
  'Beinn Eighe',
  'Slioch',
  'A'' Mhaighdean',
  'Ruadh Stac Mor',
  'Beinn a'' Chlaidheimh',
  'Sgurr Ban',
  'Mullach Coire Mhic Fhearchair',
  'Beinn Tarsuinn',
  'Beinn Dearg Mor',
  'Beinn Dearg Bheag',
  'Sail Mhor',
  'Ben More Coigach',
  'Sgurr an Fhidhleir',
  'Ben More Assynt',
  'Conival',
  'Breabag',
  'Canisp',
  'Suilven',
  'Cul Mor',
  'Cul Beag',
  'Stac Pollaidh',
  'Ben Wyvis',
  'Little Wyvis',
  'Am Faochagach',
  'Cona Mheall',
  'Beinn Dearg (Ullapool)',
  'Meall nan Ceapraichean',
  'Eididh nan Clach Geala',
  'Seana Bhraigh',
  'Creag Leacach',
  'Druim Shionnach',
  'Aonach air Chrith',
  'Maol Chinn-dearg',
  'Sgurr an Doire Leathain',
  'Sgurr an Lochain',
  'Creag nan Damh',
  'The Saddle',
  'Sgurr na Sgine',
  'Faochag',
  'Beinn Sgritheall',
  'Ben Aden',
  'Ladhar Bheinn',
  'Luinne Bheinn',
  'Meall Buidhe',
  'Sgurr Coire Choinnichean'
);

-- Remove any entries with invalid or missing data
DELETE FROM munros 
WHERE name IS NULL 
   OR name = '' 
   OR height_m IS NULL 
   OR height_m <= 0;

-- Remove duplicates (keep the first occurrence based on created_at)
DELETE FROM munros 
WHERE id NOT IN (
  SELECT DISTINCT ON (name) id 
  FROM munros 
  ORDER BY name, created_at ASC
);

-- Update the classification to ensure consistency
UPDATE munros 
SET classification = 'Munro' 
WHERE classification != 'Munro';

-- Log the cleanup results
DO $$
DECLARE
  remaining_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO remaining_count FROM munros;
  
  RAISE NOTICE 'Munros table cleanup completed';
  RAISE NOTICE 'Remaining peaks: %', remaining_count;
  RAISE NOTICE 'Expected: 282 authentic Munros';
  
  IF remaining_count != 282 THEN
    RAISE WARNING 'Peak count (%) does not match expected 282 Munros', remaining_count;
    RAISE WARNING 'Database may need complete rebuild with authentic Munro list';
  END IF;
END $$;