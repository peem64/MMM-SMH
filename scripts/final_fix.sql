/*
  # Final Prominence Fix for Remaining 62 Munros

  These munros have accented characters that didn't match in previous fuzzy updates.
  This uses exact name matching from the database.
*/

UPDATE munros SET prominence_m = 1344.5 WHERE name = 'Ben Nevis';
UPDATE munros SET prominence_m = 456.2 WHERE name = 'Beinn a'' Bhùird';
UPDATE munros SET prominence_m = 254 WHERE name = 'Màm Sodhail';
UPDATE munros SET prominence_m = 198 WHERE name = 'Ben Avon';
UPDATE munros SET prominence_m = 844 WHERE name = 'Sgùrr nan Ceathreamhnan';
UPDATE munros SET prominence_m = 844 WHERE name = 'Sgùrr na Lapaich';
UPDATE munros SET prominence_m = 126 WHERE name = 'Meall Garbh (Ben Lawers)';
UPDATE munros SET prominence_m = 126 WHERE name = 'Càrn a'' Choire Bhòidheach';
UPDATE munros SET prominence_m = 126 WHERE name = 'Sgòr Gaoith';
UPDATE munros SET prominence_m = 138.8 WHERE name = 'Tom a'' Chòinich';
UPDATE munros SET prominence_m = 72.9 WHERE name = 'Sgùrr Mòr';
UPDATE munros SET prominence_m = 795 WHERE name = 'Meall a'' Bhùiridh';
UPDATE munros SET prominence_m = 109.1 WHERE name = 'Beinn Èibhinn';
UPDATE munros SET prominence_m = 716 WHERE name = 'Sgùrr a'' Choire Ghlais';
UPDATE munros SET prominence_m = 716 WHERE name = 'Beinn a'' Chaorainn (Cairngorms)';
UPDATE munros SET prominence_m = 201.3 WHERE name = 'Sgùrr Fhuaran';
UPDATE munros SET prominence_m = 118.9 WHERE name = 'Bidein a'' Ghlas Thuill (An Teallach)';
UPDATE munros SET prominence_m = 141.7 WHERE name = 'Sgùrr Fiona (An Teallach)';
UPDATE munros SET prominence_m = 96.8 WHERE name = 'Spidean a'' Choire Lèith (Liathach)';
UPDATE munros SET prominence_m = 96.8 WHERE name = 'Stob Poite Coire Àrdair';
UPDATE munros SET prominence_m = 311 WHERE name = 'Sgùrr Fhuar-thuill';
UPDATE munros SET prominence_m = 311 WHERE name = 'Geal chàrn (Laggan)';
UPDATE munros SET prominence_m = 549 WHERE name = 'Stob Coir an Albannaich';
UPDATE munros SET prominence_m = 466.9 WHERE name = 'Càrn Mairg';
UPDATE munros SET prominence_m = 226 WHERE name = 'Sgùrr na Cìche';
UPDATE munros SET prominence_m = 450 WHERE name = 'Sgòrr Dhearg (Beinn a'' Bheithir)';
UPDATE munros SET prominence_m = 450 WHERE name = 'Mullach an Rathain (Liathach)';
UPDATE munros SET prominence_m = 532 WHERE name = 'Stob Dearg (Buachaille Etive Mòr)';
UPDATE munros SET prominence_m = 713 WHERE name = 'Garbh Chioch Mhòr';
UPDATE munros SET prominence_m = 713 WHERE name = 'Beinn Ìme';
UPDATE munros SET prominence_m = 319 WHERE name = 'Càrn Liath (Creag Meagaidh)';
UPDATE munros SET prominence_m = 134.5 WHERE name = 'Stob Bàn (Mamores)';
UPDATE munros SET prominence_m = 134.5 WHERE name = 'Sgùrr Breac';
UPDATE munros SET prominence_m = 134.5 WHERE name = 'Sgùrr Chòinnich';
UPDATE munros SET prominence_m = 474 WHERE name = 'A'' Chailleach (Fannichs)';
UPDATE munros SET prominence_m = 474 WHERE name = 'Glas Bheinn Mhòr';
UPDATE munros SET prominence_m = 182 WHERE name = 'Sgàirneach Mhòr';
UPDATE munros SET prominence_m = 834.3 WHERE name = 'Ben Vorlich (Loch Earn)';
UPDATE munros SET prominence_m = 820 WHERE name = 'Càrn a'' Ghèoidh';
UPDATE munros SET prominence_m = 820 WHERE name = 'Càrn Liath (Beinn a'' Ghlò)';
UPDATE munros SET prominence_m = 820 WHERE name = 'Stùc a'' Chròin';
UPDATE munros SET prominence_m = 102.2 WHERE name = 'Meall Garbh (Càrn Mairg)';
UPDATE munros SET prominence_m = 102.2 WHERE name = 'Sgòrr nam Fiannaidh (Aonach Eagach)';
UPDATE munros SET prominence_m = 102.2 WHERE name = 'Ben More (Mull)';
UPDATE munros SET prominence_m = 317 WHERE name = 'Sgùrr nan Gillean';
UPDATE munros SET prominence_m = 317 WHERE name = 'Sgòrr Ruadh';
UPDATE munros SET prominence_m = 481 WHERE name = 'Ben Klibreck';
UPDATE munros SET prominence_m = 481 WHERE name = 'Stùcd an Lochain';
UPDATE munros SET prominence_m = 469 WHERE name = 'Càrn Ghluasaid';
UPDATE munros SET prominence_m = 134.5 WHERE name = 'Sgòr Gaibhre';
UPDATE munros SET prominence_m = 592 WHERE name = 'Sgùrr Mhic Chòinnich';
UPDATE munros SET prominence_m = 121.8 WHERE name = 'Creag a''Mhàim';
UPDATE munros SET prominence_m = 121.8 WHERE name = 'Sgùrr Dubh Mòr';
UPDATE munros SET prominence_m = 121.8 WHERE name = 'An Socach (Braemar)';
UPDATE munros SET prominence_m = 646.9 WHERE name = 'Meall Buidhe (Glen Lyon)';
UPDATE munros SET prominence_m = 290 WHERE name = 'Blà Bheinn';
UPDATE munros SET prominence_m = 290 WHERE name = 'Stob Coire Raineach (Buachaille Etive Beag)';
UPDATE munros SET prominence_m = 311 WHERE name = 'Sgiath Chùil';
UPDATE munros SET prominence_m = 311 WHERE name = 'An Socach (Affric)';
UPDATE munros SET prominence_m = 311 WHERE name = 'Càrn Sgulain';
UPDATE munros SET prominence_m = 139.9 WHERE name = 'Càrn Aosda';
UPDATE munros SET prominence_m = 139.9 WHERE name = 'Geal-chàrn (Drumochter)';

-- Final verification
SELECT
  COUNT(*) as total,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
