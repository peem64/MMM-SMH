
-- Step 1: Create temporary mapping table
CREATE TEMP TABLE IF NOT EXISTS prominence_updates (
  munro_name TEXT,
  new_prominence NUMERIC
);

-- Step 2: Insert all prominence mappings

INSERT INTO prominence_updates VALUES ('Ben Chonzie', 646.9);
INSERT INTO prominence_updates VALUES ('Ben Vorlich', 834.3);
INSERT INTO prominence_updates VALUES ('Stuc a'' Chroin', 252.1);
INSERT INTO prominence_updates VALUES ('Ben More', 986);
INSERT INTO prominence_updates VALUES ('Stob Binnein', 304.4);
INSERT INTO prominence_updates VALUES ('Cruach Ardrain', 549);
INSERT INTO prominence_updates VALUES ('An Caisteal', 474);
INSERT INTO prominence_updates VALUES ('Ben Lomond', 820);
INSERT INTO prominence_updates VALUES ('Beinn Tulaichean', 121.8);
INSERT INTO prominence_updates VALUES ('Beinn Chabhair', 313);
INSERT INTO prominence_updates VALUES ('Ben Lui [Beinn Laoigh]', 876);
INSERT INTO prominence_updates VALUES ('Ben Oss', 341.2);
INSERT INTO prominence_updates VALUES ('Beinn Ime', 713);
INSERT INTO prominence_updates VALUES ('Beinn Dubhchraig', 198.9);
INSERT INTO prominence_updates VALUES ('Beinn Bhuidhe', 592);
INSERT INTO prominence_updates VALUES ('Ben Vorlich', 632);
INSERT INTO prominence_updates VALUES ('Beinn Narnain', 290);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chleibh', 139.9);
INSERT INTO prominence_updates VALUES ('Ben Vane', 424);
INSERT INTO prominence_updates VALUES ('Schiehallion', 716);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chreachain', 650);
INSERT INTO prominence_updates VALUES ('Beinn Dorain', 332);
INSERT INTO prominence_updates VALUES ('Carn Mairg', 466.9);
INSERT INTO prominence_updates VALUES ('Beinn Achaladair', 226);
INSERT INTO prominence_updates VALUES ('Carn Gorm', 188.5);
INSERT INTO prominence_updates VALUES ('Beinn an Dothaidh', 247);
INSERT INTO prominence_updates VALUES ('Meall na Aighean', 136);
INSERT INTO prominence_updates VALUES ('Meall Garbh', 102.2);
INSERT INTO prominence_updates VALUES ('Stuc an Lochain [Stuchd an Lochain]', 481);
INSERT INTO prominence_updates VALUES ('Beinn Mhanach', 315);
INSERT INTO prominence_updates VALUES ('Meall Buidhe', 321.1);
INSERT INTO prominence_updates VALUES ('Ben Lawers', 914);
INSERT INTO prominence_updates VALUES ('An Stuc', 126);
INSERT INTO prominence_updates VALUES ('Meall Garbh', 198);
INSERT INTO prominence_updates VALUES ('Beinn Ghlas', 109.1);
INSERT INTO prominence_updates VALUES ('Beinn Sheasgarnaich [Beinn Heasgarnich]', 579);
INSERT INTO prominence_updates VALUES ('Meall Corranaich', 201.3);
INSERT INTO prominence_updates VALUES ('Creag Mhor', 394);
INSERT INTO prominence_updates VALUES ('Meall nan Tarmachan', 494.4);
INSERT INTO prominence_updates VALUES ('Meall Ghaordaidh', 492);
INSERT INTO prominence_updates VALUES ('Beinn Challuim [Ben Challum]', 450);
INSERT INTO prominence_updates VALUES ('Meall Greigh', 167);
INSERT INTO prominence_updates VALUES ('Meall Glas', 554);
INSERT INTO prominence_updates VALUES ('Meall a'' Choire Leith', 150.5);
INSERT INTO prominence_updates VALUES ('Sgiath Chuil', 311);
INSERT INTO prominence_updates VALUES ('Aonach Eagach - Sgorr nam Fiannaidh', 623);
INSERT INTO prominence_updates VALUES ('Aonach Eagach - Meall Dearg', 120.3);
INSERT INTO prominence_updates VALUES ('Bidean nam Bian', 844);
INSERT INTO prominence_updates VALUES ('Stob Coire Sgreamhach', 128);
INSERT INTO prominence_updates VALUES ('Beinn a'' Bheithir - Sgorr Dhearg', 729);
INSERT INTO prominence_updates VALUES ('Buachaille Etive Mor - Stob Dearg', 532);
INSERT INTO prominence_updates VALUES ('Beinn a'' Bheithir - Sgorr Dhonuill', 245.1);
INSERT INTO prominence_updates VALUES ('Sgurr na h-Ulaidh [Sgor na h-Ulaidh]', 415);
INSERT INTO prominence_updates VALUES ('Beinn Fhionnlaidh', 510);
INSERT INTO prominence_updates VALUES ('Buachaille Etive Beag - Stob Dubh', 469);
INSERT INTO prominence_updates VALUES ('Buachaille Etive Mor - Stob na Broige', 134.5);
INSERT INTO prominence_updates VALUES ('Beinn Sgulaird', 662);
INSERT INTO prominence_updates VALUES ('Buachaille Etive Beag - Stob Coire Raineach', 177.7);
INSERT INTO prominence_updates VALUES ('Ben Cruachan', 880);
INSERT INTO prominence_updates VALUES ('Meall a'' Bhuiridh', 795);
INSERT INTO prominence_updates VALUES ('Creise', 169.4);
INSERT INTO prominence_updates VALUES ('Stob Ghabhar', 392);
INSERT INTO prominence_updates VALUES ('Ben Starav', 448.8);
INSERT INTO prominence_updates VALUES ('Stob Coir'' an Albannaich', 307);
INSERT INTO prominence_updates VALUES ('Stob Daimh [Stob Diamh]', 134.5);
INSERT INTO prominence_updates VALUES ('Glas Bheinn Mhor', 231.3);
INSERT INTO prominence_updates VALUES ('Beinn Eunaich', 425);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chochuill', 252);
INSERT INTO prominence_updates VALUES ('Beinn nan Aighenan', 343.4);
INSERT INTO prominence_updates VALUES ('Stob a'' Choire Odhair', 279.4);
INSERT INTO prominence_updates VALUES ('Meall nan Eun', 174.5);
INSERT INTO prominence_updates VALUES ('Ben Nevis [Beinn Nibheis]', 1344.5);
INSERT INTO prominence_updates VALUES ('Aonach Beag', 404);
INSERT INTO prominence_updates VALUES ('Aonach Mor', 133);
INSERT INTO prominence_updates VALUES ('Carn Mor Dearg', 162);
INSERT INTO prominence_updates VALUES ('Stob Choire Claurigh', 446);
INSERT INTO prominence_updates VALUES ('Binnein Mor', 759);
INSERT INTO prominence_updates VALUES ('Stob Coire an Laoigh', 74);
INSERT INTO prominence_updates VALUES ('Stob Coire Easain', 611);
INSERT INTO prominence_updates VALUES ('Stob a'' Choire Mheadhoin', 140);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Mhaim', 316);
INSERT INTO prominence_updates VALUES ('Sgurr Choinnich Mor', 159);
INSERT INTO prominence_updates VALUES ('Na Gruagaichean', 96.8);
INSERT INTO prominence_updates VALUES ('Am Bodach', 152.8);
INSERT INTO prominence_updates VALUES ('Sgurr Eilde Mor', 271);
INSERT INTO prominence_updates VALUES ('Stob Ban', 237.1);
INSERT INTO prominence_updates VALUES ('An Gearanach', 151.7);
INSERT INTO prominence_updates VALUES ('Stob Coire a'' Chairn', 124.5);
INSERT INTO prominence_updates VALUES ('Stob Ban', 174);
INSERT INTO prominence_updates VALUES ('Binnein Beag', 197);
INSERT INTO prominence_updates VALUES ('Mullach nan Coirean', 92.3);
INSERT INTO prominence_updates VALUES ('Ben Alder', 783);
INSERT INTO prominence_updates VALUES ('Geal-charn', 410);
INSERT INTO prominence_updates VALUES ('Aonach Beag', 99);
INSERT INTO prominence_updates VALUES ('Beinn Eibhinn', 127);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chlachair', 540);
INSERT INTO prominence_updates VALUES ('Geal Charn', 311);
INSERT INTO prominence_updates VALUES ('Chno Dearg', 644);
INSERT INTO prominence_updates VALUES ('Carn Dearg', 158);
INSERT INTO prominence_updates VALUES ('Beinn Bheoil', 186);
INSERT INTO prominence_updates VALUES ('Stob Coire Sgriodain', 90);
INSERT INTO prominence_updates VALUES ('Sgor Gaibhre', 300);
INSERT INTO prominence_updates VALUES ('Carn Dearg', 221);
INSERT INTO prominence_updates VALUES ('Beinn na Lap', 406);
INSERT INTO prominence_updates VALUES ('Creag Pitridh', 104.2);
INSERT INTO prominence_updates VALUES ('Beinn Udlamain', 555);
INSERT INTO prominence_updates VALUES ('Sgairneach Mhor', 182);
INSERT INTO prominence_updates VALUES ('A'' Mharconaich', 112);
INSERT INTO prominence_updates VALUES ('Meall Chuaich', 466);
INSERT INTO prominence_updates VALUES ('Carn na Caim', 328.1);
INSERT INTO prominence_updates VALUES ('A'' Bhuidheanach Bheag', 109);
INSERT INTO prominence_updates VALUES ('Geal-charn', 178);
INSERT INTO prominence_updates VALUES ('Beinn Dearg', 473);
INSERT INTO prominence_updates VALUES ('An Sgarsoch', 319);
INSERT INTO prominence_updates VALUES ('Carn an Fhidhleir [Carn Ealar]', 286);
INSERT INTO prominence_updates VALUES ('Carn a'' Chlamain', 317);
INSERT INTO prominence_updates VALUES ('Beinn a'' Ghlo - Carn nan Gabhar', 658);
INSERT INTO prominence_updates VALUES ('Beinn a'' Ghlo - Braigh Coire Chruinn-bhalgain', 222.4);
INSERT INTO prominence_updates VALUES ('Glas Tulaichean', 384);
INSERT INTO prominence_updates VALUES ('Beinn Iutharn Mhor', 247);
INSERT INTO prominence_updates VALUES ('Carn an Righ', 258);
INSERT INTO prominence_updates VALUES ('Carn a'' Gheoidh', 299);
INSERT INTO prominence_updates VALUES ('Beinn a'' Ghlo - Carn Liath', 207.1);
INSERT INTO prominence_updates VALUES ('Carn Bhac', 186.9);
INSERT INTO prominence_updates VALUES ('An Socach', 187);
INSERT INTO prominence_updates VALUES ('The Cairnwell', 127.1);
INSERT INTO prominence_updates VALUES ('Carn Aosda', 122.1);
INSERT INTO prominence_updates VALUES ('Lochnagar - Cac Carn Beag', 671);
INSERT INTO prominence_updates VALUES ('Carn a'' Choire Bhoidheach', 72.9);
INSERT INTO prominence_updates VALUES ('Glas Maol', 195.2);
INSERT INTO prominence_updates VALUES ('Cairn of Claise', 118.9);
INSERT INTO prominence_updates VALUES ('Carn an t-Sagairt Mor', 85);
INSERT INTO prominence_updates VALUES ('Carn an Tuirc', 61.6);
INSERT INTO prominence_updates VALUES ('Cairn Bannoch', 76);
INSERT INTO prominence_updates VALUES ('Broad Cairn', 63.9);
INSERT INTO prominence_updates VALUES ('Creag Leacach', 70.7);
INSERT INTO prominence_updates VALUES ('Tolmount', 73.7);
INSERT INTO prominence_updates VALUES ('Tom Buidhe', 72.6);
INSERT INTO prominence_updates VALUES ('Driesh', 136.9);
INSERT INTO prominence_updates VALUES ('Mount Keen', 312);
INSERT INTO prominence_updates VALUES ('Mayar', 112);
INSERT INTO prominence_updates VALUES ('Ben Macdui [Beinn Macduibh]', 950);
INSERT INTO prominence_updates VALUES ('Braeriach', 461);
INSERT INTO prominence_updates VALUES ('Cairn Toul', 166);
INSERT INTO prominence_updates VALUES ('Sgor an Lochain Uaine', 118);
INSERT INTO prominence_updates VALUES ('Cairn Gorm', 145.8);
INSERT INTO prominence_updates VALUES ('Beinn a'' Bhuird [Beinn a'' Bhuird North Top]', 456.2);
INSERT INTO prominence_updates VALUES ('Beinn Mheadhoin', 254);
INSERT INTO prominence_updates VALUES ('Ben Avon - Leabaidh an Daimh Bhuidhe', 198);
INSERT INTO prominence_updates VALUES ('Beinn Bhrotain', 258);
INSERT INTO prominence_updates VALUES ('Derry Cairngorm', 142);
INSERT INTO prominence_updates VALUES ('Sgor Gaoith', 242.8);
INSERT INTO prominence_updates VALUES ('Monadh Mor', 138.8);
INSERT INTO prominence_updates VALUES ('Bynack More', 283);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chaorainn', 246.3);
INSERT INTO prominence_updates VALUES ('Carn a'' Mhaim', 231);
INSERT INTO prominence_updates VALUES ('Mullach Clach a'' Bhlair', 104.9);
INSERT INTO prominence_updates VALUES ('The Devil''s Point', 90.6);
INSERT INTO prominence_updates VALUES ('Beinn Bhreac', 80.9);
INSERT INTO prominence_updates VALUES ('Carn Dearg', 591);
INSERT INTO prominence_updates VALUES ('A'' Chailleach', 108.3);
INSERT INTO prominence_updates VALUES ('Geal Charn', 101.1);
INSERT INTO prominence_updates VALUES ('Carn Sgulain', 71.6);
INSERT INTO prominence_updates VALUES ('Creag Meagaidh', 868);
INSERT INTO prominence_updates VALUES ('Stob Poite Coire Ardair', 107);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chaorainn', 227);
INSERT INTO prominence_updates VALUES ('Carn Liath', 86.9);
INSERT INTO prominence_updates VALUES ('Beinn Teallach', 301.5);
INSERT INTO prominence_updates VALUES ('Gleouraich', 767.7);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Mhaoraich', 708);
INSERT INTO prominence_updates VALUES ('Aonach air Chrith', 493);
INSERT INTO prominence_updates VALUES ('Sgurr an Doire Leathain', 189);
INSERT INTO prominence_updates VALUES ('The Saddle', 334);
INSERT INTO prominence_updates VALUES ('Sgurr an Lochain', 123);
INSERT INTO prominence_updates VALUES ('Spidean Mialach', 259.5);
INSERT INTO prominence_updates VALUES ('Druim Shionnach', 101.3);
INSERT INTO prominence_updates VALUES ('Maol Chinn-dearg', 137.6);
INSERT INTO prominence_updates VALUES ('Beinn Sgritheall', 500);
INSERT INTO prominence_updates VALUES ('Creag a'' Mhaim', 79.6);
INSERT INTO prominence_updates VALUES ('Sgurr na Sgine', 247);
INSERT INTO prominence_updates VALUES ('Creag nan Damh', 196);
INSERT INTO prominence_updates VALUES ('Sgurr na Ciche', 839);
INSERT INTO prominence_updates VALUES ('Ladhar Bheinn', 795);
INSERT INTO prominence_updates VALUES ('Garbh Chioch Mhor', 169.5);
INSERT INTO prominence_updates VALUES ('Sgurr Mor', 341);
INSERT INTO prominence_updates VALUES ('Sgurr nan Coireachan', 221.7);
INSERT INTO prominence_updates VALUES ('Meall Buidhe', 497);
INSERT INTO prominence_updates VALUES ('Luinne Bheinn', 256.6);
INSERT INTO prominence_updates VALUES ('Gairich', 552);
INSERT INTO prominence_updates VALUES ('Sron a'' Choire Ghairbh', 621);
INSERT INTO prominence_updates VALUES ('Meall na Teanga', 305.5);
INSERT INTO prominence_updates VALUES ('Gulvain [Gaor Bheinn]', 842);
INSERT INTO prominence_updates VALUES ('Sgurr Thuilm', 614);
INSERT INTO prominence_updates VALUES ('Sgurr nan Coireachan', 231.8);
INSERT INTO prominence_updates VALUES ('Carn Eighe', 1147);
INSERT INTO prominence_updates VALUES ('Mam Sodhail', 132.4);
INSERT INTO prominence_updates VALUES ('Sgurr nan Ceathramhnan [Sgurr nan Ceathreamhnan]', 433);
INSERT INTO prominence_updates VALUES ('Tom a'' Choinnich [Tom a'' Choinich]', 149.8);
INSERT INTO prominence_updates VALUES ('Sgurr Fhuaran', 665);
INSERT INTO prominence_updates VALUES ('Toll Creagach', 181.4);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Bhealaich Dheirg', 311);
INSERT INTO prominence_updates VALUES ('Beinn Fhada', 647);
INSERT INTO prominence_updates VALUES ('Sgurr na Ciste Duibhe', 178);
INSERT INTO prominence_updates VALUES ('Beinn Fhionnlaidh', 173);
INSERT INTO prominence_updates VALUES ('Sgurr na Carnach', 134);
INSERT INTO prominence_updates VALUES ('Aonach Meadhoin', 174);
INSERT INTO prominence_updates VALUES ('Mullach na Dheiragain', 144);
INSERT INTO prominence_updates VALUES ('Ciste Dhubh', 390.5);
INSERT INTO prominence_updates VALUES ('Saileag', 91);
INSERT INTO prominence_updates VALUES ('An Socach', 123.8);
INSERT INTO prominence_updates VALUES ('A'' Ghlas-bheinn', 407);
INSERT INTO prominence_updates VALUES ('A'' Chraileag [A'' Chralaig]', 786);
INSERT INTO prominence_updates VALUES ('Sgurr nan Conbhairean', 382);
INSERT INTO prominence_updates VALUES ('Mullach Fraoch-choire', 151.3);
INSERT INTO prominence_updates VALUES ('Sail Chaorainn', 87);
INSERT INTO prominence_updates VALUES ('Carn Ghluasaid', 62.7);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Choire Ghlais', 819);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Chaorachain', 568);
INSERT INTO prominence_updates VALUES ('Sgurr Fhuar-thuill', 148.1);
INSERT INTO prominence_updates VALUES ('Maoile Lunndaidh', 10.5);
INSERT INTO prominence_updates VALUES ('Sgurr Choinnich', 133);
INSERT INTO prominence_updates VALUES ('Sgurr na Ruaidhe', 226);
INSERT INTO prominence_updates VALUES ('Carn nan Gobhar', 137);
INSERT INTO prominence_updates VALUES ('Lurg Mhor', 443);
INSERT INTO prominence_updates VALUES ('Bidein a'' Choire Sheasgaich', 208.2);
INSERT INTO prominence_updates VALUES ('Moruisg', 592);
INSERT INTO prominence_updates VALUES ('Sgurr na Lapaich', 841);
INSERT INTO prominence_updates VALUES ('An Riabhachan', 302);
INSERT INTO prominence_updates VALUES ('An Socach', 207);
INSERT INTO prominence_updates VALUES ('Carn nan Gobhar', 197.5);
INSERT INTO prominence_updates VALUES ('Liathach - Spidean a'' Choire Leith', 957);
INSERT INTO prominence_updates VALUES ('Liathach - Mullach an Rathain', 152.1);
INSERT INTO prominence_updates VALUES ('Beinn Eighe - Ruadh-stac Mor', 632);
INSERT INTO prominence_updates VALUES ('Beinn Eighe - Spidean Coire nan Clach', 172);
INSERT INTO prominence_updates VALUES ('Beinn Alligin - Sgurr Mor', 601);
INSERT INTO prominence_updates VALUES ('Beinn Alligin - Tom na Gruagaich', 155);
INSERT INTO prominence_updates VALUES ('Sgorr Ruadh', 723);
INSERT INTO prominence_updates VALUES ('Maol Chean-dearg', 514);
INSERT INTO prominence_updates VALUES ('Beinn Liath Mhor', 271);
INSERT INTO prominence_updates VALUES ('An Teallach - Bidein a'' Ghlas Thuill', 757);
INSERT INTO prominence_updates VALUES ('An Teallach - Sgurr Fiona', 141.7);
INSERT INTO prominence_updates VALUES ('Mullach Coire Mhic Fhearchair', 591);
INSERT INTO prominence_updates VALUES ('Sgurr Ban', 165);
INSERT INTO prominence_updates VALUES ('Slioch', 626);
INSERT INTO prominence_updates VALUES ('A'' Mhaighdean', 443);
INSERT INTO prominence_updates VALUES ('Beinn Tarsuinn', 207.1);
INSERT INTO prominence_updates VALUES ('Ruadh Stac Mor', 169.8);
INSERT INTO prominence_updates VALUES ('Sgurr Mor', 914);
INSERT INTO prominence_updates VALUES ('Sgurr nan Clach Geala', 229);
INSERT INTO prominence_updates VALUES ('Sgurr Breac', 450.8);
INSERT INTO prominence_updates VALUES ('A'' Chailleach', 182.9);
INSERT INTO prominence_updates VALUES ('Beinn Liath Mhor Fannaich', 107);
INSERT INTO prominence_updates VALUES ('Meall Gorm', 112.3);
INSERT INTO prominence_updates VALUES ('Meall a'' Chrasgaidh', 115);
INSERT INTO prominence_updates VALUES ('Fionn Bheinn', 658);
INSERT INTO prominence_updates VALUES ('Sgurr nan Each', 109);
INSERT INTO prominence_updates VALUES ('An Coileachan', 148.3);
INSERT INTO prominence_updates VALUES ('Beinn Dearg', 810);
INSERT INTO prominence_updates VALUES ('Cona'' Mheall', 164.8);
INSERT INTO prominence_updates VALUES ('Meall nan Ceapraichean', 126.6);
INSERT INTO prominence_updates VALUES ('Am Faochagach', 367);
INSERT INTO prominence_updates VALUES ('Eididh nan Clach Geala', 166);
INSERT INTO prominence_updates VALUES ('Seana Bhraigh', 251);
INSERT INTO prominence_updates VALUES ('Ben Wyvis - Glas Leathad Mor', 691);
INSERT INTO prominence_updates VALUES ('Ben Hope', 772);
INSERT INTO prominence_updates VALUES ('Ben Klibreck - Meall nan Con', 819);
INSERT INTO prominence_updates VALUES ('Ben More Assynt', 836);
INSERT INTO prominence_updates VALUES ('Conival', 102);
INSERT INTO prominence_updates VALUES ('Sgurr Alasdair', 992);
INSERT INTO prominence_updates VALUES ('Sgurr Dearg - Inaccessible Pinnacle', 187.6);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Ghreadaidh', 123);
INSERT INTO prominence_updates VALUES ('Sgurr na Banachdich [Sgurr na Banachdaich]', 114);
INSERT INTO prominence_updates VALUES ('Sgurr nan Gillean', 205);
INSERT INTO prominence_updates VALUES ('Bruach na Frithe', 126);
INSERT INTO prominence_updates VALUES ('Sgurr Mhic Choinnich', 56);
INSERT INTO prominence_updates VALUES ('Sgurr Dubh Mor', 89);
INSERT INTO prominence_updates VALUES ('Am Basteir', 49);
INSERT INTO prominence_updates VALUES ('Blabheinn [Bla Bheinn]', 859);
INSERT INTO prominence_updates VALUES ('Sgurr nan Eag', 130.3);
INSERT INTO prominence_updates VALUES ('Sgurr a'' Mhadaidh', 72.9);
INSERT INTO prominence_updates VALUES ('Ben More', 966);
INSERT INTO prominence_updates VALUES ('Beinn a'' Chroin', 136.9);

