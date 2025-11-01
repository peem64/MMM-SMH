/*
  # Fix All Duplicate Munro Image Filenames

  1. Problem
    - Multiple Munros share the same image_filename
    - This affects 35+ mountains across 14 different base names
    - Each mountain needs a unique image filename

  2. Solution
    - Update image_filename to include location/region identifier
    - Format: base_name_identifier.jpg

  3. Affected Mountains
    - Geal Chàrn (4 variants)
    - Càrn Dearg (3 variants)
    - Sgùrr Mòr (3 variants)
    - Ben Vorlich (2 variants)
    - And 10 other mountain names with 2 variants each
*/

-- Geal Chàrn variants (4 mountains)
UPDATE munros SET image_filename = 'geal_charn_laggan.jpg' 
WHERE name = 'Geal chàrn (Laggan)';

UPDATE munros SET image_filename = 'geal_charn_monadhliath.jpg' 
WHERE name = 'Geal Chàrn (Monadhliath)';

UPDATE munros SET image_filename = 'geal_charn_alder.jpg' 
WHERE name = 'Geal-chàrn (Alder)';

UPDATE munros SET image_filename = 'geal_charn_drumochter.jpg' 
WHERE name = 'Geal-chàrn (Drumochter)';

-- Càrn Dearg variants (3 mountains)
UPDATE munros SET image_filename = 'carn_dearg_corrour.jpg' 
WHERE name = 'Càrn Dearg (Corrour)';

UPDATE munros SET image_filename = 'carn_dearg_loch_pattack.jpg' 
WHERE name = 'Càrn Dearg (Loch Pattack)';

UPDATE munros SET image_filename = 'carn_dearg_monadhliath.jpg' 
WHERE name = 'Càrn Dearg (Monadhliath)';

-- Sgùrr Mòr variants (3 mountains)
UPDATE munros SET image_filename = 'sgurr_mor_fannichs.jpg' 
WHERE name = 'Sgùrr Mòr' AND region = 'Ullapool';

UPDATE munros SET image_filename = 'sgurr_mor_beinn_alligin.jpg' 
WHERE name = 'Sgùrr Mòr (Beinn Alligin)';

UPDATE munros SET image_filename = 'sgurr_mor_loch_cuaich.jpg' 
WHERE name = 'Sgùrr Mòr (Loch Cuaich)';

-- Beinn Dearg variants (2 mountains)
UPDATE munros SET image_filename = 'beinn_dearg_blair_atholl.jpg' 
WHERE name = 'Beinn Dearg (Blair Atholl)';

UPDATE munros SET image_filename = 'beinn_dearg_ullapool.jpg' 
WHERE name = 'Beinn Dearg (Ullapool)';

-- Beinn Fhionnlaidh variants (2 mountains)
UPDATE munros SET image_filename = 'beinn_fhionnlaidh_glen_etive.jpg' 
WHERE name = 'Beinn Fhionnlaidh' AND region = 'Argyll';

UPDATE munros SET image_filename = 'beinn_fhionnlaidh_carn_eige.jpg' 
WHERE name = 'Beinn Fhionnlaidh (Càrn Eige)';

-- Ben More variants (2 mountains)
UPDATE munros SET image_filename = 'ben_more_crianlarich.jpg' 
WHERE name = 'Ben More' AND region = 'Loch Lomond';

UPDATE munros SET image_filename = 'ben_more_mull.jpg' 
WHERE name = 'Ben More (Mull)';

-- Ben Vorlich variants (2 mountains) - already done but included for completeness
UPDATE munros SET image_filename = 'ben_vorlich_loch_earn.jpg' 
WHERE name = 'Ben Vorlich (Loch Earn)';

UPDATE munros SET image_filename = 'ben_vorlich_loch_lomond.jpg' 
WHERE name = 'Ben Vorlich (Loch Lomond)';

-- Càrn Liath variants (2 mountains)
UPDATE munros SET image_filename = 'carn_liath_beinn_a_ghlo.jpg' 
WHERE name = 'Càrn Liath (Beinn a'' Ghlò)';

UPDATE munros SET image_filename = 'carn_liath_creag_meagaidh.jpg' 
WHERE name = 'Càrn Liath (Creag Meagaidh)';

-- Càrn nan Gobhar variants (2 mountains)
UPDATE munros SET image_filename = 'carn_nan_gobhar_loch_mullardoch.jpg' 
WHERE name = 'Càrn nan Gobhar (Loch Mullardoch)';

UPDATE munros SET image_filename = 'carn_nan_gobhar_strathfarrar.jpg' 
WHERE name = 'Càrn nan Gobhar (Strathfarrar)';

-- Creag Mhòr variants (2 mountains)
UPDATE munros SET image_filename = 'creag_mhor_glen_lochay.jpg' 
WHERE name = 'Creag Mhòr (Glen Lochay)';

UPDATE munros SET image_filename = 'creag_mhor_meall_na_aighean.jpg' 
WHERE name = 'Creag Mhòr (Meall na Aighean)';

-- Meall Buidhe variants (2 mountains)
UPDATE munros SET image_filename = 'meall_buidhe_glen_lyon.jpg' 
WHERE name = 'Meall Buidhe (Glen Lyon)';

UPDATE munros SET image_filename = 'meall_buidhe_knoydart.jpg' 
WHERE name = 'Meall Buidhe (Knoydart)';

-- Meall Garbh variants (2 mountains)
UPDATE munros SET image_filename = 'meall_garbh_ben_lawers.jpg' 
WHERE name = 'Meall Garbh (Ben Lawers)';

UPDATE munros SET image_filename = 'meall_garbh_carn_mairg.jpg' 
WHERE name = 'Meall Garbh (Càrn Mairg)';

-- Ruadh Stac Mòr variants (2 mountains)
UPDATE munros SET image_filename = 'ruadh_stac_mor_fisherfield.jpg' 
WHERE name = 'Ruadh Stac Mòr' AND region = 'Ullapool';

UPDATE munros SET image_filename = 'ruadh_stac_mor_beinn_eighe.jpg' 
WHERE name = 'Ruadh-stac Mòr (Beinn Eighe)';

-- Sgùrr nan Coireachan variants (2 mountains)
UPDATE munros SET image_filename = 'sgurr_nan_coireachan_glen_dessary.jpg' 
WHERE name = 'Sgùrr nan Coireachan (Glen Dessary)';

UPDATE munros SET image_filename = 'sgurr_nan_coireachan_glenfinnan.jpg' 
WHERE name = 'Sgùrr nan Coireachan (Glenfinnan)';

-- Stob Bàn variants (2 mountains)
UPDATE munros SET image_filename = 'stob_ban_grey_corries.jpg' 
WHERE name = 'Stob Bàn (Grey Corries)';

UPDATE munros SET image_filename = 'stob_ban_mamores.jpg' 
WHERE name = 'Stob Bàn (Mamores)';

-- Verify no duplicates remain
SELECT 
  image_filename,
  COUNT(*) as count,
  STRING_AGG(name, ' | ' ORDER BY name) as mountain_names
FROM munros
GROUP BY image_filename
HAVING COUNT(*) > 1
ORDER BY count DESC;
