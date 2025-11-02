/*
  # Fix Remaining Munro Prominence Values Using Height Matching

  1. Strategy
    - Match Munros by BOTH name and height for precise identification
    - This handles duplicates like "Ben Vorlich" which appear twice with different heights

  2. Updates
    - Updates all remaining Munros where prominence still equals height
    - Uses height as the discriminator for duplicate names
*/


UPDATE munros SET prominence_m = 646.9 WHERE height_m = 930.4 AND (
  name ILIKE '%Ben Chonzie%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Chonzie')
);
UPDATE munros SET prominence_m = 834.3 WHERE height_m = 985.3 AND (
  name ILIKE '%Ben Vorlich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Vorlich')
);
UPDATE munros SET prominence_m = 252.1 WHERE height_m = 973 AND (
  name ILIKE '%Stuc a'' Chroin%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stuc a'' Chroin')
);
UPDATE munros SET prominence_m = 986 WHERE height_m = 1173.9 AND (
  name ILIKE '%Ben More%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben More')
);
UPDATE munros SET prominence_m = 304.4 WHERE height_m = 1164.8 AND (
  name ILIKE '%Stob Binnein%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Binnein')
);
UPDATE munros SET prominence_m = 549 WHERE height_m = 1045.9 AND (
  name ILIKE '%Cruach Ardrain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Cruach Ardrain')
);
UPDATE munros SET prominence_m = 474 WHERE height_m = 995.9 AND (
  name ILIKE '%An Caisteal%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Caisteal')
);
UPDATE munros SET prominence_m = 820 WHERE height_m = 973.7 AND (
  name ILIKE '%Ben Lomond%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Lomond')
);
UPDATE munros SET prominence_m = 121.8 WHERE height_m = 945.8 AND (
  name ILIKE '%Beinn Tulaichean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Tulaichean')
);
UPDATE munros SET prominence_m = 313 WHERE height_m = 932.2 AND (
  name ILIKE '%Beinn Chabhair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Chabhair')
);
UPDATE munros SET prominence_m = 876 WHERE height_m = 1131.4 AND (
  name ILIKE '%Ben Lui%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Lui')
);
UPDATE munros SET prominence_m = 341.2 WHERE height_m = 1029.8 AND (
  name ILIKE '%Ben Oss%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Oss')
);
UPDATE munros SET prominence_m = 713 WHERE height_m = 1012.2 AND (
  name ILIKE '%Beinn Ime%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Ime')
);
UPDATE munros SET prominence_m = 198.9 WHERE height_m = 978.6 AND (
  name ILIKE '%Beinn Dubhchraig%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Dubhchraig')
);
UPDATE munros SET prominence_m = 592 WHERE height_m = 948.5 AND (
  name ILIKE '%Beinn Bhuidhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Bhuidhe')
);
UPDATE munros SET prominence_m = 632 WHERE height_m = 942.8 AND (
  name ILIKE '%Ben Vorlich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Vorlich')
);
UPDATE munros SET prominence_m = 290 WHERE height_m = 926.8 AND (
  name ILIKE '%Beinn Narnain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Narnain')
);
UPDATE munros SET prominence_m = 139.9 WHERE height_m = 916.3 AND (
  name ILIKE '%Beinn a'' Chleibh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chleibh')
);
UPDATE munros SET prominence_m = 424 WHERE height_m = 915.8 AND (
  name ILIKE '%Ben Vane%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Vane')
);
UPDATE munros SET prominence_m = 716 WHERE height_m = 1083.3 AND (
  name ILIKE '%Schiehallion%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Schiehallion')
);
UPDATE munros SET prominence_m = 650 WHERE height_m = 1080.6 AND (
  name ILIKE '%Beinn a'' Chreachain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chreachain')
);
UPDATE munros SET prominence_m = 332 WHERE height_m = 1076 AND (
  name ILIKE '%Beinn Dorain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Dorain')
);
UPDATE munros SET prominence_m = 466.9 WHERE height_m = 1043 AND (
  name ILIKE '%Carn Mairg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Mairg')
);
UPDATE munros SET prominence_m = 226 WHERE height_m = 1038.6 AND (
  name ILIKE '%Beinn Achaladair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Achaladair')
);
UPDATE munros SET prominence_m = 188.5 WHERE height_m = 1029.5 AND (
  name ILIKE '%Carn Gorm%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Gorm')
);
UPDATE munros SET prominence_m = 247 WHERE height_m = 1004 AND (
  name ILIKE '%Beinn an Dothaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn an Dothaidh')
);
UPDATE munros SET prominence_m = 136 WHERE height_m = 981 AND (
  name ILIKE '%Meall na Aighean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall na Aighean')
);
UPDATE munros SET prominence_m = 102.2 WHERE height_m = 967.5 AND (
  name ILIKE '%Meall Garbh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Garbh')
);
UPDATE munros SET prominence_m = 481 WHERE height_m = 959.5 AND (
  name ILIKE '%Stuc an Lochain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stuc an Lochain')
);
UPDATE munros SET prominence_m = 315 WHERE height_m = 952.5 AND (
  name ILIKE '%Beinn Mhanach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Mhanach')
);
UPDATE munros SET prominence_m = 321.1 WHERE height_m = 932.1 AND (
  name ILIKE '%Meall Buidhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Buidhe')
);
UPDATE munros SET prominence_m = 914 WHERE height_m = 1214.3 AND (
  name ILIKE '%Ben Lawers%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Lawers')
);
UPDATE munros SET prominence_m = 126 WHERE height_m = 1117.1 AND (
  name ILIKE '%An Stuc%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Stuc')
);
UPDATE munros SET prominence_m = 198 WHERE height_m = 1123.1 AND (
  name ILIKE '%Meall Garbh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Garbh')
);
UPDATE munros SET prominence_m = 109.1 WHERE height_m = 1103.4 AND (
  name ILIKE '%Beinn Ghlas%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Ghlas')
);
UPDATE munros SET prominence_m = 579 WHERE height_m = 1077.4 AND (
  name ILIKE '%Beinn Sheasgarnaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Sheasgarnaich')
);
UPDATE munros SET prominence_m = 201.3 WHERE height_m = 1067.2 AND (
  name ILIKE '%Meall Corranaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Corranaich')
);
UPDATE munros SET prominence_m = 394 WHERE height_m = 1046.8 AND (
  name ILIKE '%Creag Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creag Mhor')
);
UPDATE munros SET prominence_m = 494.4 WHERE height_m = 1043.6 AND (
  name ILIKE '%Meall nan Tarmachan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall nan Tarmachan')
);
UPDATE munros SET prominence_m = 492 WHERE height_m = 1039.8 AND (
  name ILIKE '%Meall Ghaordaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Ghaordaidh')
);
UPDATE munros SET prominence_m = 450 WHERE height_m = 1024.9 AND (
  name ILIKE '%Beinn Challuim%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Challuim')
);
UPDATE munros SET prominence_m = 167 WHERE height_m = 1001 AND (
  name ILIKE '%Meall Greigh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Greigh')
);
UPDATE munros SET prominence_m = 554 WHERE height_m = 959.3 AND (
  name ILIKE '%Meall Glas%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Glas')
);
UPDATE munros SET prominence_m = 150.5 WHERE height_m = 925.6 AND (
  name ILIKE '%Meall a'' Choire Leith%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall a'' Choire Leith')
);
UPDATE munros SET prominence_m = 311 WHERE height_m = 920.1 AND (
  name ILIKE '%Sgiath Chuil%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgiath Chuil')
);
UPDATE munros SET prominence_m = 623 WHERE height_m = 967.7 AND (
  name ILIKE '%Aonach Eagach - Sgorr nam Fiannaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach Eagach - Sgorr nam Fiannaidh')
);
UPDATE munros SET prominence_m = 120.3 WHERE height_m = 952.3 AND (
  name ILIKE '%Aonach Eagach - Meall Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach Eagach - Meall Dearg')
);
UPDATE munros SET prominence_m = 844 WHERE height_m = 1149.4 AND (
  name ILIKE '%Bidean nam Bian%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Bidean nam Bian')
);
UPDATE munros SET prominence_m = 128 WHERE height_m = 1072 AND (
  name ILIKE '%Stob Coire Sgreamhach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Coire Sgreamhach')
);
UPDATE munros SET prominence_m = 729 WHERE height_m = 1024.2 AND (
  name ILIKE '%Beinn a'' Bheithir - Sgorr Dhearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Bheithir - Sgorr Dhearg')
);
UPDATE munros SET prominence_m = 532 WHERE height_m = 1021.4 AND (
  name ILIKE '%Buachaille Etive Mor - Stob Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Buachaille Etive Mor - Stob Dearg')
);
UPDATE munros SET prominence_m = 245.1 WHERE height_m = 1002.1 AND (
  name ILIKE '%Beinn a'' Bheithir - Sgorr Dhonuill%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Bheithir - Sgorr Dhonuill')
);
UPDATE munros SET prominence_m = 415 WHERE height_m = 994 AND (
  name ILIKE '%Sgurr na h-Ulaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na h-Ulaidh')
);
UPDATE munros SET prominence_m = 510 WHERE height_m = 959 AND (
  name ILIKE '%Beinn Fhionnlaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Fhionnlaidh')
);
UPDATE munros SET prominence_m = 469 WHERE height_m = 958 AND (
  name ILIKE '%Buachaille Etive Beag - Stob Dubh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Buachaille Etive Beag - Stob Dubh')
);
UPDATE munros SET prominence_m = 134.5 WHERE height_m = 953.4 AND (
  name ILIKE '%Buachaille Etive Mor - Stob na Broige%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Buachaille Etive Mor - Stob na Broige')
);
UPDATE munros SET prominence_m = 662 WHERE height_m = 937 AND (
  name ILIKE '%Beinn Sgulaird%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Sgulaird')
);
UPDATE munros SET prominence_m = 177.7 WHERE height_m = 924.5 AND (
  name ILIKE '%Buachaille Etive Beag - Stob Coire Raineach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Buachaille Etive Beag - Stob Coire Raineach')
);
UPDATE munros SET prominence_m = 880 WHERE height_m = 1127 AND (
  name ILIKE '%Ben Cruachan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Cruachan')
);
UPDATE munros SET prominence_m = 795 WHERE height_m = 1107.9 AND (
  name ILIKE '%Meall a'' Bhuiridh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall a'' Bhuiridh')
);
UPDATE munros SET prominence_m = 169.4 WHERE height_m = 1099.8 AND (
  name ILIKE '%Creise%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creise')
);
UPDATE munros SET prominence_m = 392 WHERE height_m = 1089.2 AND (
  name ILIKE '%Stob Ghabhar%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Ghabhar')
);
UPDATE munros SET prominence_m = 448.8 WHERE height_m = 1079.5 AND (
  name ILIKE '%Ben Starav%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Starav')
);
UPDATE munros SET prominence_m = 307 WHERE height_m = 1044.9 AND (
  name ILIKE '%Stob Coir'' an Albannaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Coir'' an Albannaich')
);
UPDATE munros SET prominence_m = 134.5 WHERE height_m = 999.2 AND (
  name ILIKE '%Stob Daimh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Daimh')
);
UPDATE munros SET prominence_m = 231.3 WHERE height_m = 997.7 AND (
  name ILIKE '%Glas Bheinn Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Glas Bheinn Mhor')
);
UPDATE munros SET prominence_m = 425 WHERE height_m = 989 AND (
  name ILIKE '%Beinn Eunaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Eunaich')
);
UPDATE munros SET prominence_m = 252 WHERE height_m = 980 AND (
  name ILIKE '%Beinn a'' Chochuill%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chochuill')
);
UPDATE munros SET prominence_m = 343.4 WHERE height_m = 959 AND (
  name ILIKE '%Beinn nan Aighenan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn nan Aighenan')
);
UPDATE munros SET prominence_m = 279.4 WHERE height_m = 945 AND (
  name ILIKE '%Stob a'' Choire Odhair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob a'' Choire Odhair')
);
UPDATE munros SET prominence_m = 174.5 WHERE height_m = 928.1 AND (
  name ILIKE '%Meall nan Eun%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall nan Eun')
);
UPDATE munros SET prominence_m = 1344.5 WHERE height_m = 1344.5 AND (
  name ILIKE '%Ben Nevis%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Nevis')
);
UPDATE munros SET prominence_m = 404 WHERE height_m = 1234 AND (
  name ILIKE '%Aonach Beag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach Beag')
);
UPDATE munros SET prominence_m = 133 WHERE height_m = 1220.4 AND (
  name ILIKE '%Aonach Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach Mor')
);
UPDATE munros SET prominence_m = 162 WHERE height_m = 1220 AND (
  name ILIKE '%Carn Mor Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Mor Dearg')
);
UPDATE munros SET prominence_m = 446 WHERE height_m = 1177 AND (
  name ILIKE '%Stob Choire Claurigh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Choire Claurigh')
);
UPDATE munros SET prominence_m = 759 WHERE height_m = 1130 AND (
  name ILIKE '%Binnein Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Binnein Mor')
);
UPDATE munros SET prominence_m = 74 WHERE height_m = 1116 AND (
  name ILIKE '%Stob Coire an Laoigh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Coire an Laoigh')
);
UPDATE munros SET prominence_m = 611 WHERE height_m = 1115 AND (
  name ILIKE '%Stob Coire Easain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Coire Easain')
);
UPDATE munros SET prominence_m = 140 WHERE height_m = 1105 AND (
  name ILIKE '%Stob a'' Choire Mheadhoin%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob a'' Choire Mheadhoin')
);
UPDATE munros SET prominence_m = 316 WHERE height_m = 1099 AND (
  name ILIKE '%Sgurr a'' Mhaim%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Mhaim')
);
UPDATE munros SET prominence_m = 159 WHERE height_m = 1094 AND (
  name ILIKE '%Sgurr Choinnich Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Choinnich Mor')
);
UPDATE munros SET prominence_m = 96.8 WHERE height_m = 1054.3 AND (
  name ILIKE '%Na Gruagaichean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Na Gruagaichean')
);
UPDATE munros SET prominence_m = 152.8 WHERE height_m = 1031.8 AND (
  name ILIKE '%Am Bodach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Am Bodach')
);
UPDATE munros SET prominence_m = 271 WHERE height_m = 1010 AND (
  name ILIKE '%Sgurr Eilde Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Eilde Mor')
);
UPDATE munros SET prominence_m = 237.1 WHERE height_m = 999.7 AND (
  name ILIKE '%Stob Ban%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Ban')
);
UPDATE munros SET prominence_m = 151.7 WHERE height_m = 981.5 AND (
  name ILIKE '%An Gearanach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Gearanach')
);
UPDATE munros SET prominence_m = 124.5 WHERE height_m = 981.3 AND (
  name ILIKE '%Stob Coire a'' Chairn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Coire a'' Chairn')
);
UPDATE munros SET prominence_m = 174 WHERE height_m = 977 AND (
  name ILIKE '%Stob Ban%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Ban')
);
UPDATE munros SET prominence_m = 197 WHERE height_m = 943 AND (
  name ILIKE '%Binnein Beag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Binnein Beag')
);
UPDATE munros SET prominence_m = 92.3 WHERE height_m = 939.3 AND (
  name ILIKE '%Mullach nan Coirean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mullach nan Coirean')
);
UPDATE munros SET prominence_m = 783 WHERE height_m = 1148 AND (
  name ILIKE '%Ben Alder%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Alder')
);
UPDATE munros SET prominence_m = 410 WHERE height_m = 1132 AND (
  name ILIKE '%Geal-charn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Geal-charn')
);
UPDATE munros SET prominence_m = 99 WHERE height_m = 1115.8 AND (
  name ILIKE '%Aonach Beag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach Beag')
);
UPDATE munros SET prominence_m = 127 WHERE height_m = 1103.3 AND (
  name ILIKE '%Beinn Eibhinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Eibhinn')
);
UPDATE munros SET prominence_m = 540 WHERE height_m = 1087.8 AND (
  name ILIKE '%Beinn a'' Chlachair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chlachair')
);
UPDATE munros SET prominence_m = 311 WHERE height_m = 1049.7 AND (
  name ILIKE '%Geal Charn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Geal Charn')
);
UPDATE munros SET prominence_m = 644 WHERE height_m = 1046 AND (
  name ILIKE '%Chno Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Chno Dearg')
);
UPDATE munros SET prominence_m = 158 WHERE height_m = 1034 AND (
  name ILIKE '%Carn Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Dearg')
);
UPDATE munros SET prominence_m = 186 WHERE height_m = 1019 AND (
  name ILIKE '%Beinn Bheoil%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Bheoil')
);
UPDATE munros SET prominence_m = 90 WHERE height_m = 979 AND (
  name ILIKE '%Stob Coire Sgriodain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Coire Sgriodain')
);
UPDATE munros SET prominence_m = 300 WHERE height_m = 954.7 AND (
  name ILIKE '%Sgor Gaibhre%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgor Gaibhre')
);
UPDATE munros SET prominence_m = 221 WHERE height_m = 941 AND (
  name ILIKE '%Carn Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Dearg')
);
UPDATE munros SET prominence_m = 406 WHERE height_m = 935 AND (
  name ILIKE '%Beinn na Lap%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn na Lap')
);
UPDATE munros SET prominence_m = 104.2 WHERE height_m = 924.5 AND (
  name ILIKE '%Creag Pitridh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creag Pitridh')
);
UPDATE munros SET prominence_m = 555 WHERE height_m = 1010.2 AND (
  name ILIKE '%Beinn Udlamain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Udlamain')
);
UPDATE munros SET prominence_m = 182 WHERE height_m = 991.4 AND (
  name ILIKE '%Sgairneach Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgairneach Mhor')
);
UPDATE munros SET prominence_m = 112 WHERE height_m = 973.2 AND (
  name ILIKE '%A'' Mharconaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Mharconaich')
);
UPDATE munros SET prominence_m = 466 WHERE height_m = 950.8 AND (
  name ILIKE '%Meall Chuaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Chuaich')
);
UPDATE munros SET prominence_m = 328.1 WHERE height_m = 940.8 AND (
  name ILIKE '%Carn na Caim%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn na Caim')
);
UPDATE munros SET prominence_m = 109 WHERE height_m = 936 AND (
  name ILIKE '%A'' Bhuidheanach Bheag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Bhuidheanach Bheag')
);
UPDATE munros SET prominence_m = 178 WHERE height_m = 917.1 AND (
  name ILIKE '%Geal-charn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Geal-charn')
);
UPDATE munros SET prominence_m = 473 WHERE height_m = 1008.7 AND (
  name ILIKE '%Beinn Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Dearg')
);
UPDATE munros SET prominence_m = 319 WHERE height_m = 1006.5 AND (
  name ILIKE '%An Sgarsoch%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Sgarsoch')
);
UPDATE munros SET prominence_m = 286 WHERE height_m = 994 AND (
  name ILIKE '%Carn an Fhidhleir%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn an Fhidhleir')
);
UPDATE munros SET prominence_m = 317 WHERE height_m = 963.5 AND (
  name ILIKE '%Carn a'' Chlamain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn a'' Chlamain')
);
UPDATE munros SET prominence_m = 658 WHERE height_m = 1121.9 AND (
  name ILIKE '%Beinn a'' Ghlo - Carn nan Gabhar%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Ghlo - Carn nan Gabhar')
);
UPDATE munros SET prominence_m = 222.4 WHERE height_m = 1070 AND (
  name ILIKE '%Beinn a'' Ghlo - Braigh Coire Chruinn-bhalgain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Ghlo - Braigh Coire Chruinn-bhalgain')
);
UPDATE munros SET prominence_m = 384 WHERE height_m = 1051 AND (
  name ILIKE '%Glas Tulaichean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Glas Tulaichean')
);
UPDATE munros SET prominence_m = 247 WHERE height_m = 1045 AND (
  name ILIKE '%Beinn Iutharn Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Iutharn Mhor')
);
UPDATE munros SET prominence_m = 258 WHERE height_m = 1029 AND (
  name ILIKE '%Carn an Righ%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn an Righ')
);
UPDATE munros SET prominence_m = 299 WHERE height_m = 976.1 AND (
  name ILIKE '%Carn a'' Gheoidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn a'' Gheoidh')
);
UPDATE munros SET prominence_m = 207.1 WHERE height_m = 975.8 AND (
  name ILIKE '%Beinn a'' Ghlo - Carn Liath%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Ghlo - Carn Liath')
);
UPDATE munros SET prominence_m = 186.9 WHERE height_m = 945.1 AND (
  name ILIKE '%Carn Bhac%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Bhac')
);
UPDATE munros SET prominence_m = 187 WHERE height_m = 942.8 AND (
  name ILIKE '%An Socach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Socach')
);
UPDATE munros SET prominence_m = 127.1 WHERE height_m = 933 AND (
  name ILIKE '%The Cairnwell%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('The Cairnwell')
);
UPDATE munros SET prominence_m = 122.1 WHERE height_m = 915.3 AND (
  name ILIKE '%Carn Aosda%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Aosda')
);
UPDATE munros SET prominence_m = 671 WHERE height_m = 1155.7 AND (
  name ILIKE '%Lochnagar - Cac Carn Beag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Lochnagar - Cac Carn Beag')
);
UPDATE munros SET prominence_m = 72.9 WHERE height_m = 1109.9 AND (
  name ILIKE '%Carn a'' Choire Bhoidheach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn a'' Choire Bhoidheach')
);
UPDATE munros SET prominence_m = 195.2 WHERE height_m = 1067.7 AND (
  name ILIKE '%Glas Maol%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Glas Maol')
);
UPDATE munros SET prominence_m = 118.9 WHERE height_m = 1063.1 AND (
  name ILIKE '%Cairn of Claise%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Cairn of Claise')
);
UPDATE munros SET prominence_m = 85 WHERE height_m = 1047 AND (
  name ILIKE '%Carn an t-Sagairt Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn an t-Sagairt Mor')
);
UPDATE munros SET prominence_m = 61.6 WHERE height_m = 1018.8 AND (
  name ILIKE '%Carn an Tuirc%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn an Tuirc')
);
UPDATE munros SET prominence_m = 76 WHERE height_m = 1011.1 AND (
  name ILIKE '%Cairn Bannoch%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Cairn Bannoch')
);
UPDATE munros SET prominence_m = 63.9 WHERE height_m = 997.1 AND (
  name ILIKE '%Broad Cairn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Broad Cairn')
);
UPDATE munros SET prominence_m = 70.7 WHERE height_m = 988.2 AND (
  name ILIKE '%Creag Leacach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creag Leacach')
);
UPDATE munros SET prominence_m = 73.7 WHERE height_m = 957.8 AND (
  name ILIKE '%Tolmount%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Tolmount')
);
UPDATE munros SET prominence_m = 72.6 WHERE height_m = 957.8 AND (
  name ILIKE '%Tom Buidhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Tom Buidhe')
);
UPDATE munros SET prominence_m = 136.9 WHERE height_m = 947.6 AND (
  name ILIKE '%Driesh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Driesh')
);
UPDATE munros SET prominence_m = 312 WHERE height_m = 939.4 AND (
  name ILIKE '%Mount Keen%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mount Keen')
);
UPDATE munros SET prominence_m = 112 WHERE height_m = 928.6 AND (
  name ILIKE '%Mayar%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mayar')
);
UPDATE munros SET prominence_m = 950 WHERE height_m = 1309.3 AND (
  name ILIKE '%Ben Macdui%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Macdui')
);
UPDATE munros SET prominence_m = 461 WHERE height_m = 1296 AND (
  name ILIKE '%Braeriach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Braeriach')
);
UPDATE munros SET prominence_m = 166 WHERE height_m = 1291 AND (
  name ILIKE '%Cairn Toul%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Cairn Toul')
);
UPDATE munros SET prominence_m = 118 WHERE height_m = 1258 AND (
  name ILIKE '%Sgor an Lochain Uaine%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgor an Lochain Uaine')
);
UPDATE munros SET prominence_m = 145.8 WHERE height_m = 1244.8 AND (
  name ILIKE '%Cairn Gorm%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Cairn Gorm')
);
UPDATE munros SET prominence_m = 456.2 WHERE height_m = 1196 AND (
  name ILIKE '%Beinn a'' Bhuird%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Bhuird')
);
UPDATE munros SET prominence_m = 254 WHERE height_m = 1182.9 AND (
  name ILIKE '%Beinn Mheadhoin%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Mheadhoin')
);
UPDATE munros SET prominence_m = 198 WHERE height_m = 1172 AND (
  name ILIKE '%Ben Avon - Leabaidh an Daimh Bhuidhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Avon - Leabaidh an Daimh Bhuidhe')
);
UPDATE munros SET prominence_m = 258 WHERE height_m = 1157 AND (
  name ILIKE '%Beinn Bhrotain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Bhrotain')
);
UPDATE munros SET prominence_m = 142 WHERE height_m = 1155.8 AND (
  name ILIKE '%Derry Cairngorm%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Derry Cairngorm')
);
UPDATE munros SET prominence_m = 242.8 WHERE height_m = 1116 AND (
  name ILIKE '%Sgor Gaoith%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgor Gaoith')
);
UPDATE munros SET prominence_m = 138.8 WHERE height_m = 1113.4 AND (
  name ILIKE '%Monadh Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Monadh Mor')
);
UPDATE munros SET prominence_m = 283 WHERE height_m = 1090 AND (
  name ILIKE '%Bynack More%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Bynack More')
);
UPDATE munros SET prominence_m = 246.3 WHERE height_m = 1083.3 AND (
  name ILIKE '%Beinn a'' Chaorainn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chaorainn')
);
UPDATE munros SET prominence_m = 231 WHERE height_m = 1037 AND (
  name ILIKE '%Carn a'' Mhaim%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn a'' Mhaim')
);
UPDATE munros SET prominence_m = 104.9 WHERE height_m = 1019 AND (
  name ILIKE '%Mullach Clach a'' Bhlair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mullach Clach a'' Bhlair')
);
UPDATE munros SET prominence_m = 90.6 WHERE height_m = 1006.9 AND (
  name ILIKE '%The Devil''s Point%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('The Devil''s Point')
);
UPDATE munros SET prominence_m = 80.9 WHERE height_m = 930.3 AND (
  name ILIKE '%Beinn Bhreac%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Bhreac')
);
UPDATE munros SET prominence_m = 591 WHERE height_m = 945.7 AND (
  name ILIKE '%Carn Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Dearg')
);
UPDATE munros SET prominence_m = 108.3 WHERE height_m = 929.3 AND (
  name ILIKE '%A'' Chailleach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Chailleach')
);
UPDATE munros SET prominence_m = 101.1 WHERE height_m = 926.3 AND (
  name ILIKE '%Geal Charn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Geal Charn')
);
UPDATE munros SET prominence_m = 71.6 WHERE height_m = 920.3 AND (
  name ILIKE '%Carn Sgulain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Sgulain')
);
UPDATE munros SET prominence_m = 868 WHERE height_m = 1128.1 AND (
  name ILIKE '%Creag Meagaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creag Meagaidh')
);
UPDATE munros SET prominence_m = 107 WHERE height_m = 1052.5 AND (
  name ILIKE '%Stob Poite Coire Ardair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Stob Poite Coire Ardair')
);
UPDATE munros SET prominence_m = 227 WHERE height_m = 1049.1 AND (
  name ILIKE '%Beinn a'' Chaorainn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chaorainn')
);
UPDATE munros SET prominence_m = 86.9 WHERE height_m = 1006.1 AND (
  name ILIKE '%Carn Liath%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Liath')
);
UPDATE munros SET prominence_m = 301.5 WHERE height_m = 914.6 AND (
  name ILIKE '%Beinn Teallach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Teallach')
);
UPDATE munros SET prominence_m = 767.7 WHERE height_m = 1035.1 AND (
  name ILIKE '%Gleouraich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Gleouraich')
);
UPDATE munros SET prominence_m = 708 WHERE height_m = 1026.6 AND (
  name ILIKE '%Sgurr a'' Mhaoraich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Mhaoraich')
);
UPDATE munros SET prominence_m = 493 WHERE height_m = 1019.5 AND (
  name ILIKE '%Aonach air Chrith%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach air Chrith')
);
UPDATE munros SET prominence_m = 189 WHERE height_m = 1010 AND (
  name ILIKE '%Sgurr an Doire Leathain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr an Doire Leathain')
);
UPDATE munros SET prominence_m = 334 WHERE height_m = 1011.5 AND (
  name ILIKE '%The Saddle%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('The Saddle')
);
UPDATE munros SET prominence_m = 123 WHERE height_m = 1004 AND (
  name ILIKE '%Sgurr an Lochain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr an Lochain')
);
UPDATE munros SET prominence_m = 259.5 WHERE height_m = 995.9 AND (
  name ILIKE '%Spidean Mialach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Spidean Mialach')
);
UPDATE munros SET prominence_m = 101.3 WHERE height_m = 985.2 AND (
  name ILIKE '%Druim Shionnach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Druim Shionnach')
);
UPDATE munros SET prominence_m = 137.6 WHERE height_m = 980.3 AND (
  name ILIKE '%Maol Chinn-dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Maol Chinn-dearg')
);
UPDATE munros SET prominence_m = 500 WHERE height_m = 974 AND (
  name ILIKE '%Beinn Sgritheall%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Sgritheall')
);
UPDATE munros SET prominence_m = 79.6 WHERE height_m = 946.2 AND (
  name ILIKE '%Creag a'' Mhaim%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creag a'' Mhaim')
);
UPDATE munros SET prominence_m = 247 WHERE height_m = 946 AND (
  name ILIKE '%Sgurr na Sgine%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Sgine')
);
UPDATE munros SET prominence_m = 196 WHERE height_m = 917.2 AND (
  name ILIKE '%Creag nan Damh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Creag nan Damh')
);
UPDATE munros SET prominence_m = 839 WHERE height_m = 1040.2 AND (
  name ILIKE '%Sgurr na Ciche%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Ciche')
);
UPDATE munros SET prominence_m = 795 WHERE height_m = 1020 AND (
  name ILIKE '%Ladhar Bheinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ladhar Bheinn')
);
UPDATE munros SET prominence_m = 169.5 WHERE height_m = 1012.9 AND (
  name ILIKE '%Garbh Chioch Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Garbh Chioch Mhor')
);
UPDATE munros SET prominence_m = 341 WHERE height_m = 1003 AND (
  name ILIKE '%Sgurr Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Mor')
);
UPDATE munros SET prominence_m = 221.7 WHERE height_m = 953.8 AND (
  name ILIKE '%Sgurr nan Coireachan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Coireachan')
);
UPDATE munros SET prominence_m = 497 WHERE height_m = 945.5 AND (
  name ILIKE '%Meall Buidhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Buidhe')
);
UPDATE munros SET prominence_m = 256.6 WHERE height_m = 938.6 AND (
  name ILIKE '%Luinne Bheinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Luinne Bheinn')
);
UPDATE munros SET prominence_m = 552 WHERE height_m = 918.8 AND (
  name ILIKE '%Gairich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Gairich')
);
UPDATE munros SET prominence_m = 621 WHERE height_m = 936.2 AND (
  name ILIKE '%Sron a'' Choire Ghairbh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sron a'' Choire Ghairbh')
);
UPDATE munros SET prominence_m = 305.5 WHERE height_m = 916.8 AND (
  name ILIKE '%Meall na Teanga%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall na Teanga')
);
UPDATE munros SET prominence_m = 842 WHERE height_m = 987 AND (
  name ILIKE '%Gulvain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Gulvain')
);
UPDATE munros SET prominence_m = 614 WHERE height_m = 963 AND (
  name ILIKE '%Sgurr Thuilm%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Thuilm')
);
UPDATE munros SET prominence_m = 231.8 WHERE height_m = 956.3 AND (
  name ILIKE '%Sgurr nan Coireachan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Coireachan')
);
UPDATE munros SET prominence_m = 1147 WHERE height_m = 1182.8 AND (
  name ILIKE '%Carn Eighe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Eighe')
);
UPDATE munros SET prominence_m = 132.4 WHERE height_m = 1179.4 AND (
  name ILIKE '%Mam Sodhail%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mam Sodhail')
);
UPDATE munros SET prominence_m = 433 WHERE height_m = 1149.7 AND (
  name ILIKE '%Sgurr nan Ceathramhnan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Ceathramhnan')
);
UPDATE munros SET prominence_m = 149.8 WHERE height_m = 1112.7 AND (
  name ILIKE '%Tom a'' Choinnich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Tom a'' Choinnich')
);
UPDATE munros SET prominence_m = 665 WHERE height_m = 1068.8 AND (
  name ILIKE '%Sgurr Fhuaran%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Fhuaran')
);
UPDATE munros SET prominence_m = 181.4 WHERE height_m = 1053.7 AND (
  name ILIKE '%Toll Creagach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Toll Creagach')
);
UPDATE munros SET prominence_m = 311 WHERE height_m = 1036 AND (
  name ILIKE '%Sgurr a'' Bhealaich Dheirg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Bhealaich Dheirg')
);
UPDATE munros SET prominence_m = 647 WHERE height_m = 1031.9 AND (
  name ILIKE '%Beinn Fhada%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Fhada')
);
UPDATE munros SET prominence_m = 178 WHERE height_m = 1027 AND (
  name ILIKE '%Sgurr na Ciste Duibhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Ciste Duibhe')
);
UPDATE munros SET prominence_m = 173 WHERE height_m = 1004.8 AND (
  name ILIKE '%Beinn Fhionnlaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Fhionnlaidh')
);
UPDATE munros SET prominence_m = 134 WHERE height_m = 1002 AND (
  name ILIKE '%Sgurr na Carnach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Carnach')
);
UPDATE munros SET prominence_m = 174 WHERE height_m = 1001 AND (
  name ILIKE '%Aonach Meadhoin%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Aonach Meadhoin')
);
UPDATE munros SET prominence_m = 144 WHERE height_m = 982 AND (
  name ILIKE '%Mullach na Dheiragain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mullach na Dheiragain')
);
UPDATE munros SET prominence_m = 390.5 WHERE height_m = 981.1 AND (
  name ILIKE '%Ciste Dhubh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ciste Dhubh')
);
UPDATE munros SET prominence_m = 91 WHERE height_m = 956 AND (
  name ILIKE '%Saileag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Saileag')
);
UPDATE munros SET prominence_m = 123.8 WHERE height_m = 919.7 AND (
  name ILIKE '%An Socach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Socach')
);
UPDATE munros SET prominence_m = 407 WHERE height_m = 918 AND (
  name ILIKE '%A'' Ghlas-bheinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Ghlas-bheinn')
);
UPDATE munros SET prominence_m = 786 WHERE height_m = 1120 AND (
  name ILIKE '%A'' Chraileag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Chraileag')
);
UPDATE munros SET prominence_m = 382 WHERE height_m = 1109 AND (
  name ILIKE '%Sgurr nan Conbhairean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Conbhairean')
);
UPDATE munros SET prominence_m = 151.3 WHERE height_m = 1100.9 AND (
  name ILIKE '%Mullach Fraoch-choire%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mullach Fraoch-choire')
);
UPDATE munros SET prominence_m = 87 WHERE height_m = 999.2 AND (
  name ILIKE '%Sail Chaorainn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sail Chaorainn')
);
UPDATE munros SET prominence_m = 62.7 WHERE height_m = 956.3 AND (
  name ILIKE '%Carn Ghluasaid%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn Ghluasaid')
);
UPDATE munros SET prominence_m = 819 WHERE height_m = 1083.7 AND (
  name ILIKE '%Sgurr a'' Choire Ghlais%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Choire Ghlais')
);
UPDATE munros SET prominence_m = 568 WHERE height_m = 1053 AND (
  name ILIKE '%Sgurr a'' Chaorachain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Chaorachain')
);
UPDATE munros SET prominence_m = 148.1 WHERE height_m = 1049.2 AND (
  name ILIKE '%Sgurr Fhuar-thuill%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Fhuar-thuill')
);
UPDATE munros SET prominence_m = 10.5 WHERE height_m = 1004.9 AND (
  name ILIKE '%Maoile Lunndaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Maoile Lunndaidh')
);
UPDATE munros SET prominence_m = 133 WHERE height_m = 999.3 AND (
  name ILIKE '%Sgurr Choinnich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Choinnich')
);
UPDATE munros SET prominence_m = 226 WHERE height_m = 993 AND (
  name ILIKE '%Sgurr na Ruaidhe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Ruaidhe')
);
UPDATE munros SET prominence_m = 137 WHERE height_m = 992 AND (
  name ILIKE '%Carn nan Gobhar%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn nan Gobhar')
);
UPDATE munros SET prominence_m = 443 WHERE height_m = 987.5 AND (
  name ILIKE '%Lurg Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Lurg Mhor')
);
UPDATE munros SET prominence_m = 208.2 WHERE height_m = 945 AND (
  name ILIKE '%Bidein a'' Choire Sheasgaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Bidein a'' Choire Sheasgaich')
);
UPDATE munros SET prominence_m = 592 WHERE height_m = 925.7 AND (
  name ILIKE '%Moruisg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Moruisg')
);
UPDATE munros SET prominence_m = 841 WHERE height_m = 1151.9 AND (
  name ILIKE '%Sgurr na Lapaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Lapaich')
);
UPDATE munros SET prominence_m = 302 WHERE height_m = 1129 AND (
  name ILIKE '%An Riabhachan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Riabhachan')
);
UPDATE munros SET prominence_m = 207 WHERE height_m = 1069 AND (
  name ILIKE '%An Socach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Socach')
);
UPDATE munros SET prominence_m = 197.5 WHERE height_m = 992.3 AND (
  name ILIKE '%Carn nan Gobhar%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Carn nan Gobhar')
);
UPDATE munros SET prominence_m = 957 WHERE height_m = 1054.8 AND (
  name ILIKE '%Liathach - Spidean a'' Choire Leith%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Liathach - Spidean a'' Choire Leith')
);
UPDATE munros SET prominence_m = 152.1 WHERE height_m = 1023.9 AND (
  name ILIKE '%Liathach - Mullach an Rathain%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Liathach - Mullach an Rathain')
);
UPDATE munros SET prominence_m = 632 WHERE height_m = 1010 AND (
  name ILIKE '%Beinn Eighe - Ruadh-stac Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Eighe - Ruadh-stac Mor')
);
UPDATE munros SET prominence_m = 172 WHERE height_m = 993 AND (
  name ILIKE '%Beinn Eighe - Spidean Coire nan Clach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Eighe - Spidean Coire nan Clach')
);
UPDATE munros SET prominence_m = 601 WHERE height_m = 986 AND (
  name ILIKE '%Beinn Alligin - Sgurr Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Alligin - Sgurr Mor')
);
UPDATE munros SET prominence_m = 155 WHERE height_m = 922 AND (
  name ILIKE '%Beinn Alligin - Tom na Gruagaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Alligin - Tom na Gruagaich')
);
UPDATE munros SET prominence_m = 723 WHERE height_m = 960.7 AND (
  name ILIKE '%Sgorr Ruadh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgorr Ruadh')
);
UPDATE munros SET prominence_m = 514 WHERE height_m = 933 AND (
  name ILIKE '%Maol Chean-dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Maol Chean-dearg')
);
UPDATE munros SET prominence_m = 271 WHERE height_m = 926 AND (
  name ILIKE '%Beinn Liath Mhor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Liath Mhor')
);
UPDATE munros SET prominence_m = 757 WHERE height_m = 1062.6 AND (
  name ILIKE '%An Teallach - Bidein a'' Ghlas Thuill%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Teallach - Bidein a'' Ghlas Thuill')
);
UPDATE munros SET prominence_m = 141.7 WHERE height_m = 1058.7 AND (
  name ILIKE '%An Teallach - Sgurr Fiona%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Teallach - Sgurr Fiona')
);
UPDATE munros SET prominence_m = 591 WHERE height_m = 1015.2 AND (
  name ILIKE '%Mullach Coire Mhic Fhearchair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Mullach Coire Mhic Fhearchair')
);
UPDATE munros SET prominence_m = 165 WHERE height_m = 989 AND (
  name ILIKE '%Sgurr Ban%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Ban')
);
UPDATE munros SET prominence_m = 626 WHERE height_m = 981 AND (
  name ILIKE '%Slioch%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Slioch')
);
UPDATE munros SET prominence_m = 443 WHERE height_m = 965.8 AND (
  name ILIKE '%A'' Mhaighdean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Mhaighdean')
);
UPDATE munros SET prominence_m = 207.1 WHERE height_m = 933.8 AND (
  name ILIKE '%Beinn Tarsuinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Tarsuinn')
);
UPDATE munros SET prominence_m = 169.8 WHERE height_m = 918.7 AND (
  name ILIKE '%Ruadh Stac Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ruadh Stac Mor')
);
UPDATE munros SET prominence_m = 914 WHERE height_m = 1108.9 AND (
  name ILIKE '%Sgurr Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Mor')
);
UPDATE munros SET prominence_m = 229 WHERE height_m = 1093 AND (
  name ILIKE '%Sgurr nan Clach Geala%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Clach Geala')
);
UPDATE munros SET prominence_m = 450.8 WHERE height_m = 999.6 AND (
  name ILIKE '%Sgurr Breac%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Breac')
);
UPDATE munros SET prominence_m = 182.9 WHERE height_m = 998.6 AND (
  name ILIKE '%A'' Chailleach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('A'' Chailleach')
);
UPDATE munros SET prominence_m = 107 WHERE height_m = 954.2 AND (
  name ILIKE '%Beinn Liath Mhor Fannaich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Liath Mhor Fannaich')
);
UPDATE munros SET prominence_m = 112.3 WHERE height_m = 949.7 AND (
  name ILIKE '%Meall Gorm%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall Gorm')
);
UPDATE munros SET prominence_m = 115 WHERE height_m = 934 AND (
  name ILIKE '%Meall a'' Chrasgaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall a'' Chrasgaidh')
);
UPDATE munros SET prominence_m = 658 WHERE height_m = 933 AND (
  name ILIKE '%Fionn Bheinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Fionn Bheinn')
);
UPDATE munros SET prominence_m = 109 WHERE height_m = 923 AND (
  name ILIKE '%Sgurr nan Each%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Each')
);
UPDATE munros SET prominence_m = 148.3 WHERE height_m = 924 AND (
  name ILIKE '%An Coileachan%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('An Coileachan')
);
UPDATE munros SET prominence_m = 810 WHERE height_m = 1084 AND (
  name ILIKE '%Beinn Dearg%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn Dearg')
);
UPDATE munros SET prominence_m = 164.8 WHERE height_m = 977.8 AND (
  name ILIKE '%Cona'' Mheall%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Cona'' Mheall')
);
UPDATE munros SET prominence_m = 126.6 WHERE height_m = 976.8 AND (
  name ILIKE '%Meall nan Ceapraichean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Meall nan Ceapraichean')
);
UPDATE munros SET prominence_m = 367 WHERE height_m = 953 AND (
  name ILIKE '%Am Faochagach%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Am Faochagach')
);
UPDATE munros SET prominence_m = 166 WHERE height_m = 927 AND (
  name ILIKE '%Eididh nan Clach Geala%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Eididh nan Clach Geala')
);
UPDATE munros SET prominence_m = 251 WHERE height_m = 926 AND (
  name ILIKE '%Seana Bhraigh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Seana Bhraigh')
);
UPDATE munros SET prominence_m = 691 WHERE height_m = 1046 AND (
  name ILIKE '%Ben Wyvis - Glas Leathad Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Wyvis - Glas Leathad Mor')
);
UPDATE munros SET prominence_m = 772 WHERE height_m = 927 AND (
  name ILIKE '%Ben Hope%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Hope')
);
UPDATE munros SET prominence_m = 819 WHERE height_m = 962.1 AND (
  name ILIKE '%Ben Klibreck - Meall nan Con%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben Klibreck - Meall nan Con')
);
UPDATE munros SET prominence_m = 836 WHERE height_m = 998.9 AND (
  name ILIKE '%Ben More Assynt%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben More Assynt')
);
UPDATE munros SET prominence_m = 102 WHERE height_m = 987.6 AND (
  name ILIKE '%Conival%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Conival')
);
UPDATE munros SET prominence_m = 992 WHERE height_m = 992 AND (
  name ILIKE '%Sgurr Alasdair%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Alasdair')
);
UPDATE munros SET prominence_m = 187.6 WHERE height_m = 985.8 AND (
  name ILIKE '%Sgurr Dearg - Inaccessible Pinnacle%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Dearg - Inaccessible Pinnacle')
);
UPDATE munros SET prominence_m = 123 WHERE height_m = 972.1 AND (
  name ILIKE '%Sgurr a'' Ghreadaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Ghreadaidh')
);
UPDATE munros SET prominence_m = 114 WHERE height_m = 965 AND (
  name ILIKE '%Sgurr na Banachdich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr na Banachdich')
);
UPDATE munros SET prominence_m = 205 WHERE height_m = 966.1 AND (
  name ILIKE '%Sgurr nan Gillean%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Gillean')
);
UPDATE munros SET prominence_m = 126 WHERE height_m = 958.8 AND (
  name ILIKE '%Bruach na Frithe%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Bruach na Frithe')
);
UPDATE munros SET prominence_m = 56 WHERE height_m = 948.1 AND (
  name ILIKE '%Sgurr Mhic Choinnich%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Mhic Choinnich')
);
UPDATE munros SET prominence_m = 89 WHERE height_m = 944.1 AND (
  name ILIKE '%Sgurr Dubh Mor%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr Dubh Mor')
);
UPDATE munros SET prominence_m = 49 WHERE height_m = 934 AND (
  name ILIKE '%Am Basteir%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Am Basteir')
);
UPDATE munros SET prominence_m = 859 WHERE height_m = 928.8 AND (
  name ILIKE '%Blabheinn%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Blabheinn')
);
UPDATE munros SET prominence_m = 130.3 WHERE height_m = 926.3 AND (
  name ILIKE '%Sgurr nan Eag%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr nan Eag')
);
UPDATE munros SET prominence_m = 72.9 WHERE height_m = 918 AND (
  name ILIKE '%Sgurr a'' Mhadaidh%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Sgurr a'' Mhadaidh')
);
UPDATE munros SET prominence_m = 966 WHERE height_m = 966 AND (
  name ILIKE '%Ben More%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Ben More')
);
UPDATE munros SET prominence_m = 136.9 WHERE height_m = 941.4 AND (
  name ILIKE '%Beinn a'' Chroin%' OR
  LOWER(REGEXP_REPLACE(name, '\[.*?\]', '')) = LOWER('Beinn a'' Chroin')
);

-- Verify the fix
SELECT
  COUNT(*) as total,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
