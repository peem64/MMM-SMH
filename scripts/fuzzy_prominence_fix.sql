/*
  # Fix Remaining Munro Prominence - Fuzzy Height Matching

  Updates remaining 77 Munros where heights don't match exactly
  Uses 1m tolerance for height matching
*/

UPDATE munros SET prominence_m = 646.9
WHERE ABS(height_m - 930.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Chonzie%');

UPDATE munros SET prominence_m = 834.3
WHERE ABS(height_m - 985.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Vorlich%');

UPDATE munros SET prominence_m = 252.1
WHERE ABS(height_m - 973) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stuc a'' Chroin%');

UPDATE munros SET prominence_m = 986
WHERE ABS(height_m - 1173.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben More%');

UPDATE munros SET prominence_m = 304.4
WHERE ABS(height_m - 1164.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Binnein%');

UPDATE munros SET prominence_m = 549
WHERE ABS(height_m - 1045.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Cruach Ardrain%');

UPDATE munros SET prominence_m = 474
WHERE ABS(height_m - 995.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Caisteal%');

UPDATE munros SET prominence_m = 820
WHERE ABS(height_m - 973.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Lomond%');

UPDATE munros SET prominence_m = 121.8
WHERE ABS(height_m - 945.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Tulaichea%');

UPDATE munros SET prominence_m = 313
WHERE ABS(height_m - 932.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Chabhair%');

UPDATE munros SET prominence_m = 876
WHERE ABS(height_m - 1131.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Lui%');

UPDATE munros SET prominence_m = 341.2
WHERE ABS(height_m - 1029.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Oss%');

UPDATE munros SET prominence_m = 713
WHERE ABS(height_m - 1012.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Ime%');

UPDATE munros SET prominence_m = 198.9
WHERE ABS(height_m - 978.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Dubhchrai%');

UPDATE munros SET prominence_m = 592
WHERE ABS(height_m - 948.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Bhuidhe%');

UPDATE munros SET prominence_m = 632
WHERE ABS(height_m - 942.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Vorlich%');

UPDATE munros SET prominence_m = 290
WHERE ABS(height_m - 926.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Narnain%');

UPDATE munros SET prominence_m = 139.9
WHERE ABS(height_m - 916.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Chlei%');

UPDATE munros SET prominence_m = 424
WHERE ABS(height_m - 915.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Vane%');

UPDATE munros SET prominence_m = 716
WHERE ABS(height_m - 1083.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Schiehallion%');

UPDATE munros SET prominence_m = 650
WHERE ABS(height_m - 1080.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Chrea%');

UPDATE munros SET prominence_m = 332
WHERE ABS(height_m - 1076) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Dorain%');

UPDATE munros SET prominence_m = 466.9
WHERE ABS(height_m - 1043) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Mairg%');

UPDATE munros SET prominence_m = 226
WHERE ABS(height_m - 1038.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Achaladai%');

UPDATE munros SET prominence_m = 188.5
WHERE ABS(height_m - 1029.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Gorm%');

UPDATE munros SET prominence_m = 247
WHERE ABS(height_m - 1004) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn an Dothai%');

UPDATE munros SET prominence_m = 136
WHERE ABS(height_m - 981) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall na Aighea%');

UPDATE munros SET prominence_m = 102.2
WHERE ABS(height_m - 967.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Garbh%');

UPDATE munros SET prominence_m = 481
WHERE ABS(height_m - 959.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stuc an Lochain%');

UPDATE munros SET prominence_m = 315
WHERE ABS(height_m - 952.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Mhanach%');

UPDATE munros SET prominence_m = 321.1
WHERE ABS(height_m - 932.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Buidhe%');

UPDATE munros SET prominence_m = 914
WHERE ABS(height_m - 1214.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Lawers%');

UPDATE munros SET prominence_m = 126
WHERE ABS(height_m - 1117.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Stuc%');

UPDATE munros SET prominence_m = 198
WHERE ABS(height_m - 1123.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Garbh%');

UPDATE munros SET prominence_m = 109.1
WHERE ABS(height_m - 1103.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Ghlas%');

UPDATE munros SET prominence_m = 579
WHERE ABS(height_m - 1077.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Sheasgarn%');

UPDATE munros SET prominence_m = 201.3
WHERE ABS(height_m - 1067.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Corranaic%');

UPDATE munros SET prominence_m = 394
WHERE ABS(height_m - 1046.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creag Mhor%');

UPDATE munros SET prominence_m = 494.4
WHERE ABS(height_m - 1043.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall nan Tarma%');

UPDATE munros SET prominence_m = 492
WHERE ABS(height_m - 1039.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Ghaordaid%');

UPDATE munros SET prominence_m = 450
WHERE ABS(height_m - 1024.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Challuim%');

UPDATE munros SET prominence_m = 167
WHERE ABS(height_m - 1001) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Greigh%');

UPDATE munros SET prominence_m = 554
WHERE ABS(height_m - 959.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Glas%');

UPDATE munros SET prominence_m = 150.5
WHERE ABS(height_m - 925.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall a'' Choir%');

UPDATE munros SET prominence_m = 311
WHERE ABS(height_m - 920.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgiath Chuil%');

UPDATE munros SET prominence_m = 623
WHERE ABS(height_m - 967.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach Eagach -%');

UPDATE munros SET prominence_m = 120.3
WHERE ABS(height_m - 952.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach Eagach -%');

UPDATE munros SET prominence_m = 844
WHERE ABS(height_m - 1149.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Bidean nam Bian%');

UPDATE munros SET prominence_m = 128
WHERE ABS(height_m - 1072) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Coire Sgre%');

UPDATE munros SET prominence_m = 729
WHERE ABS(height_m - 1024.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Bheit%');

UPDATE munros SET prominence_m = 532
WHERE ABS(height_m - 1021.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Buachaille Etiv%');

UPDATE munros SET prominence_m = 245.1
WHERE ABS(height_m - 1002.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Bheit%');

UPDATE munros SET prominence_m = 415
WHERE ABS(height_m - 994) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na h-Ulai%');

UPDATE munros SET prominence_m = 510
WHERE ABS(height_m - 959) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Fhionnlai%');

UPDATE munros SET prominence_m = 469
WHERE ABS(height_m - 958) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Buachaille Etiv%');

UPDATE munros SET prominence_m = 134.5
WHERE ABS(height_m - 953.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Buachaille Etiv%');

UPDATE munros SET prominence_m = 662
WHERE ABS(height_m - 937) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Sgulaird%');

UPDATE munros SET prominence_m = 177.7
WHERE ABS(height_m - 924.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Buachaille Etiv%');

UPDATE munros SET prominence_m = 880
WHERE ABS(height_m - 1127) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Cruachan%');

UPDATE munros SET prominence_m = 795
WHERE ABS(height_m - 1107.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall a'' Bhuir%');

UPDATE munros SET prominence_m = 169.4
WHERE ABS(height_m - 1099.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creise%');

UPDATE munros SET prominence_m = 392
WHERE ABS(height_m - 1089.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Ghabhar%');

UPDATE munros SET prominence_m = 448.8
WHERE ABS(height_m - 1079.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Starav%');

UPDATE munros SET prominence_m = 307
WHERE ABS(height_m - 1044.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Coir'' an %');

UPDATE munros SET prominence_m = 134.5
WHERE ABS(height_m - 999.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Daimh%');

UPDATE munros SET prominence_m = 231.3
WHERE ABS(height_m - 997.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Glas Bheinn Mho%');

UPDATE munros SET prominence_m = 425
WHERE ABS(height_m - 989) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Eunaich%');

UPDATE munros SET prominence_m = 252
WHERE ABS(height_m - 980) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Choch%');

UPDATE munros SET prominence_m = 343.4
WHERE ABS(height_m - 959) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn nan Aighe%');

UPDATE munros SET prominence_m = 279.4
WHERE ABS(height_m - 945) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob a'' Choire%');

UPDATE munros SET prominence_m = 174.5
WHERE ABS(height_m - 928.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall nan Eun%');

UPDATE munros SET prominence_m = 1344.5
WHERE ABS(height_m - 1344.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Nevis%');

UPDATE munros SET prominence_m = 404
WHERE ABS(height_m - 1234) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach Beag%');

UPDATE munros SET prominence_m = 133
WHERE ABS(height_m - 1220.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach Mor%');

UPDATE munros SET prominence_m = 162
WHERE ABS(height_m - 1220) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Mor Dearg%');

UPDATE munros SET prominence_m = 446
WHERE ABS(height_m - 1177) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Choire Cla%');

UPDATE munros SET prominence_m = 759
WHERE ABS(height_m - 1130) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Binnein Mor%');

UPDATE munros SET prominence_m = 74
WHERE ABS(height_m - 1116) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Coire an L%');

UPDATE munros SET prominence_m = 611
WHERE ABS(height_m - 1115) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Coire Easa%');

UPDATE munros SET prominence_m = 140
WHERE ABS(height_m - 1105) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob a'' Choire%');

UPDATE munros SET prominence_m = 316
WHERE ABS(height_m - 1099) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Mhaim%');

UPDATE munros SET prominence_m = 159
WHERE ABS(height_m - 1094) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Choinnich%');

UPDATE munros SET prominence_m = 96.8
WHERE ABS(height_m - 1054.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Na Gruagaichean%');

UPDATE munros SET prominence_m = 152.8
WHERE ABS(height_m - 1031.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Am Bodach%');

UPDATE munros SET prominence_m = 271
WHERE ABS(height_m - 1010) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Eilde Mor%');

UPDATE munros SET prominence_m = 237.1
WHERE ABS(height_m - 999.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Ban%');

UPDATE munros SET prominence_m = 151.7
WHERE ABS(height_m - 981.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Gearanach%');

UPDATE munros SET prominence_m = 124.5
WHERE ABS(height_m - 981.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Coire a'' %');

UPDATE munros SET prominence_m = 174
WHERE ABS(height_m - 977) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Ban%');

UPDATE munros SET prominence_m = 197
WHERE ABS(height_m - 943) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Binnein Beag%');

UPDATE munros SET prominence_m = 92.3
WHERE ABS(height_m - 939.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mullach nan Coi%');

UPDATE munros SET prominence_m = 783
WHERE ABS(height_m - 1148) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Alder%');

UPDATE munros SET prominence_m = 410
WHERE ABS(height_m - 1132) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Geal-charn%');

UPDATE munros SET prominence_m = 99
WHERE ABS(height_m - 1115.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach Beag%');

UPDATE munros SET prominence_m = 127
WHERE ABS(height_m - 1103.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Eibhinn%');

UPDATE munros SET prominence_m = 540
WHERE ABS(height_m - 1087.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Chlac%');

UPDATE munros SET prominence_m = 311
WHERE ABS(height_m - 1049.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Geal Charn%');

UPDATE munros SET prominence_m = 644
WHERE ABS(height_m - 1046) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Chno Dearg%');

UPDATE munros SET prominence_m = 158
WHERE ABS(height_m - 1034) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Dearg%');

UPDATE munros SET prominence_m = 186
WHERE ABS(height_m - 1019) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Bheoil%');

UPDATE munros SET prominence_m = 90
WHERE ABS(height_m - 979) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Coire Sgri%');

UPDATE munros SET prominence_m = 300
WHERE ABS(height_m - 954.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgor Gaibhre%');

UPDATE munros SET prominence_m = 221
WHERE ABS(height_m - 941) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Dearg%');

UPDATE munros SET prominence_m = 406
WHERE ABS(height_m - 935) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn na Lap%');

UPDATE munros SET prominence_m = 104.2
WHERE ABS(height_m - 924.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creag Pitridh%');

UPDATE munros SET prominence_m = 555
WHERE ABS(height_m - 1010.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Udlamain%');

UPDATE munros SET prominence_m = 182
WHERE ABS(height_m - 991.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgairneach Mhor%');

UPDATE munros SET prominence_m = 112
WHERE ABS(height_m - 973.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Mharconaich%');

UPDATE munros SET prominence_m = 466
WHERE ABS(height_m - 950.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Chuaich%');

UPDATE munros SET prominence_m = 328.1
WHERE ABS(height_m - 940.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn na Caim%');

UPDATE munros SET prominence_m = 109
WHERE ABS(height_m - 936) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Bhuidheanac%');

UPDATE munros SET prominence_m = 178
WHERE ABS(height_m - 917.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Geal-charn%');

UPDATE munros SET prominence_m = 473
WHERE ABS(height_m - 1008.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Dearg%');

UPDATE munros SET prominence_m = 319
WHERE ABS(height_m - 1006.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Sgarsoch%');

UPDATE munros SET prominence_m = 286
WHERE ABS(height_m - 994) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn an Fhidhle%');

UPDATE munros SET prominence_m = 317
WHERE ABS(height_m - 963.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn a'' Chlama%');

UPDATE munros SET prominence_m = 658
WHERE ABS(height_m - 1121.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Ghlo %');

UPDATE munros SET prominence_m = 222.4
WHERE ABS(height_m - 1070) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Ghlo %');

UPDATE munros SET prominence_m = 384
WHERE ABS(height_m - 1051) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Glas Tulaichean%');

UPDATE munros SET prominence_m = 247
WHERE ABS(height_m - 1045) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Iutharn M%');

UPDATE munros SET prominence_m = 258
WHERE ABS(height_m - 1029) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn an Righ%');

UPDATE munros SET prominence_m = 299
WHERE ABS(height_m - 976.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn a'' Gheoid%');

UPDATE munros SET prominence_m = 207.1
WHERE ABS(height_m - 975.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Ghlo %');

UPDATE munros SET prominence_m = 186.9
WHERE ABS(height_m - 945.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Bhac%');

UPDATE munros SET prominence_m = 187
WHERE ABS(height_m - 942.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Socach%');

UPDATE munros SET prominence_m = 127.1
WHERE ABS(height_m - 933) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%The Cairnwell%');

UPDATE munros SET prominence_m = 122.1
WHERE ABS(height_m - 915.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Aosda%');

UPDATE munros SET prominence_m = 671
WHERE ABS(height_m - 1155.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Lochnagar - Cac%');

UPDATE munros SET prominence_m = 72.9
WHERE ABS(height_m - 1109.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn a'' Choire%');

UPDATE munros SET prominence_m = 195.2
WHERE ABS(height_m - 1067.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Glas Maol%');

UPDATE munros SET prominence_m = 118.9
WHERE ABS(height_m - 1063.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Cairn of Claise%');

UPDATE munros SET prominence_m = 85
WHERE ABS(height_m - 1047) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn an t-Sagai%');

UPDATE munros SET prominence_m = 61.6
WHERE ABS(height_m - 1018.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn an Tuirc%');

UPDATE munros SET prominence_m = 76
WHERE ABS(height_m - 1011.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Cairn Bannoch%');

UPDATE munros SET prominence_m = 63.9
WHERE ABS(height_m - 997.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Broad Cairn%');

UPDATE munros SET prominence_m = 70.7
WHERE ABS(height_m - 988.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creag Leacach%');

UPDATE munros SET prominence_m = 73.7
WHERE ABS(height_m - 957.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Tolmount%');

UPDATE munros SET prominence_m = 72.6
WHERE ABS(height_m - 957.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Tom Buidhe%');

UPDATE munros SET prominence_m = 136.9
WHERE ABS(height_m - 947.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Driesh%');

UPDATE munros SET prominence_m = 312
WHERE ABS(height_m - 939.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mount Keen%');

UPDATE munros SET prominence_m = 112
WHERE ABS(height_m - 928.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mayar%');

UPDATE munros SET prominence_m = 950
WHERE ABS(height_m - 1309.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Macdui%');

UPDATE munros SET prominence_m = 461
WHERE ABS(height_m - 1296) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Braeriach%');

UPDATE munros SET prominence_m = 166
WHERE ABS(height_m - 1291) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Cairn Toul%');

UPDATE munros SET prominence_m = 118
WHERE ABS(height_m - 1258) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgor an Lochain%');

UPDATE munros SET prominence_m = 145.8
WHERE ABS(height_m - 1244.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Cairn Gorm%');

UPDATE munros SET prominence_m = 456.2
WHERE ABS(height_m - 1196) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Bhuir%');

UPDATE munros SET prominence_m = 254
WHERE ABS(height_m - 1182.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Mheadhoin%');

UPDATE munros SET prominence_m = 198
WHERE ABS(height_m - 1172) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Avon - Leab%');

UPDATE munros SET prominence_m = 258
WHERE ABS(height_m - 1157) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Bhrotain%');

UPDATE munros SET prominence_m = 142
WHERE ABS(height_m - 1155.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Derry Cairngorm%');

UPDATE munros SET prominence_m = 242.8
WHERE ABS(height_m - 1116) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgor Gaoith%');

UPDATE munros SET prominence_m = 138.8
WHERE ABS(height_m - 1113.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Monadh Mor%');

UPDATE munros SET prominence_m = 283
WHERE ABS(height_m - 1090) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Bynack More%');

UPDATE munros SET prominence_m = 246.3
WHERE ABS(height_m - 1083.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Chaor%');

UPDATE munros SET prominence_m = 231
WHERE ABS(height_m - 1037) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn a'' Mhaim%');

UPDATE munros SET prominence_m = 104.9
WHERE ABS(height_m - 1019) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mullach Clach a%');

UPDATE munros SET prominence_m = 90.6
WHERE ABS(height_m - 1006.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%The Devil''s Po%');

UPDATE munros SET prominence_m = 80.9
WHERE ABS(height_m - 930.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Bhreac%');

UPDATE munros SET prominence_m = 591
WHERE ABS(height_m - 945.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Dearg%');

UPDATE munros SET prominence_m = 108.3
WHERE ABS(height_m - 929.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Chailleach%');

UPDATE munros SET prominence_m = 101.1
WHERE ABS(height_m - 926.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Geal Charn%');

UPDATE munros SET prominence_m = 71.6
WHERE ABS(height_m - 920.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Sgulain%');

UPDATE munros SET prominence_m = 868
WHERE ABS(height_m - 1128.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creag Meagaidh%');

UPDATE munros SET prominence_m = 107
WHERE ABS(height_m - 1052.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Stob Poite Coir%');

UPDATE munros SET prominence_m = 227
WHERE ABS(height_m - 1049.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Chaor%');

UPDATE munros SET prominence_m = 86.9
WHERE ABS(height_m - 1006.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Liath%');

UPDATE munros SET prominence_m = 301.5
WHERE ABS(height_m - 914.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Teallach%');

UPDATE munros SET prominence_m = 767.7
WHERE ABS(height_m - 1035.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Gleouraich%');

UPDATE munros SET prominence_m = 708
WHERE ABS(height_m - 1026.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Mhaor%');

UPDATE munros SET prominence_m = 493
WHERE ABS(height_m - 1019.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach air Chri%');

UPDATE munros SET prominence_m = 189
WHERE ABS(height_m - 1010) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr an Doire %');

UPDATE munros SET prominence_m = 334
WHERE ABS(height_m - 1011.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%The Saddle%');

UPDATE munros SET prominence_m = 123
WHERE ABS(height_m - 1004) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr an Lochai%');

UPDATE munros SET prominence_m = 259.5
WHERE ABS(height_m - 995.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Spidean Mialach%');

UPDATE munros SET prominence_m = 101.3
WHERE ABS(height_m - 985.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Druim Shionnach%');

UPDATE munros SET prominence_m = 137.6
WHERE ABS(height_m - 980.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Maol Chinn-dear%');

UPDATE munros SET prominence_m = 500
WHERE ABS(height_m - 974) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Sgritheal%');

UPDATE munros SET prominence_m = 79.6
WHERE ABS(height_m - 946.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creag a'' Mhaim%');

UPDATE munros SET prominence_m = 247
WHERE ABS(height_m - 946) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Sgine%');

UPDATE munros SET prominence_m = 196
WHERE ABS(height_m - 917.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Creag nan Damh%');

UPDATE munros SET prominence_m = 839
WHERE ABS(height_m - 1040.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Ciche%');

UPDATE munros SET prominence_m = 795
WHERE ABS(height_m - 1020) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ladhar Bheinn%');

UPDATE munros SET prominence_m = 169.5
WHERE ABS(height_m - 1012.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Garbh Chioch Mh%');

UPDATE munros SET prominence_m = 341
WHERE ABS(height_m - 1003) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Mor%');

UPDATE munros SET prominence_m = 221.7
WHERE ABS(height_m - 953.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Coire%');

UPDATE munros SET prominence_m = 497
WHERE ABS(height_m - 945.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Buidhe%');

UPDATE munros SET prominence_m = 256.6
WHERE ABS(height_m - 938.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Luinne Bheinn%');

UPDATE munros SET prominence_m = 552
WHERE ABS(height_m - 918.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Gairich%');

UPDATE munros SET prominence_m = 621
WHERE ABS(height_m - 936.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sron a'' Choire%');

UPDATE munros SET prominence_m = 305.5
WHERE ABS(height_m - 916.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall na Teanga%');

UPDATE munros SET prominence_m = 842
WHERE ABS(height_m - 987) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Gulvain%');

UPDATE munros SET prominence_m = 614
WHERE ABS(height_m - 963) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Thuilm%');

UPDATE munros SET prominence_m = 231.8
WHERE ABS(height_m - 956.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Coire%');

UPDATE munros SET prominence_m = 1147
WHERE ABS(height_m - 1182.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Eighe%');

UPDATE munros SET prominence_m = 132.4
WHERE ABS(height_m - 1179.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mam Sodhail%');

UPDATE munros SET prominence_m = 433
WHERE ABS(height_m - 1149.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Ceath%');

UPDATE munros SET prominence_m = 149.8
WHERE ABS(height_m - 1112.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Tom a'' Choinni%');

UPDATE munros SET prominence_m = 665
WHERE ABS(height_m - 1068.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Fhuaran%');

UPDATE munros SET prominence_m = 181.4
WHERE ABS(height_m - 1053.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Toll Creagach%');

UPDATE munros SET prominence_m = 311
WHERE ABS(height_m - 1036) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Bheal%');

UPDATE munros SET prominence_m = 647
WHERE ABS(height_m - 1031.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Fhada%');

UPDATE munros SET prominence_m = 178
WHERE ABS(height_m - 1027) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Ciste %');

UPDATE munros SET prominence_m = 173
WHERE ABS(height_m - 1004.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Fhionnlai%');

UPDATE munros SET prominence_m = 134
WHERE ABS(height_m - 1002) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Carnac%');

UPDATE munros SET prominence_m = 174
WHERE ABS(height_m - 1001) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Aonach Meadhoin%');

UPDATE munros SET prominence_m = 144
WHERE ABS(height_m - 982) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mullach na Dhei%');

UPDATE munros SET prominence_m = 390.5
WHERE ABS(height_m - 981.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ciste Dhubh%');

UPDATE munros SET prominence_m = 91
WHERE ABS(height_m - 956) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Saileag%');

UPDATE munros SET prominence_m = 123.8
WHERE ABS(height_m - 919.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Socach%');

UPDATE munros SET prominence_m = 407
WHERE ABS(height_m - 918) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Ghlas-bhein%');

UPDATE munros SET prominence_m = 786
WHERE ABS(height_m - 1120) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Chraileag%');

UPDATE munros SET prominence_m = 382
WHERE ABS(height_m - 1109) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Conbh%');

UPDATE munros SET prominence_m = 151.3
WHERE ABS(height_m - 1100.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mullach Fraoch-%');

UPDATE munros SET prominence_m = 87
WHERE ABS(height_m - 999.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sail Chaorainn%');

UPDATE munros SET prominence_m = 62.7
WHERE ABS(height_m - 956.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn Ghluasaid%');

UPDATE munros SET prominence_m = 819
WHERE ABS(height_m - 1083.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Choir%');

UPDATE munros SET prominence_m = 568
WHERE ABS(height_m - 1053) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Chaor%');

UPDATE munros SET prominence_m = 148.1
WHERE ABS(height_m - 1049.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Fhuar-thu%');

UPDATE munros SET prominence_m = 10.5
WHERE ABS(height_m - 1004.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Maoile Lunndaid%');

UPDATE munros SET prominence_m = 133
WHERE ABS(height_m - 999.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Choinnich%');

UPDATE munros SET prominence_m = 226
WHERE ABS(height_m - 993) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Ruaidh%');

UPDATE munros SET prominence_m = 137
WHERE ABS(height_m - 992) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn nan Gobhar%');

UPDATE munros SET prominence_m = 443
WHERE ABS(height_m - 987.5) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Lurg Mhor%');

UPDATE munros SET prominence_m = 208.2
WHERE ABS(height_m - 945) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Bidein a'' Choi%');

UPDATE munros SET prominence_m = 592
WHERE ABS(height_m - 925.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Moruisg%');

UPDATE munros SET prominence_m = 841
WHERE ABS(height_m - 1151.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Lapaic%');

UPDATE munros SET prominence_m = 302
WHERE ABS(height_m - 1129) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Riabhachan%');

UPDATE munros SET prominence_m = 207
WHERE ABS(height_m - 1069) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Socach%');

UPDATE munros SET prominence_m = 197.5
WHERE ABS(height_m - 992.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Carn nan Gobhar%');

UPDATE munros SET prominence_m = 957
WHERE ABS(height_m - 1054.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Liathach - Spid%');

UPDATE munros SET prominence_m = 152.1
WHERE ABS(height_m - 1023.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Liathach - Mull%');

UPDATE munros SET prominence_m = 632
WHERE ABS(height_m - 1010) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Eighe - R%');

UPDATE munros SET prominence_m = 172
WHERE ABS(height_m - 993) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Eighe - S%');

UPDATE munros SET prominence_m = 601
WHERE ABS(height_m - 986) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Alligin -%');

UPDATE munros SET prominence_m = 155
WHERE ABS(height_m - 922) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Alligin -%');

UPDATE munros SET prominence_m = 723
WHERE ABS(height_m - 960.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgorr Ruadh%');

UPDATE munros SET prominence_m = 514
WHERE ABS(height_m - 933) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Maol Chean-dear%');

UPDATE munros SET prominence_m = 271
WHERE ABS(height_m - 926) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Liath Mho%');

UPDATE munros SET prominence_m = 757
WHERE ABS(height_m - 1062.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Teallach - B%');

UPDATE munros SET prominence_m = 141.7
WHERE ABS(height_m - 1058.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Teallach - S%');

UPDATE munros SET prominence_m = 591
WHERE ABS(height_m - 1015.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Mullach Coire M%');

UPDATE munros SET prominence_m = 165
WHERE ABS(height_m - 989) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Ban%');

UPDATE munros SET prominence_m = 626
WHERE ABS(height_m - 981) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Slioch%');

UPDATE munros SET prominence_m = 443
WHERE ABS(height_m - 965.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Mhaighdean%');

UPDATE munros SET prominence_m = 207.1
WHERE ABS(height_m - 933.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Tarsuinn%');

UPDATE munros SET prominence_m = 169.8
WHERE ABS(height_m - 918.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ruadh Stac Mor%');

UPDATE munros SET prominence_m = 914
WHERE ABS(height_m - 1108.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Mor%');

UPDATE munros SET prominence_m = 229
WHERE ABS(height_m - 1093) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Clach%');

UPDATE munros SET prominence_m = 450.8
WHERE ABS(height_m - 999.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Breac%');

UPDATE munros SET prominence_m = 182.9
WHERE ABS(height_m - 998.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%A'' Chailleach%');

UPDATE munros SET prominence_m = 107
WHERE ABS(height_m - 954.2) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Liath Mho%');

UPDATE munros SET prominence_m = 112.3
WHERE ABS(height_m - 949.7) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall Gorm%');

UPDATE munros SET prominence_m = 115
WHERE ABS(height_m - 934) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall a'' Chras%');

UPDATE munros SET prominence_m = 658
WHERE ABS(height_m - 933) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Fionn Bheinn%');

UPDATE munros SET prominence_m = 109
WHERE ABS(height_m - 923) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Each%');

UPDATE munros SET prominence_m = 148.3
WHERE ABS(height_m - 924) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%An Coileachan%');

UPDATE munros SET prominence_m = 810
WHERE ABS(height_m - 1084) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn Dearg%');

UPDATE munros SET prominence_m = 164.8
WHERE ABS(height_m - 977.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Cona'' Mheall%');

UPDATE munros SET prominence_m = 126.6
WHERE ABS(height_m - 976.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Meall nan Ceapr%');

UPDATE munros SET prominence_m = 367
WHERE ABS(height_m - 953) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Am Faochagach%');

UPDATE munros SET prominence_m = 166
WHERE ABS(height_m - 927) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Eididh nan Clac%');

UPDATE munros SET prominence_m = 251
WHERE ABS(height_m - 926) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Seana Bhraigh%');

UPDATE munros SET prominence_m = 691
WHERE ABS(height_m - 1046) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Wyvis - Gla%');

UPDATE munros SET prominence_m = 772
WHERE ABS(height_m - 927) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Hope%');

UPDATE munros SET prominence_m = 819
WHERE ABS(height_m - 962.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben Klibreck - %');

UPDATE munros SET prominence_m = 836
WHERE ABS(height_m - 998.9) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben More Assynt%');

UPDATE munros SET prominence_m = 102
WHERE ABS(height_m - 987.6) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Conival%');

UPDATE munros SET prominence_m = 992
WHERE ABS(height_m - 992) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Alasdair%');

UPDATE munros SET prominence_m = 187.6
WHERE ABS(height_m - 985.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Dearg - I%');

UPDATE munros SET prominence_m = 123
WHERE ABS(height_m - 972.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Ghrea%');

UPDATE munros SET prominence_m = 114
WHERE ABS(height_m - 965) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr na Banach%');

UPDATE munros SET prominence_m = 205
WHERE ABS(height_m - 966.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Gille%');

UPDATE munros SET prominence_m = 126
WHERE ABS(height_m - 958.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Bruach na Frith%');

UPDATE munros SET prominence_m = 56
WHERE ABS(height_m - 948.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Mhic Choi%');

UPDATE munros SET prominence_m = 89
WHERE ABS(height_m - 944.1) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr Dubh Mor%');

UPDATE munros SET prominence_m = 49
WHERE ABS(height_m - 934) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Am Basteir%');

UPDATE munros SET prominence_m = 859
WHERE ABS(height_m - 928.8) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Blabheinn%');

UPDATE munros SET prominence_m = 130.3
WHERE ABS(height_m - 926.3) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr nan Eag%');

UPDATE munros SET prominence_m = 72.9
WHERE ABS(height_m - 918) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Sgurr a'' Mhada%');

UPDATE munros SET prominence_m = 966
WHERE ABS(height_m - 966) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Ben More%');

UPDATE munros SET prominence_m = 136.9
WHERE ABS(height_m - 941.4) < 1
  AND prominence_m = height_m
  AND (name ILIKE '%Beinn a'' Chroi%');

-- Final verification
SELECT
  COUNT(*) as total_munros,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_incorrect,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct,
  ROUND(100.0 * SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) / COUNT(*), 1) as percent_correct
FROM munros;