-- Step 3: Update munros using fuzzy matching
-- This handles variations in naming between DoBIH and our database

-- First, try exact matches (after normalization)
UPDATE munros m
SET prominence_m = pu.new_prominence
FROM prominence_updates pu
WHERE LOWER(REGEXP_REPLACE(REGEXP_REPLACE(m.name, '\[.*?\]', '', 'g'), '\s+', ' ', 'g')) =
      LOWER(REGEXP_REPLACE(REGEXP_REPLACE(pu.munro_name, '\[.*?\]', '', 'g'), '\s+', ' ', 'g'));

-- Then handle names with location qualifiers like "Ben Vorlich (Loch Earn)"
-- by matching the base name and checking if location appears in the munro name
UPDATE munros m
SET prominence_m = pu.new_prominence
FROM prominence_updates pu
WHERE m.prominence_m = m.height_m  -- Only update those not yet fixed
AND (
  -- Match pattern: "Name (Location)" in DB vs just "Name" in DoBIH
  LOWER(REGEXP_REPLACE(m.name, ' \(.*?\)', '')) LIKE LOWER(REGEXP_REPLACE(pu.munro_name, '\[.*?\]', ''))
  OR
  -- Match with hyphens/spaces normalized
  LOWER(REGEXP_REPLACE(REGEXP_REPLACE(m.name, '[\s-]+', '', 'g'), '[''']', '''', 'g')) =
  LOWER(REGEXP_REPLACE(REGEXP_REPLACE(pu.munro_name, '[\s-]+', '', 'g'), '[''']', '''', 'g'))
);

-- Clean up
DROP TABLE prominence_updates;

-- Verify results
SELECT
  COUNT(*) as total,
  SUM(CASE WHEN prominence_m = height_m THEN 1 ELSE 0 END) as still_need_fixing,
  SUM(CASE WHEN prominence_m != height_m THEN 1 ELSE 0 END) as now_correct
FROM munros;
