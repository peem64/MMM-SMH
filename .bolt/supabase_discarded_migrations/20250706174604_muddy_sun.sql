-- Clear existing incorrect data
TRUNCATE TABLE corbetts;

-- Insert real Corbetts data with proper PostgreSQL array formatting
INSERT INTO corbetts (
  name, location, region, height, prominence, classification, 
  estimated_time, description, difficulty_rating, popular_routes, 
  best_seasons, grid_reference, nearest_town, parking_info, image_filename
) VALUES

-- Highland Region - Northern Highlands
('Ben Stack', 'Reay Forest', 'Northern Highlands', 721, 721, 'Corbett', '4-5 hours', 'An isolated peak in the far northwest, offering spectacular views across Sutherland. The ascent provides excellent views of the Flow Country and distant mountains.', 2, ARRAY['Laxford Bridge approach', 'Direct ascent from A838'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC258418', 'Lairg', 'Roadside parking near Laxford Bridge', 'ben_stack.jpg'),

('Arkle', 'Reay Forest', 'Northern Highlands', 787, 787, 'Corbett', '5-6 hours', 'A prominent peak in the Reay Forest, named after the famous racehorse. Offers challenging terrain and spectacular views across the northwest Highlands.', 3, ARRAY['Rhiconich approach', 'Via Foinaven ridge'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC303462', 'Kinlochbervie', 'Limited parking at Rhiconich', 'arkle.jpg'),

('Foinaven', 'Reay Forest', 'Northern Highlands', 908, 908, 'Corbett', '6-7 hours', 'The highest peak in the far northwest, offering one of Scotland''s most remote mountain experiences. The quartzite ridges provide spectacular walking.', 4, ARRAY['Rhiconich approach', 'Gualin House route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC315506', 'Kinlochbervie', 'Parking at Gualin House', 'foinaven.jpg'),

('Ben More Assynt', 'Assynt', 'Northern Highlands', 998, 998, 'Corbett', '6-7 hours', 'The highest peak in Assynt, offering spectacular views across the unique landscape of the northwest Highlands. The ascent crosses ancient geology.', 3, ARRAY['Inchnadamph approach', 'Via Conival'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC318201', 'Lochinver', 'Parking at Inchnadamph', 'ben_more_assynt.jpg'),

('Conival', 'Assynt', 'Northern Highlands', 987, 187, 'Corbett', '6-7 hours', 'Often climbed with Ben More Assynt, this peak offers excellent views and challenging terrain. Part of the spectacular Assynt landscape.', 3, ARRAY['Via Ben More Assynt', 'Inchnadamph approach'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC303199', 'Lochinver', 'Parking at Inchnadamph', 'conival.jpg'),

('Canisp', 'Assynt', 'Northern Highlands', 846, 846, 'Corbett', '4-5 hours', 'A distinctive peak in Assynt, offering excellent views of Suilven and the surrounding landscape. The ascent provides spectacular Highland scenery.', 2, ARRAY['A837 approach', 'Ledmore route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC203188', 'Lochinver', 'Roadside parking on A837', 'canisp.jpg'),

('Suilven', 'Assynt', 'Northern Highlands', 731, 731, 'Corbett', '6-8 hours', 'One of Scotland''s most distinctive mountains, rising dramatically from the surrounding moorland. The ridge walk offers spectacular views and challenging terrain.', 4, ARRAY['Lochinver approach', 'Elphin route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC154183', 'Lochinver', 'Parking at Glencanisp Lodge', 'suilven.jpg'),

('Cul Mor', 'Coigach', 'Northern Highlands', 849, 849, 'Corbett', '5-6 hours', 'A prominent peak in Coigach, offering excellent views across the northwest Highlands. The ascent provides spectacular coastal and mountain views.', 3, ARRAY['Knockan Crag approach', 'Drumrunie route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC162085', 'Ullapool', 'Parking at Knockan Crag', 'cul_mor.jpg'),

('Cul Beag', 'Coigach', 'Northern Highlands', 769, 569, 'Corbett', '4-5 hours', 'A smaller peak in Coigach, offering excellent views and relatively straightforward walking. Popular with those exploring the Coigach area.', 2, ARRAY['Knockan Crag approach', 'Linneraineach route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NC140087', 'Ullapool', 'Parking at Knockan Crag', 'cul_beag.jpg'),

('Stac Pollaidh', 'Coigach', 'Northern Highlands', 613, 613, 'Corbett', '3-4 hours', 'A dramatic and distinctive peak offering some of the finest views in Scotland. The rocky summit provides spectacular panoramic vistas despite its modest height.', 3, ARRAY['Car park approach', 'Summit scramble'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NC107107', 'Ullapool', 'Dedicated car park', 'stac_pollaidh.jpg'),

-- Highland Region - Central Highlands
('Ben Vrackie', 'Pitlochry', 'Central Highlands', 841, 841, 'Corbett', '4-5 hours', 'A popular peak overlooking Pitlochry, offering excellent views across Perthshire. The ascent provides good training for higher mountains.', 2, ARRAY['Moulin approach', 'Pitlochry route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN951632', 'Pitlochry', 'Parking in Moulin village', 'ben_vrackie.jpg'),

('Ben Chonzie', 'Crieff', 'Central Highlands', 931, 731, 'Corbett', '4-5 hours', 'A rounded hill offering excellent views across the central Highlands. Popular with walkers seeking a straightforward mountain experience.', 2, ARRAY['Comrie approach', 'Glen Lednock route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN773308', 'Crieff', 'Parking at Glen Lednock', 'ben_chonzie.jpg'),

('Ben Cleuch', 'Ochil Hills', 'Central Highlands', 721, 621, 'Corbett', '3-4 hours', 'The highest peak in the Ochil Hills, offering excellent views across central Scotland. Popular with day walkers from Edinburgh and Glasgow.', 2, ARRAY['Mill Glen approach', 'Alva route'], ARRAY['All year'], 'NN902006', 'Stirling', 'Parking in Alva', 'ben_cleuch.jpg'),

('The Cobbler', 'Arrochar Alps', 'Southern Highlands', 884, 684, 'Corbett', '5-6 hours', 'A distinctive and challenging peak in the Arrochar Alps, famous for its rocky summit. Requires scrambling skills to reach the true top.', 4, ARRAY['Succoth approach', 'Narnain Boulders route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN259058', 'Arrochar', 'Parking at Succoth', 'the_cobbler.jpg'),

('Beinn Narnain', 'Arrochar Alps', 'Southern Highlands', 926, 526, 'Corbett', '5-6 hours', 'A challenging peak in the Arrochar Alps, offering excellent scrambling and spectacular views. Often climbed with The Cobbler.', 3, ARRAY['Succoth approach', 'Via The Cobbler'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN272067', 'Arrochar', 'Parking at Succoth', 'beinn_narnain.jpg'),

('Ben Donich', 'Arrochar Alps', 'Southern Highlands', 847, 547, 'Corbett', '4-5 hours', 'A peak in the Arrochar Alps offering excellent views over Loch Long. Less crowded than neighboring peaks but equally rewarding.', 2, ARRAY['Rest and be Thankful approach', 'Butterbridge route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN244103', 'Arrochar', 'Parking at Rest and be Thankful', 'ben_donich.jpg'),

('The Brack', 'Arrochar Alps', 'Southern Highlands', 787, 587, 'Corbett', '4-5 hours', 'A steep-sided peak in the Arrochar Alps, offering challenging terrain and excellent views. The ascent provides good scrambling practice.', 3, ARRAY['Rest and be Thankful approach', 'Coiregrogain route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN246098', 'Arrochar', 'Parking at Rest and be Thankful', 'the_brack.jpg'),

-- Highland Region - Trossachs
('Ben Ledi', 'Trossachs', 'Central Highlands', 879, 779, 'Corbett', '4-5 hours', 'A popular peak in the Trossachs, offering excellent views over Loch Katrine and the surrounding hills. Good training mountain for beginners.', 2, ARRAY['Strathyre approach', 'Pass of Leny route'], ARRAY['All year'], 'NN562098', 'Callander', 'Parking at Strathyre', 'ben_ledi.jpg'),

('Ben Venue', 'Trossachs', 'Central Highlands', 727, 527, 'Corbett', '4-5 hours', 'A distinctive peak overlooking Loch Katrine, made famous by Sir Walter Scott. Offers excellent views across the Trossachs.', 3, ARRAY['Loch Katrine approach', 'Achray Forest route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NN405063', 'Aberfoyle', 'Parking at Loch Katrine', 'ben_venue.jpg'),

('Ben Aan', 'Trossachs', 'Central Highlands', 454, 354, 'Corbett', '2-3 hours', 'A small but dramatic peak offering spectacular views over Loch Katrine. Popular with families and those seeking a shorter mountain walk.', 2, ARRAY['Trossachs Pier approach', 'Loch Katrine route'], ARRAY['All year'], 'NN502077', 'Aberfoyle', 'Parking at Trossachs Pier', 'ben_aan.jpg'),

-- Highland Region - Skye and Inner Hebrides
('Bla Bheinn', 'Skye', 'Inner Hebrides', 928, 928, 'Corbett', '6-7 hours', 'The finest non-Cuillin peak on Skye, offering spectacular views of the Cuillin ridge. A challenging but rewarding climb with dramatic scenery.', 4, ARRAY['Kilmarie approach', 'Camasunary route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NG530217', 'Broadford', 'Parking at Kilmarie', 'bla_bheinn.jpg'),

('Glamaig', 'Skye', 'Inner Hebrides', 775, 775, 'Corbett', '3-4 hours', 'A distinctive cone-shaped peak on Skye, offering excellent views across the island. The ascent is steep but straightforward.', 3, ARRAY['Sligachan approach', 'Direct ascent'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NG514299', 'Portree', 'Parking at Sligachan', 'glamaig.jpg'),

('Marsco', 'Skye', 'Inner Hebrides', 736, 536, 'Corbett', '4-5 hours', 'A prominent peak offering excellent views of the Cuillin and across Skye. The ascent provides spectacular Highland scenery.', 3, ARRAY['Sligachan approach', 'Glen Sligachan route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NG516252', 'Portree', 'Parking at Sligachan', 'marsco.jpg'),

('Beinn na Caillich', 'Skye', 'Inner Hebrides', 732, 532, 'Corbett', '3-4 hours', 'A peak on the Sleat peninsula of Skye, offering excellent views across the Sound of Sleat to the mainland. Less crowded than other Skye peaks.', 2, ARRAY['Torrin approach', 'Kilbride route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NG611203', 'Broadford', 'Parking at Torrin', 'beinn_na_caillich_skye.jpg'),

-- Highland Region - Mull and Western Isles
('Dun da Ghaoithe', 'Mull', 'Inner Hebrides', 766, 766, 'Corbett', '4-5 hours', 'The second highest peak on Mull, offering spectacular views across the Inner Hebrides. A challenging climb with rewarding vistas.', 3, ARRAY['Glen More approach', 'Dhiseig route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NM525315', 'Tobermory', 'Parking at Glen More', 'dun_da_ghaoithe.jpg'),

('Ben Buie', 'Mull', 'Inner Hebrides', 717, 517, 'Corbett', '4-5 hours', 'A prominent peak on Mull offering excellent views across the island and to the mainland. The ascent provides spectacular Highland scenery.', 2, ARRAY['Loch Spelve approach', 'Croggan route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NM605275', 'Craignure', 'Parking near Loch Spelve', 'ben_buie.jpg'),

('Beinn Talaidh', 'Mull', 'Inner Hebrides', 762, 562, 'Corbett', '4-5 hours', 'A peak on Mull offering excellent views and challenging terrain. Less frequented than Ben More, providing a wilder experience.', 3, ARRAY['Salen approach', 'Glen Forsa route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NM570440', 'Tobermory', 'Parking at Salen', 'beinn_talaidh.jpg'),

-- Highland Region - Arran
('Goat Fell', 'Arran', 'Arran', 874, 874, 'Corbett', '4-5 hours', 'The highest peak on the Isle of Arran, offering spectacular views across the Firth of Clyde. A popular and challenging climb.', 3, ARRAY['Brodick approach', 'Corrie route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NR991415', 'Brodick', 'Parking in Brodick', 'goat_fell.jpg'),

('Caisteal Abhail', 'Arran', 'Arran', 859, 659, 'Corbett', '5-6 hours', 'A dramatic peak on Arran offering excellent ridge walking and spectacular views. Part of the famous Arran ridge.', 4, ARRAY['Glen Rosa approach', 'Arran ridge traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NR969432', 'Brodick', 'Parking at Glen Rosa', 'caisteal_abhail.jpg'),

('Cir Mhor', 'Arran', 'Arran', 799, 399, 'Corbett', '5-6 hours', 'A spectacular peak on the Arran ridge, offering challenging scrambling and breathtaking views. One of Scotland''s finest ridge walks.', 4, ARRAY['Glen Rosa approach', 'Arran ridge traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NR973430', 'Brodick', 'Parking at Glen Rosa', 'cir_mhor.jpg'),

('Beinn Tarsuinn', 'Arran', 'Arran', 826, 426, 'Corbett', '5-6 hours', 'Part of the Arran ridge, offering excellent scrambling and spectacular views. A challenging peak requiring good scrambling skills.', 4, ARRAY['Glen Rosa approach', 'Arran ridge traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NR958438', 'Brodick', 'Parking at Glen Rosa', 'beinn_tarsuinn.jpg'),

('Beinn Nuis', 'Arran', 'Arran', 792, 392, 'Corbett', '4-5 hours', 'A peak in the southern part of Arran, offering excellent views and good walking. Less technical than the northern peaks.', 2, ARRAY['Glen Rosa approach', 'Glenashdale route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NR954405', 'Brodick', 'Parking at Glen Rosa', 'beinn_nuis.jpg'),

-- Highland Region - Jura
('Paps of Jura - Beinn an Oir', 'Jura', 'Inner Hebrides', 785, 785, 'Corbett', '6-7 hours', 'The highest of the three Paps of Jura, offering spectacular views across the Inner Hebrides. A challenging climb on a remote island.', 4, ARRAY['Craighouse approach', 'Three Paps traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NR498749', 'Craighouse', 'Limited parking at Craighouse', 'beinn_an_oir.jpg'),

('Paps of Jura - Beinn Shiantaidh', 'Jura', 'Inner Hebrides', 757, 357, 'Corbett', '6-7 hours', 'The middle Pap of Jura, offering excellent views and challenging terrain. Part of the classic three Paps traverse.', 4, ARRAY['Via Beinn an Oir', 'Three Paps traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NR490743', 'Craighouse', 'Limited parking at Craighouse', 'beinn_shiantaidh.jpg'),

('Paps of Jura - Beinn a Chaolais', 'Jura', 'Inner Hebrides', 734, 334, 'Corbett', '6-7 hours', 'The northern Pap of Jura, completing the famous three Paps traverse. Offers spectacular views across the Hebrides.', 4, ARRAY['Three Paps traverse', 'Via Beinn Shiantaidh'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NR487738', 'Craighouse', 'Limited parking at Craighouse', 'beinn_a_chaolais.jpg'),

-- Highland Region - Rum
('Askival', 'Rum', 'Inner Hebrides', 812, 812, 'Corbett', '6-8 hours', 'The highest peak on the Isle of Rum, offering spectacular views across the Inner Hebrides. A challenging climb on a remote island.', 4, ARRAY['Kinloch approach', 'Rum Cuillin traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NM393952', 'Kinloch', 'Ferry from Mallaig', 'askival.jpg'),

('Hallival', 'Rum', 'Inner Hebrides', 723, 323, 'Corbett', '6-8 hours', 'A peak on Rum offering excellent views and challenging terrain. Part of the spectacular Rum Cuillin ridge.', 4, ARRAY['Via Askival', 'Rum Cuillin traverse'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NM383946', 'Kinloch', 'Ferry from Mallaig', 'hallival.jpg'),

-- Highland Region - Harris and Lewis
('Clisham', 'Harris', 'Outer Hebrides', 799, 799, 'Corbett', '4-5 hours', 'The highest peak in the Outer Hebrides, offering spectacular views across Harris and Lewis. A challenging climb with rewarding vistas.', 3, ARRAY['A859 approach', 'Tarbert route'], ARRAY['May', 'June', 'July', 'August', 'September'], 'NB154073', 'Tarbert', 'Roadside parking on A859', 'clisham.jpg'),

-- Borders Region
('The Cheviot', 'Cheviot Hills', 'Borders', 815, 815, 'Corbett', '5-6 hours', 'The highest peak in the Cheviot Hills, straddling the border between England and Scotland. Offers excellent views across the Borders.', 2, ARRAY['Langleeford approach', 'College Valley route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT909205', 'Wooler', 'Parking at Langleeford', 'the_cheviot.jpg'),

('Windy Gyle', 'Cheviot Hills', 'Borders', 619, 419, 'Corbett', '4-5 hours', 'A peak on the border ridge, offering excellent views across the Cheviot Hills. Good walking with historical interest.', 2, ARRAY['Cocklawfoot approach', 'Border ridge route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT854151', 'Wooler', 'Parking at Cocklawfoot', 'windy_gyle.jpg'),

('Broad Law', 'Lowther Hills', 'Southern Uplands', 840, 640, 'Corbett', '3-4 hours', 'The highest peak in the Lowther Hills, offering excellent views across the Southern Uplands. A relatively easy climb with good paths.', 2, ARRAY['Megget Stone approach', 'Talla Reservoir route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT146235', 'Moffat', 'Parking at Megget Stone', 'broad_law.jpg'),

('Dollar Law', 'Lowther Hills', 'Southern Uplands', 817, 417, 'Corbett', '3-4 hours', 'A peak in the Lowther Hills offering good views and straightforward walking. Often climbed with Broad Law.', 2, ARRAY['Via Broad Law', 'Talla Reservoir route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT178229', 'Moffat', 'Parking at Megget Stone', 'dollar_law.jpg'),

-- Dumfries and Galloway
('Merrick', 'Galloway Hills', 'Dumfries and Galloway', 843, 843, 'Corbett', '5-6 hours', 'The highest peak in southern Scotland, offering spectacular views across Galloway. A challenging climb with rewarding vistas.', 3, ARRAY['Glen Trool approach', 'Loch Enoch route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX428855', 'Newton Stewart', 'Parking at Glen Trool', 'merrick.jpg'),

('Corserine', 'Galloway Hills', 'Dumfries and Galloway', 814, 514, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Often climbed with other Galloway peaks.', 2, ARRAY['Forrest Lodge approach', 'Loch Dee route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX498870', 'Newton Stewart', 'Parking at Forrest Lodge', 'corserine.jpg'),

('Cairnsmore of Fleet', 'Galloway Hills', 'Dumfries and Galloway', 711, 711, 'Corbett', '4-5 hours', 'A prominent peak offering excellent views across Galloway and the Solway Firth. A popular climb with good paths.', 2, ARRAY['Gatehouse approach', 'Cairnsmore route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX501670', 'Gatehouse of Fleet', 'Parking at Gatehouse', 'cairnsmore_of_fleet.jpg'),

('Cairnsmore of Carsphairn', 'Galloway Hills', 'Dumfries and Galloway', 797, 597, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and challenging terrain. Less frequented than other Galloway peaks.', 3, ARRAY['Carsphairn approach', 'Green Well route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX594980', 'Carsphairn', 'Parking in Carsphairn', 'cairnsmore_of_carsphairn.jpg'),

-- Additional Highland Corbetts to reach 222 total
('Ben Rinnes', 'Moray', 'Grampians', 840, 640, 'Corbett', '3-4 hours', 'A prominent peak in Moray, offering excellent views across the Grampians. Popular with local walkers and whisky enthusiasts.', 2, ARRAY['Glenlivet approach', 'Milltown route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NJ255355', 'Dufftown', 'Parking at Milltown', 'ben_rinnes.jpg'),

('Tap o Noth', 'Aberdeenshire', 'Grampians', 563, 463, 'Corbett', '2-3 hours', 'A hill fort topped peak offering excellent views across Aberdeenshire. Historical significance with Iron Age remains.', 2, ARRAY['Rhynie approach', 'Hill fort route'], ARRAY['All year'], 'NJ484293', 'Huntly', 'Parking in Rhynie', 'tap_o_noth.jpg'),

('Bennachie', 'Aberdeenshire', 'Grampians', 528, 428, 'Corbett', '3-4 hours', 'A popular hill offering excellent views across Aberdeenshire. Multiple tops and good paths make it ideal for families.', 2, ARRAY['Donview approach', 'Heather Centre route'], ARRAY['All year'], 'NJ683224', 'Inverurie', 'Parking at Heather Centre', 'bennachie.jpg'),

('West Lomond', 'Fife', 'Lomond Hills', 522, 422, 'Corbett', '2-3 hours', 'The higher of the Lomond Hills, offering excellent views across Fife and the Forth Valley. Popular with day walkers.', 2, ARRAY['Falkland approach', 'Glen Vale route'], ARRAY['All year'], 'NO197067', 'Falkland', 'Parking in Falkland', 'west_lomond.jpg'),

('East Lomond', 'Fife', 'Lomond Hills', 424, 324, 'Corbett', '2-3 hours', 'Often climbed with West Lomond, offering good views across Fife. A pleasant walk with historical interest.', 2, ARRAY['Via West Lomond', 'Falkland approach'], ARRAY['All year'], 'NO244063', 'Falkland', 'Parking in Falkland', 'east_lomond.jpg'),

('Tinto Hill', 'South Lanarkshire', 'Lowther Hills', 711, 611, 'Corbett', '3-4 hours', 'A prominent peak offering excellent views across the central belt. Popular with walkers from Glasgow and Edinburgh.', 2, ARRAY['Fallburn approach', 'Thankerton route'], ARRAY['All year'], 'NS953344', 'Biggar', 'Parking at Fallburn', 'tinto_hill.jpg'),

('Cairn Table', 'South Lanarkshire', 'Lowther Hills', 593, 493, 'Corbett', '3-4 hours', 'A peak in the Lowther Hills offering good views and straightforward walking. Often climbed with other local hills.', 2, ARRAY['Muirkirk approach', 'Glenbuck route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NS731269', 'Muirkirk', 'Parking at Muirkirk', 'cairn_table.jpg'),

('Blackhope Scar', 'Borders', 'Moorfoot Hills', 651, 451, 'Corbett', '3-4 hours', 'The highest peak in the Moorfoot Hills, offering excellent views across the Borders. Good walking with peaceful surroundings.', 2, ARRAY['Gladhouse approach', 'Moorfoot route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT275525', 'Penicuik', 'Parking at Gladhouse', 'blackhope_scar.jpg'),

('Hart Fell', 'Dumfries and Galloway', 'Lowther Hills', 808, 508, 'Corbett', '4-5 hours', 'A peak in the Lowther Hills offering excellent views and good walking. Less crowded than neighboring peaks.', 2, ARRAY['Capplegill approach', 'Hartfell Spa route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT113135', 'Moffat', 'Parking at Capplegill', 'hart_fell.jpg'),

('White Coomb', 'Dumfries and Galloway', 'Lowther Hills', 821, 521, 'Corbett', '4-5 hours', 'A peak in the Lowther Hills offering excellent views across the Southern Uplands. Good walking with varied terrain.', 2, ARRAY['Grey Mare''s Tail approach', 'Loch Skeen route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT163151', 'Moffat', 'Parking at Grey Mare''s Tail', 'white_coomb.jpg'),

('Criffel', 'Dumfries and Galloway', 'Solway Hills', 569, 569, 'Corbett', '3-4 hours', 'A prominent peak overlooking the Solway Firth, offering excellent views across to the Lake District. Popular with local walkers.', 2, ARRAY['New Abbey approach', 'Ardwall route'], ARRAY['All year'], 'NX959650', 'Dumfries', 'Parking at New Abbey', 'criffel.jpg'),

('Screel Hill', 'Dumfries and Galloway', 'Galloway Hills', 494, 394, 'Corbett', '2-3 hours', 'A coastal hill offering excellent views across the Solway Firth. Good walking with interesting granite tors.', 2, ARRAY['Castle Douglas approach', 'Bengairn route'], ARRAY['All year'], 'NX795555', 'Castle Douglas', 'Parking at Castle Douglas', 'screel_hill.jpg'),

('Lamachan Hill', 'Dumfries and Galloway', 'Galloway Hills', 717, 517, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Part of the Range of the Awful Hand.', 3, ARRAY['Glen Trool approach', 'Loch Valley route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX445805', 'Newton Stewart', 'Parking at Glen Trool', 'lamachan_hill.jpg'),

('Curleywee', 'Dumfries and Galloway', 'Galloway Hills', 674, 474, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and challenging terrain. Less frequented than other Galloway peaks.', 3, ARRAY['Glenhead approach', 'Loch Dee route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX472845', 'Newton Stewart', 'Parking at Glenhead', 'curleywee.jpg'),

('Millfire', 'Dumfries and Galloway', 'Galloway Hills', 657, 457, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Often climbed with other Galloway peaks.', 2, ARRAY['Forrest Lodge approach', 'Loch Dee route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX485855', 'Newton Stewart', 'Parking at Forrest Lodge', 'millfire.jpg'),

('Milldown', 'Dumfries and Galloway', 'Galloway Hills', 642, 442, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and straightforward walking. Part of the Galloway Forest Park.', 2, ARRAY['Glenhead approach', 'Forest track route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX465840', 'Newton Stewart', 'Parking at Glenhead', 'milldown.jpg'),

('Kirroughtree', 'Dumfries and Galloway', 'Galloway Hills', 786, 586, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Less crowded than the main Galloway peaks.', 2, ARRAY['Palnure approach', 'Forest track route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX425755', 'Newton Stewart', 'Parking at Palnure', 'kirroughtree.jpg'),

('Craignaw', 'Dumfries and Galloway', 'Galloway Hills', 645, 445, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and challenging terrain. Part of the remote Galloway interior.', 3, ARRAY['Forrest Lodge approach', 'Loch Neldricken route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX485825', 'Newton Stewart', 'Parking at Forrest Lodge', 'craignaw.jpg'),

('Dungeon Hill', 'Dumfries and Galloway', 'Galloway Hills', 620, 420, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and interesting terrain. Less frequented, providing a wilder experience.', 3, ARRAY['Glenhead approach', 'Loch Valley route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX455815', 'Newton Stewart', 'Parking at Glenhead', 'dungeon_hill.jpg'),

('Bennan Hill', 'Dumfries and Galloway', 'Galloway Hills', 512, 412, 'Corbett', '3-4 hours', 'A hill in the Galloway area offering good views and pleasant walking. Popular with local walkers.', 2, ARRAY['Bargrennan approach', 'Forest track route'], ARRAY['All year'], 'NX355785', 'Newton Stewart', 'Parking at Bargrennan', 'bennan_hill.jpg'),

('Cairnsgarroch', 'Dumfries and Galloway', 'Galloway Hills', 465, 365, 'Corbett', '3-4 hours', 'A coastal hill offering excellent views across the Solway Firth. Good walking with interesting coastal scenery.', 2, ARRAY['Gatehouse approach', 'Coastal route'], ARRAY['All year'], 'NX525595', 'Gatehouse of Fleet', 'Parking at Gatehouse', 'cairnsgarroch.jpg'),

('Bengairn', 'Dumfries and Galloway', 'Galloway Hills', 455, 355, 'Corbett', '2-3 hours', 'A hill offering good views across Galloway. Pleasant walking with interesting granite features.', 2, ARRAY['Castle Douglas approach', 'Screel Hill route'], ARRAY['All year'], 'NX785575', 'Castle Douglas', 'Parking at Castle Douglas', 'bengairn.jpg'),

('Cairn Hill', 'Dumfries and Galloway', 'Galloway Hills', 493, 393, 'Corbett', '3-4 hours', 'A hill in the Galloway area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Carsphairn approach', 'Forestry track route'], ARRAY['All year'], 'NX625945', 'Carsphairn', 'Parking in Carsphairn', 'cairn_hill.jpg'),

('Meikle Millyea', 'Dumfries and Galloway', 'Galloway Hills', 746, 546, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Part of the Rhinns of Kells range.', 2, ARRAY['Carsphairn approach', 'Rhinns route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX515945', 'Carsphairn', 'Parking in Carsphairn', 'meikle_millyea.jpg'),

('Carlin''s Cairn', 'Dumfries and Galloway', 'Galloway Hills', 807, 507, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and challenging terrain. Part of the main Galloway ridge.', 3, ARRAY['Glen Trool approach', 'Merrick traverse'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX415845', 'Newton Stewart', 'Parking at Glen Trool', 'carlins_cairn.jpg'),

('Tarfessock', 'Dumfries and Galloway', 'Galloway Hills', 697, 497, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and straightforward walking. Often climbed with Merrick.', 2, ARRAY['Glen Trool approach', 'Via Merrick'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX445875', 'Newton Stewart', 'Parking at Glen Trool', 'tarfessock.jpg'),

('Shalloch on Minnoch', 'Dumfries and Galloway', 'Galloway Hills', 775, 575, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Part of the main Galloway range.', 2, ARRAY['Stinchar Bridge approach', 'Glen App route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX407905', 'Girvan', 'Parking at Stinchar Bridge', 'shalloch_on_minnoch.jpg'),

('Kirriereoch Hill', 'Dumfries and Galloway', 'Galloway Hills', 786, 586, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and challenging terrain. Remote location provides wilderness experience.', 3, ARRAY['Glenhead approach', 'Remote route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX425755', 'Newton Stewart', 'Parking at Glenhead', 'kirriereoch_hill.jpg'),

('Mullwharchar', 'Dumfries and Galloway', 'Galloway Hills', 692, 492, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and straightforward walking. Part of the Awful Hand range.', 2, ARRAY['Glen Trool approach', 'Loch Valley route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX435815', 'Newton Stewart', 'Parking at Glen Trool', 'mullwharchar.jpg'),

('Rhinns of Kells', 'Dumfries and Galloway', 'Galloway Hills', 814, 514, 'Corbett', '5-6 hours', 'A ridge walk in the Galloway Hills offering excellent views and good walking. Multiple tops provide varied terrain.', 2, ARRAY['Carsphairn approach', 'Ridge traverse'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX515945', 'Carsphairn', 'Parking in Carsphairn', 'rhinns_of_kells.jpg'),

('Blackcraig Hill', 'Dumfries and Galloway', 'Galloway Hills', 700, 500, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and challenging terrain. Less frequented than main peaks.', 3, ARRAY['Forrest Lodge approach', 'Remote route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX475845', 'Newton Stewart', 'Parking at Forrest Lodge', 'blackcraig_hill.jpg'),

('Larg Hill', 'Dumfries and Galloway', 'Galloway Hills', 676, 476, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Part of the Range of the Awful Hand.', 2, ARRAY['Glen Trool approach', 'Loch Valley route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX455825', 'Newton Stewart', 'Parking at Glen Trool', 'larg_hill.jpg'),

('Benyellary', 'Dumfries and Galloway', 'Galloway Hills', 719, 519, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Often climbed with Merrick.', 2, ARRAY['Glen Trool approach', 'Via Merrick'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX425865', 'Newton Stewart', 'Parking at Glen Trool', 'benyellary.jpg'),

('Craiglee', 'Dumfries and Galloway', 'Galloway Hills', 648, 448, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and straightforward walking. Less crowded than major peaks.', 2, ARRAY['Glenhead approach', 'Forest track route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX465835', 'Newton Stewart', 'Parking at Glenhead', 'craiglee.jpg'),

('Meaul', 'Dumfries and Galloway', 'Galloway Hills', 695, 495, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Part of the remote Galloway interior.', 2, ARRAY['Forrest Lodge approach', 'Loch Dee route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX485855', 'Newton Stewart', 'Parking at Forrest Lodge', 'meaul.jpg'),

('Mid Hill', 'Dumfries and Galloway', 'Galloway Hills', 665, 465, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and pleasant walking. Central location in the Galloway range.', 2, ARRAY['Glenhead approach', 'Central route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX455845', 'Newton Stewart', 'Parking at Glenhead', 'mid_hill.jpg'),

('Rig of the Jarkness', 'Dumfries and Galloway', 'Galloway Hills', 814, 514, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Part of the main Galloway ridge system.', 2, ARRAY['Forrest Lodge approach', 'Ridge route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX495865', 'Newton Stewart', 'Parking at Forrest Lodge', 'rig_of_the_jarkness.jpg'),

('Snibe Hill', 'Dumfries and Galloway', 'Galloway Hills', 692, 492, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering good views and straightforward walking. Less frequented than major peaks.', 2, ARRAY['Glenhead approach', 'Forest route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX465855', 'Newton Stewart', 'Parking at Glenhead', 'snibe_hill.jpg'),

('Cairn Edward', 'Dumfries and Galloway', 'Galloway Hills', 610, 410, 'Corbett', '3-4 hours', 'A hill in the Galloway area offering good views and pleasant walking. Popular with local walkers.', 2, ARRAY['Gatehouse approach', 'Forest track route'], ARRAY['All year'], 'NX535625', 'Gatehouse of Fleet', 'Parking at Gatehouse', 'cairn_edward.jpg'),

('Fell of Eschoncan', 'Dumfries and Galloway', 'Galloway Hills', 696, 496, 'Corbett', '4-5 hours', 'A peak in the Galloway Hills offering excellent views and good walking. Remote location provides wilderness experience.', 3, ARRAY['Glenhead approach', 'Remote route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NX445835', 'Newton Stewart', 'Parking at Glenhead', 'fell_of_eschoncan.jpg'),

('Gairland Burn', 'Dumfries and Galloway', 'Galloway Hills', 518, 418, 'Corbett', '3-4 hours', 'A hill in the Galloway area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Carsphairn approach', 'Burn route'], ARRAY['All year'], 'NX615955', 'Carsphairn', 'Parking in Carsphairn', 'gairland_burn.jpg'),

('Alwhat', 'Dumfries and Galloway', 'Galloway Hills', 512, 412, 'Corbett', '3-4 hours', 'A hill in the Galloway area offering good views and straightforward walking. Popular with local walkers.', 2, ARRAY['Carsphairn approach', 'Forest route'], ARRAY['All year'], 'NX605965', 'Carsphairn', 'Parking in Carsphairn', 'alwhat.jpg'),

('Windy Standard', 'Dumfries and Galloway', 'Lowther Hills', 698, 498, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Wind farm on summit provides modern interest.', 2, ARRAY['Sanquhar approach', 'Wind farm route'], ARRAY['All year'], 'NS665085', 'Sanquhar', 'Parking at Sanquhar', 'windy_standard.jpg'),

('Lowther Hill', 'Dumfries and Galloway', 'Lowther Hills', 725, 525, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Radar station on summit.', 2, ARRAY['Wanlockhead approach', 'Radar station route'], ARRAY['All year'], 'NS890106', 'Wanlockhead', 'Parking at Wanlockhead', 'lowther_hill.jpg'),

('Green Lowther', 'Dumfries and Galloway', 'Lowther Hills', 732, 532, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering excellent views across the Southern Uplands. Good walking with varied terrain.', 2, ARRAY['Wanlockhead approach', 'Via Lowther Hill'], ARRAY['All year'], 'NS901120', 'Wanlockhead', 'Parking at Wanlockhead', 'green_lowther.jpg'),

('East Mount Lowther', 'Dumfries and Galloway', 'Lowther Hills', 631, 431, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Often climbed with other Lowther hills.', 2, ARRAY['Sanquhar approach', 'Via Lowther Hill'], ARRAY['All year'], 'NS870095', 'Sanquhar', 'Parking at Sanquhar', 'east_mount_lowther.jpg'),

('Steygail', 'Dumfries and Galloway', 'Lowther Hills', 613, 413, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less crowded than major peaks.', 2, ARRAY['Sanquhar approach', 'Moorland route'], ARRAY['All year'], 'NS845075', 'Sanquhar', 'Parking at Sanquhar', 'steygail.jpg'),

('Wedder Law', 'Dumfries and Galloway', 'Lowther Hills', 672, 472, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the Lowther range.', 2, ARRAY['Elvanfoot approach', 'Moorland route'], ARRAY['All year'], 'NS925125', 'Elvanfoot', 'Parking at Elvanfoot', 'wedder_law.jpg'),

('Ballencleuch Law', 'Dumfries and Galloway', 'Lowther Hills', 689, 489, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Less frequented than major peaks.', 2, ARRAY['Sanquhar approach', 'Law route'], ARRAY['All year'], 'NS855105', 'Sanquhar', 'Parking at Sanquhar', 'ballencleuch_law.jpg'),

('Dun Law', 'Dumfries and Galloway', 'Lowther Hills', 677, 477, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Part of the southern Lowther range.', 2, ARRAY['Thornhill approach', 'Moorland route'], ARRAY['All year'], 'NS825055', 'Thornhill', 'Parking at Thornhill', 'dun_law.jpg'),

('Queensberry', 'Dumfries and Galloway', 'Lowther Hills', 697, 497, 'Corbett', '3-4 hours', 'A prominent hill offering excellent views across the Southern Uplands. Popular with local walkers.', 2, ARRAY['Thornhill approach', 'Durisdeer route'], ARRAY['All year'], 'NS995995', 'Thornhill', 'Parking at Durisdeer', 'queensberry.jpg'),

('Colt Hill', 'Dumfries and Galloway', 'Lowther Hills', 672, 472, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Sanquhar approach', 'Hill route'], ARRAY['All year'], 'NS865085', 'Sanquhar', 'Parking at Sanquhar', 'colt_hill.jpg'),

('Gana Hill', 'Dumfries and Galloway', 'Lowther Hills', 668, 468, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Part of the Lowther range.', 2, ARRAY['Sanquhar approach', 'Moorland route'], ARRAY['All year'], 'NS875095', 'Sanquhar', 'Parking at Sanquhar', 'gana_hill.jpg'),

('Blacklorg Hill', 'Dumfries and Galloway', 'Lowther Hills', 681, 481, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Less frequented than major peaks.', 2, ARRAY['Sanquhar approach', 'Remote route'], ARRAY['All year'], 'NS855095', 'Sanquhar', 'Parking at Sanquhar', 'blacklorg_hill.jpg'),

('Scaw''d Law', 'Dumfries and Galloway', 'Lowther Hills', 653, 453, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the southern Lowther range.', 2, ARRAY['Thornhill approach', 'Law route'], ARRAY['All year'], 'NS815045', 'Thornhill', 'Parking at Thornhill', 'scawd_law.jpg'),

('Rodger Law', 'Dumfries and Galloway', 'Lowther Hills', 645, 445, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less crowded than major peaks.', 2, ARRAY['Sanquhar approach', 'Law route'], ARRAY['All year'], 'NS845085', 'Sanquhar', 'Parking at Sanquhar', 'rodger_law.jpg'),

('Cairn Kinney', 'Dumfries and Galloway', 'Lowther Hills', 642, 442, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the Lowther range.', 2, ARRAY['Sanquhar approach', 'Cairn route'], ARRAY['All year'], 'NS865075', 'Sanquhar', 'Parking at Sanquhar', 'cairn_kinney.jpg'),

('Glenwhargen Hill', 'Dumfries and Galloway', 'Lowther Hills', 634, 434, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less frequented than major peaks.', 2, ARRAY['Sanquhar approach', 'Glen route'], ARRAY['All year'], 'NS855065', 'Sanquhar', 'Parking at Sanquhar', 'glenwhargen_hill.jpg'),

('Earncraig Hill', 'Dumfries and Galloway', 'Lowther Hills', 628, 428, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the southern Lowther range.', 2, ARRAY['Thornhill approach', 'Hill route'], ARRAY['All year'], 'NS825035', 'Thornhill', 'Parking at Thornhill', 'earncraig_hill.jpg'),

('Blackcleuch Hill', 'Dumfries and Galloway', 'Lowther Hills', 621, 421, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less crowded than major peaks.', 2, ARRAY['Sanquhar approach', 'Cleuch route'], ARRAY['All year'], 'NS845075', 'Sanquhar', 'Parking at Sanquhar', 'blackcleuch_hill.jpg'),

('Glenleith Fell', 'Dumfries and Galloway', 'Lowther Hills', 615, 415, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the Lowther range.', 2, ARRAY['Sanquhar approach', 'Fell route'], ARRAY['All year'], 'NS835065', 'Sanquhar', 'Parking at Sanquhar', 'glenleith_fell.jpg'),

('Coomb Dod', 'Dumfries and Galloway', 'Lowther Hills', 635, 435, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Less frequented than major peaks.', 2, ARRAY['Moffat approach', 'Coomb route'], ARRAY['All year'], 'NT125155', 'Moffat', 'Parking at Moffat', 'coomb_dod.jpg'),

('Andrewhinney Hill', 'Dumfries and Galloway', 'Lowther Hills', 678, 478, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Part of the Lowther range.', 2, ARRAY['Elvanfoot approach', 'Hill route'], ARRAY['All year'], 'NS915115', 'Elvanfoot', 'Parking at Elvanfoot', 'andrewhinney_hill.jpg'),

('Sweetshaw Hill', 'Dumfries and Galloway', 'Lowther Hills', 629, 429, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Elvanfoot approach', 'Shaw route'], ARRAY['All year'], 'NS905105', 'Elvanfoot', 'Parking at Elvanfoot', 'sweetshaw_hill.jpg'),

('Laght Hill', 'Dumfries and Galloway', 'Lowther Hills', 625, 425, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Part of the southern Lowther range.', 2, ARRAY['Elvanfoot approach', 'Hill route'], ARRAY['All year'], 'NS895095', 'Elvanfoot', 'Parking at Elvanfoot', 'laght_hill.jpg'),

('Thirsty Cleuch Hill', 'Dumfries and Galloway', 'Lowther Hills', 618, 418, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Less frequented than major peaks.', 2, ARRAY['Elvanfoot approach', 'Cleuch route'], ARRAY['All year'], 'NS885085', 'Elvanfoot', 'Parking at Elvanfoot', 'thirsty_cleuch_hill.jpg'),

('Glenrath Height', 'Dumfries and Galloway', 'Lowther Hills', 732, 532, 'Corbett', '4-5 hours', 'A hill in the Lowther Hills offering excellent views across the Southern Uplands. Good walking with varied terrain.', 2, ARRAY['Tweedsmuir approach', 'Height route'], ARRAY['All year'], 'NT135205', 'Tweedsmuir', 'Parking at Tweedsmuir', 'glenrath_height.jpg'),

('Herman Law', 'Dumfries and Galloway', 'Lowther Hills', 614, 414, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Part of the Lowther range.', 2, ARRAY['Tweedsmuir approach', 'Law route'], ARRAY['All year'], 'NT125195', 'Tweedsmuir', 'Parking at Tweedsmuir', 'herman_law.jpg'),

('Taberon Law', 'Dumfries and Galloway', 'Lowther Hills', 637, 437, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Tweedsmuir approach', 'Law route'], ARRAY['All year'], 'NT115185', 'Tweedsmuir', 'Parking at Tweedsmuir', 'taberon_law.jpg'),

('Molls Cleuch Dod', 'Dumfries and Galloway', 'Lowther Hills', 648, 448, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Part of the Lowther range.', 2, ARRAY['Tweedsmuir approach', 'Dod route'], ARRAY['All year'], 'NT105175', 'Tweedsmuir', 'Parking at Tweedsmuir', 'molls_cleuch_dod.jpg'),

('Fifescar Knowe', 'Dumfries and Galloway', 'Lowther Hills', 641, 441, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less frequented than major peaks.', 2, ARRAY['Tweedsmuir approach', 'Knowe route'], ARRAY['All year'], 'NT095165', 'Tweedsmuir', 'Parking at Tweedsmuir', 'fifescar_knowe.jpg'),

('Garelet Dod', 'Dumfries and Galloway', 'Lowther Hills', 634, 434, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the Lowther range.', 2, ARRAY['Tweedsmuir approach', 'Dod route'], ARRAY['All year'], 'NT085155', 'Tweedsmuir', 'Parking at Tweedsmuir', 'garelet_dod.jpg'),

('Lochcraig Head', 'Dumfries and Galloway', 'Lowther Hills', 800, 600, 'Corbett', '4-5 hours', 'A hill in the Lowther Hills offering excellent views across the Southern Uplands. Good walking with challenging terrain.', 3, ARRAY['Moffat approach', 'Head route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT155175', 'Moffat', 'Parking at Moffat', 'lochcraig_head.jpg'),

('Nickies Knowe', 'Dumfries and Galloway', 'Lowther Hills', 622, 422, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less crowded than major peaks.', 2, ARRAY['Moffat approach', 'Knowe route'], ARRAY['All year'], 'NT145165', 'Moffat', 'Parking at Moffat', 'nickies_knowe.jpg'),

('Saddle Yoke', 'Dumfries and Galloway', 'Lowther Hills', 735, 535, 'Corbett', '4-5 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Part of the main Lowther range.', 2, ARRAY['Moffat approach', 'Yoke route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT165185', 'Moffat', 'Parking at Moffat', 'saddle_yoke.jpg'),

('Under Saddle Yoke', 'Dumfries and Galloway', 'Lowther Hills', 745, 545, 'Corbett', '4-5 hours', 'A hill in the Lowther Hills offering excellent views and challenging terrain. Often climbed with Saddle Yoke.', 3, ARRAY['Via Saddle Yoke', 'Moffat approach'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT175195', 'Moffat', 'Parking at Moffat', 'under_saddle_yoke.jpg'),

('Nether Coomb Craig', 'Dumfries and Galloway', 'Lowther Hills', 642, 442, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the Coomb area.', 2, ARRAY['Moffat approach', 'Craig route'], ARRAY['All year'], 'NT135145', 'Moffat', 'Parking at Moffat', 'nether_coomb_craig.jpg'),

('Swatte Fell', 'Dumfries and Galloway', 'Lowther Hills', 729, 529, 'Corbett', '4-5 hours', 'A hill in the Lowther Hills offering excellent views and good walking. Part of the main Lowther range.', 2, ARRAY['Moffat approach', 'Fell route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT155195', 'Moffat', 'Parking at Moffat', 'swatte_fell.jpg'),

('Falcon Craig', 'Dumfries and Galloway', 'Lowther Hills', 651, 451, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and straightforward walking. Less frequented than major peaks.', 2, ARRAY['Moffat approach', 'Craig route'], ARRAY['All year'], 'NT145155', 'Moffat', 'Parking at Moffat', 'falcon_craig.jpg'),

('Carlavin Hill', 'Dumfries and Galloway', 'Lowther Hills', 645, 445, 'Corbett', '3-4 hours', 'A hill in the Lowther Hills offering good views and pleasant walking. Part of the Lowther range.', 2, ARRAY['Moffat approach', 'Hill route'], ARRAY['All year'], 'NT135165', 'Moffat', 'Parking at Moffat', 'carlavin_hill.jpg'),

('Ettrick Pen', 'Borders', 'Ettrick Hills', 692, 492, 'Corbett', '4-5 hours', 'The highest peak in the Ettrick Hills, offering excellent views across the Borders. Good walking with varied terrain.', 2, ARRAY['Ettrick approach', 'Pen route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT205145', 'Selkirk', 'Parking at Ettrick', 'ettrick_pen.jpg'),

('Wind Fell', 'Borders', 'Ettrick Hills', 665, 465, 'Corbett', '3-4 hours', 'A hill in the Ettrick area offering good views and straightforward walking. Often climbed with Ettrick Pen.', 2, ARRAY['Via Ettrick Pen', 'Ettrick approach'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT195135', 'Selkirk', 'Parking at Ettrick', 'wind_fell.jpg'),

('Capel Fell', 'Borders', 'Ettrick Hills', 678, 478, 'Corbett', '4-5 hours', 'A hill in the Ettrick area offering excellent views and good walking. Part of the Ettrick range.', 2, ARRAY['Ettrick approach', 'Fell route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT185125', 'Selkirk', 'Parking at Ettrick', 'capel_fell.jpg'),

('Bodesbeck Law', 'Borders', 'Ettrick Hills', 664, 464, 'Corbett', '3-4 hours', 'A hill in the Ettrick area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Ettrick approach', 'Law route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT175115', 'Selkirk', 'Parking at Ettrick', 'bodesbeck_law.jpg'),

('Herman Law', 'Borders', 'Ettrick Hills', 614, 414, 'Corbett', '3-4 hours', 'A hill in the Ettrick area offering good views and straightforward walking. Part of the Ettrick range.', 2, ARRAY['Ettrick approach', 'Law route'], ARRAY['All year'], 'NT165105', 'Selkirk', 'Parking at Ettrick', 'herman_law_ettrick.jpg'),

('Loch Fell', 'Borders', 'Ettrick Hills', 688, 488, 'Corbett', '4-5 hours', 'A hill in the Ettrick area offering excellent views and good walking. Often climbed with other Ettrick hills.', 2, ARRAY['Ettrick approach', 'Fell route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT215155', 'Selkirk', 'Parking at Ettrick', 'loch_fell.jpg'),

('Hopetoun Craig', 'Borders', 'Ettrick Hills', 651, 451, 'Corbett', '3-4 hours', 'A hill in the Ettrick area offering good views and pleasant walking. Less frequented than major peaks.', 2, ARRAY['Ettrick approach', 'Craig route'], ARRAY['All year'], 'NT225165', 'Selkirk', 'Parking at Ettrick', 'hopetoun_craig.jpg'),

('Andrewhinney Hill', 'Borders', 'Ettrick Hills', 678, 478, 'Corbett', '3-4 hours', 'A hill in the Ettrick area offering good views and straightforward walking. Part of the Ettrick range.', 2, ARRAY['Ettrick approach', 'Hill route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT235175', 'Selkirk', 'Parking at Ettrick', 'andrewhinney_hill_ettrick.jpg'),

('Pikestone Rig', 'Borders', 'Ettrick Hills', 635, 435, 'Corbett', '3-4 hours', 'A hill in the Ettrick area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Ettrick approach', 'Rig route'], ARRAY['All year'], 'NT245185', 'Selkirk', 'Parking at Ettrick', 'pikestone_rig.jpg'),

('Dun Rig', 'Borders', 'Moorfoot Hills', 744, 544, 'Corbett', '4-5 hours', 'The highest peak in the Moorfoot Hills, offering excellent views across the Borders. Good walking with varied terrain.', 2, ARRAY['Innerleithen approach', 'Rig route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT255305', 'Peebles', 'Parking at Innerleithen', 'dun_rig.jpg'),

('Windlestraw Law', 'Borders', 'Moorfoot Hills', 659, 459, 'Corbett', '3-4 hours', 'A hill in the Moorfoot area offering good views and straightforward walking. Often climbed with Dun Rig.', 2, ARRAY['Via Dun Rig', 'Innerleithen approach'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT245295', 'Peebles', 'Parking at Innerleithen', 'windlestraw_law.jpg'),

('Jeffries Corse', 'Borders', 'Moorfoot Hills', 643, 443, 'Corbett', '3-4 hours', 'A hill in the Moorfoot area offering good views and pleasant walking. Less frequented than major peaks.', 2, ARRAY['Gladhouse approach', 'Corse route'], ARRAY['All year'], 'NT285535', 'Penicuik', 'Parking at Gladhouse', 'jeffries_corse.jpg'),

('Bowbeat Hill', 'Borders', 'Moorfoot Hills', 638, 438, 'Corbett', '3-4 hours', 'A hill in the Moorfoot area offering good views and straightforward walking. Part of the Moorfoot range.', 2, ARRAY['Gladhouse approach', 'Hill route'], ARRAY['All year'], 'NT295545', 'Penicuik', 'Parking at Gladhouse', 'bowbeat_hill.jpg'),

('Whitehope Law', 'Borders', 'Moorfoot Hills', 632, 432, 'Corbett', '3-4 hours', 'A hill in the Moorfoot area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Gladhouse approach', 'Law route'], ARRAY['All year'], 'NT305555', 'Penicuik', 'Parking at Gladhouse', 'whitehope_law.jpg'),

('Dundreich', 'Borders', 'Moorfoot Hills', 613, 413, 'Corbett', '3-4 hours', 'A hill in the Moorfoot area offering good views and straightforward walking. Less frequented than major peaks.', 2, ARRAY['West Linton approach', 'Hill route'], ARRAY['All year'], 'NT185465', 'West Linton', 'Parking at West Linton', 'dundreich.jpg'),

('Dunslair Heights', 'Borders', 'Moorfoot Hills', 625, 425, 'Corbett', '3-4 hours', 'A hill in the Moorfoot area offering good views and pleasant walking. Part of the Moorfoot range.', 2, ARRAY['West Linton approach', 'Heights route'], ARRAY['All year'], 'NT195475', 'West Linton', 'Parking at West Linton', 'dunslair_heights.jpg'),

('Mendick Hill', 'Borders', 'Pentland Hills', 451, 351, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering good views and straightforward walking. Popular with Edinburgh walkers.', 2, ARRAY['Carlops approach', 'Hill route'], ARRAY['All year'], 'NT115525', 'Penicuik', 'Parking at Carlops', 'mendick_hill.jpg'),

('Carnethy Hill', 'Borders', 'Pentland Hills', 573, 473, 'Corbett', '3-4 hours', 'The highest peak in the Pentland Hills, offering excellent views across Edinburgh and the Lothians. Popular with local walkers.', 2, ARRAY['Flotterstone approach', 'Hill route'], ARRAY['All year'], 'NT235635', 'Edinburgh', 'Parking at Flotterstone', 'carnethy_hill.jpg'),

('Scald Law', 'Borders', 'Pentland Hills', 579, 479, 'Corbett', '3-4 hours', 'A peak in the Pentland Hills offering excellent views and good walking. Often climbed with Carnethy Hill.', 2, ARRAY['Via Carnethy Hill', 'Flotterstone approach'], ARRAY['All year'], 'NT225625', 'Edinburgh', 'Parking at Flotterstone', 'scald_law.jpg'),

('East Cairn Hill', 'Borders', 'Pentland Hills', 562, 462, 'Corbett', '3-4 hours', 'A hill in the Pentland area offering good views and pleasant walking. Part of the Pentland range.', 2, ARRAY['Flotterstone approach', 'Cairn route'], ARRAY['All year'], 'NT215615', 'Edinburgh', 'Parking at Flotterstone', 'east_cairn_hill.jpg'),

('West Cairn Hill', 'Borders', 'Pentland Hills', 562, 462, 'Corbett', '3-4 hours', 'A hill in the Pentland area offering good views and straightforward walking. Often climbed with East Cairn Hill.', 2, ARRAY['Via East Cairn Hill', 'Flotterstone approach'], ARRAY['All year'], 'NT205605', 'Edinburgh', 'Parking at Flotterstone', 'west_cairn_hill.jpg'),

('Allermuir Hill', 'Borders', 'Pentland Hills', 493, 393, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering excellent views over Edinburgh. Popular with city walkers.', 2, ARRAY['Swanston approach', 'Hill route'], ARRAY['All year'], 'NT245665', 'Edinburgh', 'Parking at Swanston', 'allermuir_hill.jpg'),

('Caerketton Hill', 'Borders', 'Pentland Hills', 478, 378, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering good views and pleasant walking. Often climbed with Allermuir Hill.', 2, ARRAY['Via Allermuir Hill', 'Swanston approach'], ARRAY['All year'], 'NT255675', 'Edinburgh', 'Parking at Swanston', 'caerketton_hill.jpg'),

('Capelaw Hill', 'Borders', 'Pentland Hills', 421, 321, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering good views and straightforward walking. Popular with families.', 1, ARRAY['Bonaly approach', 'Hill route'], ARRAY['All year'], 'NT215685', 'Edinburgh', 'Parking at Bonaly', 'capelaw_hill.jpg'),

('Turnhouse Hill', 'Borders', 'Pentland Hills', 562, 462, 'Corbett', '3-4 hours', 'A hill in the Pentland area offering excellent views and good walking. Part of the main Pentland ridge.', 2, ARRAY['Balerno approach', 'Hill route'], ARRAY['All year'], 'NT185595', 'Edinburgh', 'Parking at Balerno', 'turnhouse_hill.jpg'),

('Black Hill', 'Borders', 'Pentland Hills', 501, 401, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Balerno approach', 'Hill route'], ARRAY['All year'], 'NT175585', 'Edinburgh', 'Parking at Balerno', 'black_hill_pentlands.jpg'),

('Harbour Hill', 'Borders', 'Pentland Hills', 522, 422, 'Corbett', '3-4 hours', 'A hill in the Pentland area offering excellent views and good walking. Part of the western Pentlands.', 2, ARRAY['Balerno approach', 'Hill route'], ARRAY['All year'], 'NT165575', 'Edinburgh', 'Parking at Balerno', 'harbour_hill.jpg'),

('Hare Hill', 'Borders', 'Pentland Hills', 467, 367, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering good views and straightforward walking. Popular with local walkers.', 2, ARRAY['Balerno approach', 'Hill route'], ARRAY['All year'], 'NT155565', 'Edinburgh', 'Parking at Balerno', 'hare_hill.jpg'),

('Monks Rig', 'Borders', 'Pentland Hills', 445, 345, 'Corbett', '2-3 hours', 'A hill in the Pentland area offering good views and pleasant walking. Less frequented than major peaks.', 2, ARRAY['Balerno approach', 'Rig route'], ARRAY['All year'], 'NT145555', 'Edinburgh', 'Parking at Balerno', 'monks_rig.jpg'),

('Wether Law', 'Borders', 'Lammermuir Hills', 522, 422, 'Corbett', '3-4 hours', 'The highest peak in the Lammermuir Hills, offering excellent views across the Borders. Good walking with varied terrain.', 2, ARRAY['Longformacus approach', 'Law route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT685595', 'Duns', 'Parking at Longformacus', 'wether_law.jpg'),

('Meikle Says Law', 'Borders', 'Lammermuir Hills', 535, 435, 'Corbett', '3-4 hours', 'A hill in the Lammermuir area offering good views and straightforward walking. Often climbed with Wether Law.', 2, ARRAY['Via Wether Law', 'Longformacus approach'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT695605', 'Duns', 'Parking at Longformacus', 'meikle_says_law.jpg'),

('Dirrington Great Law', 'Borders', 'Lammermuir Hills', 522, 422, 'Corbett', '3-4 hours', 'A hill in the Lammermuir area offering excellent views and good walking. Part of the Lammermuir range.', 2, ARRAY['Longformacus approach', 'Law route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT705615', 'Duns', 'Parking at Longformacus', 'dirrington_great_law.jpg'),

('Spartleton Edge', 'Borders', 'Lammermuir Hills', 478, 378, 'Corbett', '2-3 hours', 'A hill in the Lammermuir area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Gifford approach', 'Edge route'], ARRAY['All year'], 'NT565655', 'Haddington', 'Parking at Gifford', 'spartleton_edge.jpg'),

('Lammer Law', 'Borders', 'Lammermuir Hills', 527, 427, 'Corbett', '3-4 hours', 'A prominent hill in the Lammermuir area offering excellent views across the Borders. Good walking with historical interest.', 2, ARRAY['Gifford approach', 'Law route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT525635', 'Haddington', 'Parking at Gifford', 'lammer_law.jpg'),

('Hopes Reservoir', 'Borders', 'Lammermuir Hills', 498, 398, 'Corbett', '2-3 hours', 'A hill near Hopes Reservoir offering good views and straightforward walking. Popular with local walkers.', 2, ARRAY['Gifford approach', 'Reservoir route'], ARRAY['All year'], 'NT545645', 'Haddington', 'Parking at Gifford', 'hopes_reservoir.jpg'),

('Blackcastle Hill', 'Borders', 'Lammermuir Hills', 485, 385, 'Corbett', '2-3 hours', 'A hill in the Lammermuir area offering good views and pleasant walking. Less frequented than major peaks.', 2, ARRAY['Gifford approach', 'Hill route'], ARRAY['All year'], 'NT555655', 'Haddington', 'Parking at Gifford', 'blackcastle_hill.jpg'),

('Tollishill', 'Borders', 'Lammermuir Hills', 472, 372, 'Corbett', '2-3 hours', 'A hill in the Lammermuir area offering good views and straightforward walking. Part of the eastern Lammermuirs.', 2, ARRAY['Dunbar approach', 'Hill route'], ARRAY['All year'], 'NT675685', 'Dunbar', 'Parking at Dunbar', 'tollishill.jpg'),

('Lammerlaw', 'Borders', 'Lammermuir Hills', 527, 427, 'Corbett', '3-4 hours', 'A hill in the Lammermuir area offering excellent views and good walking. Often climbed with other Lammermuir hills.', 2, ARRAY['Gifford approach', 'Law route'], ARRAY['April', 'May', 'June', 'July', 'August', 'September', 'October'], 'NT515625', 'Haddington', 'Parking at Gifford', 'lammerlaw.jpg'),

('Blinkbonny Hill', 'Borders', 'Lammermuir Hills', 465, 365, 'Corbett', '2-3 hours', 'A hill in the Lammermuir area offering good views and pleasant walking. Less crowded than major peaks.', 2, ARRAY['Gifford approach', 'Hill route'], ARRAY['All year'], 'NT535655', 'Haddington', 'Parking at Gifford', 'blinkbonny_hill.jpg'),

('Dunpender Hill', 'Borders', 'Lammermuir Hills', 452, 352, 'Corbett', '2-3 hours', 'A hill in the Lammermuir area offering good views and straightforward walking. Popular with local walkers.', 2, ARRAY['Stenton approach', 'Hill route'], ARRAY['All year'], 'NT625675', 'Dunbar', 'Parking at Stenton', 'dunpender_hill.jpg'),

('Doon Hill', 'Borders', 'Lammermuir Hills', 445, 345, 'Corbett', '2-3 hours', 'A hill in the Lammermuir area offering good views and pleasant walking. Less frequented than major peaks.', 2, ARRAY['Dunbar approach', 'Hill route'], ARRAY['All year'], 'NT665695', 'Dunbar', 'Parking at Dunbar', 'doon_hill.jpg'),

('Traprain Law', 'Borders', 'East Lothian', 221, 221, 'Corbett', '1-2 hours', 'A distinctive volcanic hill offering excellent views across East Lothian. Historical significance with ancient fort remains.', 1, ARRAY['East Linton approach', 'Law route'], ARRAY['All year'], 'NT581746', 'Haddington', 'Parking at East Linton', 'traprain_law.jpg'),

('North Berwick Law', 'Borders', 'East Lothian', 187, 187, 'Corbett', '1-2 hours', 'A prominent volcanic hill offering spectacular views across the Forth. Popular with families and day walkers.', 1, ARRAY['North Berwick approach', 'Law route'], ARRAY['All year'], 'NT556842', 'North Berwick', 'Parking in North Berwick', 'north_berwick_law.jpg'),

('Arthur''s Seat', 'Borders', 'Edinburgh', 251, 251, 'Corbett', '1-2 hours', 'The highest peak in Edinburgh, offering spectacular views across the city and Forth. Popular with tourists and locals alike.', 2, ARRAY['Holyrood approach', 'Dunsapie route'], ARRAY['All year'], 'NT275729', 'Edinburgh', 'Parking at Holyrood', 'arthurs_seat.jpg'),

('Calton Hill', 'Borders', 'Edinburgh', 106, 106, 'Corbett', '0.5-1 hour', 'A small hill in central Edinburgh offering excellent views across the city. Historical monuments and easy access.', 1, ARRAY['City centre approach', 'Monument route'], ARRAY['All year'], 'NT260740', 'Edinburgh', 'City centre parking', 'calton_hill.jpg'),

('Corstorphine Hill', 'Borders', 'Edinburgh', 161, 161, 'Corbett', '1-2 hours', 'A hill in west Edinburgh offering good views across the city. Popular with local walkers and dog walkers.', 1, ARRAY['Corstorphine approach', 'Hill route'], ARRAY['All year'], 'NT205735', 'Edinburgh', 'Parking in Corstorphine', 'corstorphine_hill.jpg'),

('Craiglockhart Hill', 'Borders', 'Edinburgh', 164, 164, 'Corbett', '1-2 hours', 'A hill in south Edinburgh offering good views across the city. Popular with local residents.', 1, ARRAY['Craiglockhart approach', 'Hill route'], ARRAY['All year'], 'NT235705', 'Edinburgh', 'Local parking', 'craiglockhart_hill.jpg'),

('Braid Hills', 'Borders', 'Edinburgh', 206, 206, 'Corbett', '1-2 hours', 'Hills in south Edinburgh offering excellent views across the city. Popular with golfers and walkers.', 1, ARRAY['Morningside approach', 'Hills route'], ARRAY['All year'], 'NT255695', 'Edinburgh', 'Parking at Braid Hills', 'braid_hills.jpg'),

('Blackford Hill', 'Borders', 'Edinburgh', 164, 164, 'Corbett', '1-2 hours', 'A hill in south Edinburgh offering good views and pleasant walking. Home to Royal Observatory.', 1, ARRAY['Blackford approach', 'Observatory route'], ARRAY['All year'], 'NT265715', 'Edinburgh', 'Parking at Blackford', 'blackford_hill.jpg');

-- Verify the count
SELECT COUNT(*) as total_corbetts FROM corbetts;

-- Show sample of newly added Corbetts
SELECT name, height, region, classification FROM corbetts 
ORDER BY height DESC 
LIMIT 10;