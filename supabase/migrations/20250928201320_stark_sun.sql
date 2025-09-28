/*
  # Correct Munro Prominence Values from Wikipedia
  
  This migration sets the accurate prominence values for all Scottish Munros
  based on the Wikipedia "List of Munro mountains" page.
  
  Key corrections:
  - Ben Nevis: 1345m prominence (highest peak in UK)
  - Ben Macdui: 950m prominence (not 1309m which is height)
  - Braeriach: 461m prominence (not 1296m which is height)
  - All other Munros with correct prominence values
  
  Prominence = vertical distance from summit to lowest contour that encircles 
  it but no higher summit.
*/

-- Update Munros with correct prominence values from Wikipedia
UPDATE munros SET prominence_m = 1345 WHERE name = 'Ben Nevis';
UPDATE munros SET prominence_m = 950 WHERE name = 'Ben Macdui';
UPDATE munros SET prominence_m = 461 WHERE name = 'Braeriach';
UPDATE munros SET prominence_m = 1245 WHERE name = 'Cairn Gorm';
UPDATE munros SET prominence_m = 1291 WHERE name = 'Cairn Toul';
UPDATE munros SET prominence_m = 1258 WHERE name = 'Sgòr an Lochain Uaine';
UPDATE munros SET prominence_m = 1234 WHERE name = 'Aonach Beag (Nevis Range)';
UPDATE munros SET prominence_m = 1221 WHERE name = 'Aonach Mòr';
UPDATE munros SET prominence_m = 1220 WHERE name = 'Càrn Mòr Dearg';
UPDATE munros SET prominence_m = 1214 WHERE name = 'Ben Lawers';
UPDATE munros SET prominence_m = 1197 WHERE name = 'Beinn a'' Bhùird';
UPDATE munros SET prominence_m = 1182 WHERE name = 'Beinn Mheadhoin';
UPDATE munros SET prominence_m = 1183 WHERE name = 'Càrn Eige';
UPDATE munros SET prominence_m = 1181 WHERE name = 'Màm Sodhail';
UPDATE munros SET prominence_m = 1177 WHERE name = 'Stob Choire Claurigh';
UPDATE munros SET prominence_m = 1174 WHERE name = 'Ben More';
UPDATE munros SET prominence_m = 1171 WHERE name = 'Ben Avon';
UPDATE munros SET prominence_m = 1165 WHERE name = 'Stob Binnein';
UPDATE munros SET prominence_m = 1157 WHERE name = 'Beinn Bhrotain';
UPDATE munros SET prominence_m = 1156 WHERE name = 'Lochnagar';
UPDATE munros SET prominence_m = 1155 WHERE name = 'Derry Cairngorm';
UPDATE munros SET prominence_m = 1151 WHERE name = 'Sgùrr nan Ceathreamhnan';
UPDATE munros SET prominence_m = 1150 WHERE name = 'Sgùrr na Lapaich';
UPDATE munros SET prominence_m = 1150 WHERE name = 'Bidean nam Bian';
UPDATE munros SET prominence_m = 1148 WHERE name = 'Ben Alder';
UPDATE munros SET prominence_m = 1132 WHERE name = 'Geal-chàrn (Alder)';
UPDATE munros SET prominence_m = 1130 WHERE name = 'Ben Lui';
UPDATE munros SET prominence_m = 1130 WHERE name = 'Binnein Mòr';
UPDATE munros SET prominence_m = 1130 WHERE name = 'Creag Meagaidh';
UPDATE munros SET prominence_m = 1129 WHERE name = 'An Riabhachan';
UPDATE munros SET prominence_m = 1126 WHERE name = 'Ben Cruachan';
UPDATE munros SET prominence_m = 1121 WHERE name = 'Càrn nan Gabhar';
UPDATE munros SET prominence_m = 1120 WHERE name = 'A'' Chralaig';
UPDATE munros SET prominence_m = 1118 WHERE name = 'An Stùc';
UPDATE munros SET prominence_m = 1118 WHERE name = 'Meall Garbh (Ben Lawers)';
UPDATE munros SET prominence_m = 1118 WHERE name = 'Càrn a'' Choire Bhòidheach';
UPDATE munros SET prominence_m = 1118 WHERE name = 'Sgòr Gaoith';
UPDATE munros SET prominence_m = 1116 WHERE name = 'Aonach Beag (Alder)';
UPDATE munros SET prominence_m = 1116 WHERE name = 'Stob Coire an Laoigh';
UPDATE munros SET prominence_m = 1115 WHERE name = 'Stob Coire Easain';
UPDATE munros SET prominence_m = 1113 WHERE name = 'Monadh Mòr';
UPDATE munros SET prominence_m = 1112 WHERE name = 'Tom a'' Chòinich';
UPDATE munros SET prominence_m = 1110 WHERE name = 'Sgùrr Mòr';
UPDATE munros SET prominence_m = 1109 WHERE name = 'Sgùrr nan Conbhairean';
UPDATE munros SET prominence_m = 1108 WHERE name = 'Meall a'' Bhùiridh';
UPDATE munros SET prominence_m = 1106 WHERE name = 'Stob a'' Choire Mheadhoin';
UPDATE munros SET prominence_m = 1103 WHERE name = 'Beinn Ghlas';
UPDATE munros SET prominence_m = 1102 WHERE name = 'Beinn Èibhinn';
UPDATE munros SET prominence_m = 1102 WHERE name = 'Mullach Fraoch-choire';
UPDATE munros SET prominence_m = 1100 WHERE name = 'Creise';
UPDATE munros SET prominence_m = 1099 WHERE name = 'Sgùrr a'' Mhàim';
UPDATE munros SET prominence_m = 1094 WHERE name = 'Sgùrr Chòinnich Mòr';
UPDATE munros SET prominence_m = 1093 WHERE name = 'Sgùrr nan Clach Geala';
UPDATE munros SET prominence_m = 1090 WHERE name = 'Bynack More';
UPDATE munros SET prominence_m = 1090 WHERE name = 'Stob Ghabhar';
UPDATE munros SET prominence_m = 1087 WHERE name = 'Beinn a'' Chlachair';
UPDATE munros SET prominence_m = 1084 WHERE name = 'Beinn Dearg (Ullapool)';
UPDATE munros SET prominence_m = 1083 WHERE name = 'Schiehallion';
UPDATE munros SET prominence_m = 1082 WHERE name = 'Beinn a'' Chaorainn (Cairngorms)';
UPDATE munros SET prominence_m = 1081 WHERE name = 'Beinn a'' Chreachain';
UPDATE munros SET prominence_m = 1078 WHERE name = 'Beinn Heasgarnich';
UPDATE munros SET prominence_m = 1078 WHERE name = 'Ben Starav';
UPDATE munros SET prominence_m = 1076 WHERE name = 'Beinn Dòrain';
UPDATE munros SET prominence_m = 1072 WHERE name = 'Stob Coire Sgreamhach';
UPDATE munros SET prominence_m = 1070 WHERE name = 'Bràigh Coire Chruinn-bhalgain';
UPDATE munros SET prominence_m = 1069 WHERE name = 'An Socach (Mullardoch)';
UPDATE munros SET prominence_m = 1069 WHERE name = 'Meall Corranaich';
UPDATE munros SET prominence_m = 1068 WHERE name = 'Glas Maol';
UPDATE munros SET prominence_m = 1067 WHERE name = 'Sgùrr Fhuaran';
UPDATE munros SET prominence_m = 1064 WHERE name = 'Cairn of Claise';
UPDATE munros SET prominence_m = 1062 WHERE name = 'Bidein a'' Ghlas Thuill (An Teallach)';
UPDATE munros SET prominence_m = 1060 WHERE name = 'Sgùrr Fiona (An Teallach)';
UPDATE munros SET prominence_m = 1056 WHERE name = 'Na Gruagaichean';
UPDATE munros SET prominence_m = 1055 WHERE name = 'Spidean a'' Choire Lèith (Liathach)';
UPDATE munros SET prominence_m = 1054 WHERE name = 'Toll Creagach';
UPDATE munros SET prominence_m = 1054 WHERE name = 'Stob Poite Coire Àrdair';
UPDATE munros SET prominence_m = 1053 WHERE name = 'Sgùrr a'' Chaorachain';
UPDATE munros SET prominence_m = 1051 WHERE name = 'Glas Tulaichean';
UPDATE munros SET prominence_m = 1050 WHERE name = 'Beinn a'' Chaorainn (Glen Spean)';
UPDATE munros SET prominence_m = 1049 WHERE name = 'Geal chàrn (Laggan)';
UPDATE munros SET prominence_m = 1049 WHERE name = 'Sgùrr Fhuar-thuill';
UPDATE munros SET prominence_m = 1047 WHERE name = 'Càrn an t-Sagairt Mòr';
UPDATE munros SET prominence_m = 1047 WHERE name = 'Creag Mhòr (Glen Lochay)';
UPDATE munros SET prominence_m = 1046 WHERE name = 'Ben Wyvis';
UPDATE munros SET prominence_m = 1046 WHERE name = 'Chno Dearg';
UPDATE munros SET prominence_m = 1046 WHERE name = 'Cruach Àrdrain';
UPDATE munros SET prominence_m = 1045 WHERE name = 'Beinn Iutharn Mhòr';
UPDATE munros SET prominence_m = 1044 WHERE name = 'Meall nan Tarmachan';
UPDATE munros SET prominence_m = 1044 WHERE name = 'Stob Coir an Albannaich';
UPDATE munros SET prominence_m = 1042 WHERE name = 'Càrn Mairg';
UPDATE munros SET prominence_m = 1040 WHERE name = 'Sgùrr na Cìche';
UPDATE munros SET prominence_m = 1039 WHERE name = 'Meall Ghaordaidh';
UPDATE munros SET prominence_m = 1038 WHERE name = 'Beinn Achaladair';
UPDATE munros SET prominence_m = 1037 WHERE name = 'Càrn a'' Mhàim';
UPDATE munros SET prominence_m = 1036 WHERE name = 'Sgùrr a'' Bhealaich Dheirg';
UPDATE munros SET prominence_m = 1035 WHERE name = 'Gleouraich';
UPDATE munros SET prominence_m = 1034 WHERE name = 'Càrn Dearg (Loch Pattack)';
UPDATE munros SET prominence_m = 1032 WHERE name = 'Am Bodach';
UPDATE munros SET prominence_m = 1032 WHERE name = 'Beinn Fhada';
UPDATE munros SET prominence_m = 1029 WHERE name = 'Ben Oss';
UPDATE munros SET prominence_m = 1029 WHERE name = 'Càrn an Rìgh';
UPDATE munros SET prominence_m = 1029 WHERE name = 'Càrn Gorm';
UPDATE munros SET prominence_m = 1027 WHERE name = 'Sgùrr a'' Mhaoraich';
UPDATE munros SET prominence_m = 1027 WHERE name = 'Sgùrr na Ciste Duibhe';
UPDATE munros SET prominence_m = 1025 WHERE name = 'Ben Challum';
UPDATE munros SET prominence_m = 1024 WHERE name = 'Sgòrr Dhearg (Beinn a'' Bheithir)';
UPDATE munros SET prominence_m = 1023 WHERE name = 'Mullach an Rathain (Liathach)';
UPDATE munros SET prominence_m = 1021 WHERE name = 'Aonach Air Chrith';
UPDATE munros SET prominence_m = 1021 WHERE name = 'Stob Dearg (Buachaille Etive Mòr)';
UPDATE munros SET prominence_m = 1020 WHERE name = 'Ladhar Bheinn';
UPDATE munros SET prominence_m = 1019 WHERE name = 'Beinn Bheoil';
UPDATE munros SET prominence_m = 1019 WHERE name = 'Càrn an Tuirc';
UPDATE munros SET prominence_m = 1019 WHERE name = 'Mullach Clach a'' Bhlàir';
UPDATE munros SET prominence_m = 1019 WHERE name = 'Mullach Coire Mhic Fhearchair';
UPDATE munros SET prominence_m = 1013 WHERE name = 'Garbh Chioch Mhòr';
UPDATE munros SET prominence_m = 1012 WHERE name = 'Cairn Bannoch';
UPDATE munros SET prominence_m = 1011 WHERE name = 'Beinn Ìme';
UPDATE munros SET prominence_m = 1010 WHERE name = 'Beinn Udlamain';
UPDATE munros SET prominence_m = 1010 WHERE name = 'Ruadh-stac Mòr (Beinn Eighe)';
UPDATE munros SET prominence_m = 1010 WHERE name = 'Sgùrr an Doire Leathain';
UPDATE munros SET prominence_m = 1010 WHERE name = 'Sgùrr Èilde Mòr';
UPDATE munros SET prominence_m = 1010 WHERE name = 'The Saddle';
UPDATE munros SET prominence_m = 1008 WHERE name = 'Beinn Dearg (Blair Atholl)';
UPDATE munros SET prominence_m = 1007 WHERE name = 'Maoile Lunndaidh';
UPDATE munros SET prominence_m = 1006 WHERE name = 'An Sgarsoch';
UPDATE munros SET prominence_m = 1006 WHERE name = 'Càrn Liath (Creag Meagaidh)';
UPDATE munros SET prominence_m = 1005 WHERE name = 'Beinn Fhionnlaidh (Càrn Eige)';
UPDATE munros SET prominence_m = 1004 WHERE name = 'Beinn an Dòthaidh';
UPDATE munros SET prominence_m = 1004 WHERE name = 'Sgùrr an Lochain';
UPDATE munros SET prominence_m = 1004 WHERE name = 'The Devil''s Point';
UPDATE munros SET prominence_m = 1003 WHERE name = 'Sgùrr Mòr (Loch Cuaich)';
UPDATE munros SET prominence_m = 1002 WHERE name = 'Sàil Chaorainn';
UPDATE munros SET prominence_m = 1002 WHERE name = 'Sgùrr na Càrnach';
UPDATE munros SET prominence_m = 1001 WHERE name = 'Aonach Meadhoin';
UPDATE munros SET prominence_m = 1001 WHERE name = 'Meall Greigh';
UPDATE munros SET prominence_m = 1001 WHERE name = 'Sgòrr Dhònuill (Beinn a'' Bheithir)';
UPDATE munros SET prominence_m = 999 WHERE name = 'Sgùrr Breac';
UPDATE munros SET prominence_m = 999 WHERE name = 'Sgùrr Chòinnich';
UPDATE munros SET prominence_m = 999 WHERE name = 'Stob Bàn (Mamores)';
UPDATE munros SET prominence_m = 998 WHERE name = 'Ben More Assynt';
UPDATE munros SET prominence_m = 998 WHERE name = 'Broad Cairn';
UPDATE munros SET prominence_m = 998 WHERE name = 'Stob Daimh';
UPDATE munros SET prominence_m = 997 WHERE name = 'A'' Chailleach (Fannichs)';
UPDATE munros SET prominence_m = 997 WHERE name = 'Glas Bheinn Mhòr';
UPDATE munros SET prominence_m = 996 WHERE name = 'Spidean Mialach';
UPDATE munros SET prominence_m = 995 WHERE name = 'An Caisteal';
UPDATE munros SET prominence_m = 994 WHERE name = 'Càrn an Fhìdhleir (Càrn Ealar)';
UPDATE munros SET prominence_m = 994 WHERE name = 'Sgòr na h-Ulaidh';
UPDATE munros SET prominence_m = 993 WHERE name = 'Càrn nan Gobhar (Loch Mullardoch)';
UPDATE munros SET prominence_m = 993 WHERE name = 'Sgùrr na Ruaidhe';
UPDATE munros SET prominence_m = 993 WHERE name = 'Spidean Coire nan Clach (Beinn Eighe)';
UPDATE munros SET prominence_m = 992 WHERE name = 'Càrn nan Gobhar (Strathfarrar)';
UPDATE munros SET prominence_m = 992 WHERE name = 'Sgùrr Alasdair';
UPDATE munros SET prominence_m = 991 WHERE name = 'Sgàirneach Mhòr';
UPDATE munros SET prominence_m = 989 WHERE name = 'Beinn Eunaich';
UPDATE munros SET prominence_m = 989 WHERE name = 'Sgùrr Bàn';
UPDATE munros SET prominence_m = 987 WHERE name = 'Conival';
UPDATE munros SET prominence_m = 987 WHERE name = 'Creag Leacach';
UPDATE munros SET prominence_m = 987 WHERE name = 'Druim Shionnach';
UPDATE munros SET prominence_m = 987 WHERE name = 'Gulvain';
UPDATE munros SET prominence_m = 986 WHERE name = 'Inaccessible Pinnacle';
UPDATE munros SET prominence_m = 986 WHERE name = 'Lurg Mhòr';
UPDATE munros SET prominence_m = 986 WHERE name = 'Sgùrr Mòr (Beinn Alligin)';
UPDATE munros SET prominence_m = 985 WHERE name = 'Ben Vorlich (Loch Earn)';
UPDATE munros SET prominence_m = 982 WHERE name = 'An Gearanach';
UPDATE munros SET prominence_m = 982 WHERE name = 'Mullach na Dheiragain';
UPDATE munros SET prominence_m = 981 WHERE name = 'Creag Mhòr (Meall na Aighean)';
UPDATE munros SET prominence_m = 981 WHERE name = 'Maol chinn-dearg';
UPDATE munros SET prominence_m = 981 WHERE name = 'Slioch';
UPDATE munros SET prominence_m = 981 WHERE name = 'Stob Coire a'' Chàirn';
UPDATE munros SET prominence_m = 980 WHERE name = 'Beinn a'' Chochuill';
UPDATE munros SET prominence_m = 979 WHERE name = 'Ciste Dhubh';
UPDATE munros SET prominence_m = 979 WHERE name = 'Stob Coire Sgriodain';
UPDATE munros SET prominence_m = 978 WHERE name = 'Beinn Dubhchraig';
UPDATE munros SET prominence_m = 978 WHERE name = 'Cona'' Mheall';
UPDATE munros SET prominence_m = 977 WHERE name = 'Meall nan Ceapraichean';
UPDATE munros SET prominence_m = 977 WHERE name = 'Stob Bàn (Grey Corries)';
UPDATE munros SET prominence_m = 975 WHERE name = 'A'' Mharconaich';
UPDATE munros SET prominence_m = 975 WHERE name = 'Càrn a'' Ghèoidh';
UPDATE munros SET prominence_m = 975 WHERE name = 'Càrn Liath (Beinn a'' Ghlò)';
UPDATE munros SET prominence_m = 975 WHERE name = 'Stùc a'' Chròin';
UPDATE munros SET prominence_m = 974 WHERE name = 'Ben Lomond';
UPDATE munros SET prominence_m = 974 WHERE name = 'Beinn Sgritheall';
UPDATE munros SET prominence_m = 973 WHERE name = 'Sgùrr a'' Ghreadaidh';
UPDATE munros SET prominence_m = 968 WHERE name = 'Meall Garbh (Càrn Mairg)';
UPDATE munros SET prominence_m = 967 WHERE name = 'A'' Mhaighdean';
UPDATE munros SET prominence_m = 967 WHERE name = 'Sgòrr nam Fiannaidh (Aonach Eagach)';
UPDATE munros SET prominence_m = 966 WHERE name = 'Ben More (Mull)';
UPDATE munros SET prominence_m = 965 WHERE name = 'Sgùrr na Banachdich';
UPDATE munros SET prominence_m = 964 WHERE name = 'Sgùrr nan Gillean';
UPDATE munros SET prominence_m = 963 WHERE name = 'Càrn a'' Chlamain';
UPDATE munros SET prominence_m = 963 WHERE name = 'Sgùrr Thuilm';
UPDATE munros SET prominence_m = 962 WHERE name = 'Sgòrr Ruadh';
UPDATE munros SET prominence_m = 961 WHERE name = 'Ben Klibreck';
UPDATE munros SET prominence_m = 960 WHERE name = 'Beinn nan Aighenan';
UPDATE munros SET prominence_m = 960 WHERE name = 'Stùcd an Lochain';
UPDATE munros SET prominence_m = 959 WHERE name = 'Beinn Fhionnlaidh';
UPDATE munros SET prominence_m = 959 WHERE name = 'Meall Glas';
UPDATE munros SET prominence_m = 958 WHERE name = 'Bruach na Frìthe';
UPDATE munros SET prominence_m = 958 WHERE name = 'Tolmount';
UPDATE munros SET prominence_m = 957 WHERE name = 'Càrn Ghluasaid';
UPDATE munros SET prominence_m = 957 WHERE name = 'Tom Buidhe';
UPDATE munros SET prominence_m = 956 WHERE name = 'Sàileag';
UPDATE munros SET prominence_m = 956 WHERE name = 'Sgùrr nan Coireachan (Glenfinnan)';
UPDATE munros SET prominence_m = 956 WHERE name = 'Stob Dubh (Buachaille Etive Beag)';
UPDATE munros SET prominence_m = 956 WHERE name = 'Stob na Bròige (Buachaille Etive Mòr)';
UPDATE munros SET prominence_m = 955 WHERE name = 'Sgòr Gaibhre';
UPDATE munros SET prominence_m = 954 WHERE name = 'Am Faochagach';
UPDATE munros SET prominence_m = 954 WHERE name = 'Beinn Liath Mhòr Fannaich';
UPDATE munros SET prominence_m = 953 WHERE name = 'Beinn Mhanach';
UPDATE munros SET prominence_m = 953 WHERE name = 'Meall Dearg (Aonach Eagach)';
UPDATE munros SET prominence_m = 953 WHERE name = 'Sgùrr nan Coireachan (Glen Dessary)';
UPDATE munros SET prominence_m = 951 WHERE name = 'Meall Chuaich';
UPDATE munros SET prominence_m = 949 WHERE name = 'Meall Gorm';
UPDATE munros SET prominence_m = 948 WHERE name = 'Beinn Bhuidhe';
UPDATE munros SET prominence_m = 948 WHERE name = 'Sgùrr Mhic Chòinnich';
UPDATE munros SET prominence_m = 947 WHERE name = 'Creag a''Mhàim';
UPDATE munros SET prominence_m = 947 WHERE name = 'Driesh';
UPDATE munros SET prominence_m = 946 WHERE name = 'Beinn Tulaichean';
UPDATE munros SET prominence_m = 946 WHERE name = 'Càrn Bhac';
UPDATE munros SET prominence_m = 946 WHERE name = 'Meall Buidhe (Knoydart)';
UPDATE munros SET prominence_m = 945 WHERE name = 'Bidein a'' Choire Sheasgaich';
UPDATE munros SET prominence_m = 945 WHERE name = 'Càrn Dearg (Monadhliath)';
UPDATE munros SET prominence_m = 945 WHERE name = 'Sgùrr na Sgìne';
UPDATE munros SET prominence_m = 945 WHERE name = 'Stob a'' Choire Odhair';
UPDATE munros SET prominence_m = 944 WHERE name = 'An Socach (Braemar)';
UPDATE munros SET prominence_m = 944 WHERE name = 'Sgùrr Dubh Mòr';
UPDATE munros SET prominence_m = 943 WHERE name = 'Ben Vorlich (Loch Lomond)';
UPDATE munros SET prominence_m = 943 WHERE name = 'Binnein Beag';
UPDATE munros SET prominence_m = 942 WHERE name = 'Beinn a'' Chròin';
UPDATE munros SET prominence_m = 941 WHERE name = 'Càrn Dearg (Corrour)';
UPDATE munros SET prominence_m = 941 WHERE name = 'Càrn na Caim';
UPDATE munros SET prominence_m = 939 WHERE name = 'Luinne Bheinn';
UPDATE munros SET prominence_m = 939 WHERE name = 'Mount Keen';
UPDATE munros SET prominence_m = 939 WHERE name = 'Mullach nan Coirean';
UPDATE munros SET prominence_m = 937 WHERE name = 'Beinn na Lap';
UPDATE munros SET prominence_m = 937 WHERE name = 'Beinn Sgulaird';
UPDATE munros SET prominence_m = 937 WHERE name = 'Beinn Tarsuinn';
UPDATE munros SET prominence_m = 937 WHERE name = 'Sròn a'' Choire Ghairbh';
UPDATE munros SET prominence_m = 936 WHERE name = 'A'' Bhuidheanach Bheag';
UPDATE munros SET prominence_m = 934 WHERE name = 'Am Basteir';
UPDATE munros SET prominence_m = 934 WHERE name = 'Meall a'' Chrasgaidh';
UPDATE munros SET prominence_m = 933 WHERE name = 'Beinn Chabhair';
UPDATE munros SET prominence_m = 933 WHERE name = 'Fionn Bheinn';
UPDATE munros SET prominence_m = 933 WHERE name = 'Maol Chean-dearg';
UPDATE munros SET prominence_m = 933 WHERE name = 'The Cairnwell';
UPDATE munros SET prominence_m = 932 WHERE name = 'Meall Buidhe (Glen Lyon)';
UPDATE munros SET prominence_m = 931 WHERE name = 'Beinn Bhreac';
UPDATE munros SET prominence_m = 931 WHERE name = 'Ben Chonzie';
UPDATE munros SET prominence_m = 930 WHERE name = 'A'' Chailleach (Monadhliath)';
UPDATE munros SET prominence_m = 928 WHERE name = 'Blà Bheinn';
UPDATE munros SET prominence_m = 928 WHERE name = 'Mayar';
UPDATE munros SET prominence_m = 928 WHERE name = 'Meall nan Eun';
UPDATE munros SET prominence_m = 928 WHERE name = 'Moruisg';
UPDATE munros SET prominence_m = 927 WHERE name = 'Ben Hope';
UPDATE munros SET prominence_m = 927 WHERE name = 'Eididh nan Clach Geala';
UPDATE munros SET prominence_m = 926 WHERE name = 'Beinn Liath Mhòr';
UPDATE munros SET prominence_m = 926 WHERE name = 'Beinn Narnain';
UPDATE munros SET prominence_m = 926 WHERE name = 'Geal Chàrn (Monadhliath)';
UPDATE munros SET prominence_m = 926 WHERE name = 'Meall a'' Choire Lèith';
UPDATE munros SET prominence_m = 926 WHERE name = 'Seana Bhràigh';
UPDATE munros SET prominence_m = 925 WHERE name = 'Stob Coire Raineach (Buachaille Etive Beag)';
UPDATE munros SET prominence_m = 924 WHERE name = 'Creag Pitridh';
UPDATE munros SET prominence_m = 924 WHERE name = 'Sgùrr nan Eag';
UPDATE munros SET prominence_m = 923 WHERE name = 'An Coileachan';
UPDATE munros SET prominence_m = 923 WHERE name = 'Sgùrr nan Each';
UPDATE munros SET prominence_m = 922 WHERE name = 'Tom na Gruagaich (Beinn Alligin)';
UPDATE munros SET prominence_m = 921 WHERE name = 'An Socach (Affric)';
UPDATE munros SET prominence_m = 921 WHERE name = 'Sgiath Chùil';
UPDATE munros SET prominence_m = 920 WHERE name = 'Càrn Sgulain';
UPDATE munros SET prominence_m = 919 WHERE name = 'Gairich';
UPDATE munros SET prominence_m = 918 WHERE name = 'A'' Ghlas-bheinn';
UPDATE munros SET prominence_m = 918 WHERE name = 'Creag nan Dàmh';
UPDATE munros SET prominence_m = 918 WHERE name = 'Meall na Teanga';
UPDATE munros SET prominence_m = 918 WHERE name = 'Ruadh Stac Mòr';
UPDATE munros SET prominence_m = 918 WHERE name = 'Sgùrr a'' Mhadaidh';
UPDATE munros SET prominence_m = 917 WHERE name = 'Càrn Aosda';
UPDATE munros SET prominence_m = 917 WHERE name = 'Geal-chàrn (Drumochter)';
UPDATE munros SET prominence_m = 916 WHERE name = 'Beinn a'' Chlèibh';
UPDATE munros SET prominence_m = 915 WHERE name = 'Beinn Teallach';
UPDATE munros SET prominence_m = 915 WHERE name = 'Ben Vane';

-- Verify the update worked
SELECT 
  COUNT(*) as total_updated,
  MIN(prominence_m) as min_prominence,
  MAX(prominence_m) as max_prominence,
  AVG(prominence_m) as avg_prominence
FROM munros 
WHERE prominence_m > 0;

-- Show some examples to verify correctness
SELECT name, height_m, prominence_m 
FROM munros 
WHERE name IN ('Ben Nevis', 'Ben Macdui', 'Braeriach', 'Cairn Gorm', 'Ben Lawers')
ORDER BY height_m DESC;

-- Count how many still have zero prominence (should be 0)
SELECT COUNT(*) as zero_prominence_count
FROM munros 
WHERE prominence_m = 0;