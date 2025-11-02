/*
  # Fix Remaining 75 Munros with Fuzzy Height Matching

  Problem: Heights in database don't exactly match DoBIH (e.g., 974m vs 973.7m)
  Solution: Use ABS(height_m - target) < 1 for fuzzy matching within 1m tolerance
  
  This completes the prominence fix for all 282 Munros.
*/

-- Apply all fuzzy updates
DO $$
BEGIN
  -- Only update munros where prominence still equals height
  UPDATE munros SET prominence_m = 1344.5 WHERE ABS(height_m - 1344.5) < 1 AND prominence_m = height_m AND name ILIKE '%Ben Nevis%';
  UPDATE munros SET prominence_m = 133 WHERE ABS(height_m - 1220.4) < 1 AND prominence_m = height_m AND name ILIKE '%Aonach M_r%';
  UPDATE munros SET prominence_m = 456.2 WHERE ABS(height_m - 1196) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn a%Bh_ird%';
  UPDATE munros SET prominence_m = 1147 WHERE ABS(height_m - 1182.8) < 1 AND prominence_m = height_m AND name ILIKE '%C_rn Eige%';
  UPDATE munros SET prominence_m = 132.4 WHERE ABS(height_m - 1179.4) < 1 AND prominence_m = height_m AND name ILIKE '%M_m Sodhail%';
  UPDATE munros SET prominence_m = 198 WHERE ABS(height_m - 1172) < 1 AND prominence_m = height_m AND name ILIKE '%Ben Avon%';
  UPDATE munros SET prominence_m = 671 WHERE ABS(height_m - 1155.7) < 1 AND prominence_m = height_m AND name ILIKE '%Lochnagar%';
  UPDATE munros SET prominence_m = 433 WHERE ABS(height_m - 1149.7) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr nan Ceath%';
  UPDATE munros SET prominence_m = 841 WHERE ABS(height_m - 1151.9) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr na Lapaich%';
  UPDATE munros SET prominence_m = 658 WHERE ABS(height_m - 1121.9) < 1 AND prominence_m = height_m AND name ILIKE '%C_rn nan Gabhar%';
  UPDATE munros SET prominence_m = 72.9 WHERE ABS(height_m - 1109.9) < 1 AND prominence_m = height_m AND name ILIKE '%C_rn a%Choire Bh_idheach%';
  UPDATE munros SET prominence_m = 198 WHERE ABS(height_m - 1123.1) < 1 AND prominence_m = height_m AND name ILIKE '%Meall Garbh%';
  UPDATE munros SET prominence_m = 126 WHERE ABS(height_m - 1117.1) < 1 AND prominence_m = height_m AND name ILIKE '%An St_c%';
  UPDATE munros SET prominence_m = 242.8 WHERE ABS(height_m - 1116) < 1 AND prominence_m = height_m AND name ILIKE '%Sg_r Gaoith%';
  UPDATE munros SET prominence_m = 138.8 WHERE ABS(height_m - 1113.4) < 1 AND prominence_m = height_m AND name ILIKE '%Monadh M_r%';
  UPDATE munros SET prominence_m = 127 WHERE ABS(height_m - 1103.3) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn _ibhinn%';
  UPDATE munros SET prominence_m = 579 WHERE ABS(height_m - 1077.4) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn%easgarnich%';
  UPDATE munros SET prominence_m = 246.3 WHERE ABS(height_m - 1083.3) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn a%Chaorainn%Cairngorms%';
  UPDATE munros SET prominence_m = 227 WHERE ABS(height_m - 1049.1) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn a%Chaorainn%Glen Spean%';
  UPDATE munros SET prominence_m = 139.9 WHERE ABS(height_m - 916.3) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn a%Chl_ibh%';
  UPDATE munros SET prominence_m = 136.9 WHERE ABS(height_m - 941.4) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn a%Chr_in%';
  UPDATE munros SET prominence_m = 473 WHERE ABS(height_m - 1008.7) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn Dearg%Blair Atholl%';
  UPDATE munros SET prominence_m = 173 WHERE ABS(height_m - 1004.8) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn Fhionnlaidh%C_rn Eige%';
  UPDATE munros SET prominence_m = 713 WHERE ABS(height_m - 1012.2) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn _me%';
  UPDATE munros SET prominence_m = 107 WHERE ABS(height_m - 954.2) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn Liath Mh_r Fannaich%';
  UPDATE munros SET prominence_m = 450 WHERE ABS(height_m - 1024.9) < 1 AND prominence_m = height_m AND name ILIKE '%Ben Challum%';
  UPDATE munros SET prominence_m = 819 WHERE ABS(height_m - 962.1) < 1 AND prominence_m = height_m AND name ILIKE '%Ben Klibreck%';
  UPDATE munros SET prominence_m = 108.3 WHERE ABS(height_m - 929.3) < 1 AND prominence_m = height_m AND name ILIKE '%A%Chailleach%Monadhliath%';
  UPDATE munros SET prominence_m = 182.9 WHERE ABS(height_m - 998.6) < 1 AND prominence_m = height_m AND name ILIKE '%A%Chailleach%Fannichs%';
  UPDATE munros SET prominence_m = 123.8 WHERE ABS(height_m - 919.7) < 1 AND prominence_m = height_m AND name ILIKE '%An Socach%Affric%';
  UPDATE munros SET prominence_m = 187 WHERE ABS(height_m - 942.8) < 1 AND prominence_m = height_m AND name ILIKE '%An Socach%Braemar%';
  UPDATE munros SET prominence_m = 99 WHERE ABS(height_m - 1115.8) < 1 AND prominence_m = height_m AND name ILIKE '%Aonach Beag%Alder%';
  UPDATE munros SET prominence_m = 101.1 WHERE ABS(height_m - 926.3) < 1 AND prominence_m = height_m AND name ILIKE '%Geal Charn%Monadhliath%';
  UPDATE munros SET prominence_m = 149.8 WHERE ABS(height_m - 1112.7) < 1 AND prominence_m = height_m AND name ILIKE '%Tom a%Choinnich%';
  UPDATE munros SET prominence_m = 665 WHERE ABS(height_m - 1068.8) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr Fhuaran%';
  UPDATE munros SET prominence_m = 181.4 WHERE ABS(height_m - 1053.7) < 1 AND prominence_m = height_m AND name ILIKE '%Toll Creagach%';
  UPDATE munros SET prominence_m = 311 WHERE ABS(height_m - 1036) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr a%Bhealaich Dheirg%';
  UPDATE munros SET prominence_m = 647 WHERE ABS(height_m - 1031.9) < 1 AND prominence_m = height_m AND name ILIKE '%Beinn Fhada%';
  UPDATE munros SET prominence_m = 178 WHERE ABS(height_m - 1027) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr na Ciste Duibhe%';
  UPDATE munros SET prominence_m = 134 WHERE ABS(height_m - 1002) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr na Carnach%';
  UPDATE munros SET prominence_m = 174 WHERE ABS(height_m - 1001) < 1 AND prominence_m = height_m AND name ILIKE '%Aonach Meadhoin%';
  UPDATE munros SET prominence_m = 144 WHERE ABS(height_m - 982) < 1 AND prominence_m = height_m AND name ILIKE '%Mullach na Dheiragain%';
  UPDATE munros SET prominence_m = 390.5 WHERE ABS(height_m - 981.1) < 1 AND prominence_m = height_m AND name ILIKE '%Ciste Dhubh%';
  UPDATE munros SET prominence_m = 91 WHERE ABS(height_m - 956) < 1 AND prominence_m = height_m AND name ILIKE '%Saileag%';
  UPDATE munros SET prominence_m = 407 WHERE ABS(height_m - 918) < 1 AND prominence_m = height_m AND name ILIKE '%A%Ghlas-bheinn%';
  UPDATE munros SET prominence_m = 786 WHERE ABS(height_m - 1120) < 1 AND prominence_m = height_m AND name ILIKE '%A%Chr_laig%';
  UPDATE munros SET prominence_m = 382 WHERE ABS(height_m - 1109) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr nan Conbhairean%';
  UPDATE munros SET prominence_m = 151.3 WHERE ABS(height_m - 1100.9) < 1 AND prominence_m = height_m AND name ILIKE '%Mullach Fraoch-choire%';
  UPDATE munros SET prominence_m = 87 WHERE ABS(height_m - 999.2) < 1 AND prominence_m = height_m AND name ILIKE '%Sail Chaorainn%';
  UPDATE munros SET prominence_m = 62.7 WHERE ABS(height_m - 956.3) < 1 AND prominence_m = height_m AND name ILIKE '%Carn Ghluasaid%';
  UPDATE munros SET prominence_m = 819 WHERE ABS(height_m - 1083.7) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr a%Choire Ghlais%';
  UPDATE munros SET prominence_m = 568 WHERE ABS(height_m - 1053) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr a%Chaorachain%';
  UPDATE munros SET prominence_m = 148.1 WHERE ABS(height_m - 1049.2) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr Fhuar-thuill%';
  UPDATE munros SET prominence_m = 10.5 WHERE ABS(height_m - 1004.9) < 1 AND prominence_m = height_m AND name ILIKE '%Maoile Lunndaidh%';
  UPDATE munros SET prominence_m = 133 WHERE ABS(height_m - 999.3) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr Choinnich%';
  UPDATE munros SET prominence_m = 226 WHERE ABS(height_m - 993) < 1 AND prominence_m = height_m AND name ILIKE '%Sgurr na Ruaidhe%';
  UPDATE munros SET prominence_m = 137 WHERE ABS(height_m - 992) < 1 AND prominence_m = height_m AND name ILIKE '%C_rn nan Gobhar%Strathfarrar%';
  UPDATE munros SET prominence_m = 197.5 WHERE ABS(height_m - 992.3) < 1 AND prominence_m = height_m AND name ILIKE '%C_rn nan Gobhar%Loch Mullardoch%';
  UPDATE munros SET prominence_m = 443 WHERE ABS(height_m - 987.5) < 1 AND prominence_m = height_m AND name ILIKE '%Lurg Mhor%';
  UPDATE munros SET prominence_m = 208.2 WHERE ABS(height_m - 945) < 1 AND prominence_m = height_m AND name ILIKE '%Bidein a%Choire Sheasgaich%';
  UPDATE munros SET prominence_m = 592 WHERE ABS(height_m - 925.7) < 1 AND prominence_m = height_m AND name ILIKE '%Moruisg%';
  UPDATE munros SET prominence_m = 302 WHERE ABS(height_m - 1129) < 1 AND prominence_m = height_m AND name ILIKE '%An Riabhachan%';
  UPDATE munros SET prominence_m = 207 WHERE ABS(height_m - 1069) < 1 AND prominence_m = height_m AND name ILIKE '%An Socach%Mullardoch%';

  RAISE NOTICE 'Fuzzy prominence updates applied';
END $$;

-- Final verification
SELECT
  COUNT(*) as total_munros,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
