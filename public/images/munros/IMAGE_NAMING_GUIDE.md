# Munro Image Naming Guide

## Problem

Some Munros share similar base names but are in different regions. When these mountains were initially added to the database, they all used the same image filename, making it impossible to have unique images for each mountain.

## Solution

Image filenames for mountains with similar names now include a region/area identifier to make them unique.

## Naming Convention

For mountains with duplicate base names, use this format:
```
{mountain_name}_{region_identifier}.jpg
```

### Examples

**Total: 35+ Munros across 14 different base names**

#### Mountains with 4 Variants
- **Geal Chàrn**: `geal_charn_laggan.jpg`, `geal_charn_monadhliath.jpg`, `geal_charn_alder.jpg`, `geal_charn_drumochter.jpg`

#### Mountains with 3 Variants
- **Càrn Dearg**: `carn_dearg_corrour.jpg`, `carn_dearg_loch_pattack.jpg`, `carn_dearg_monadhliath.jpg`
- **An Socach**: `an_socach_affric.jpg`, `an_socach_braemar.jpg`, `an_socach_mullardoch.jpg`
- **Sgùrr Mòr**: `sgurr_mor_fannichs.jpg`, `sgurr_mor_beinn_alligin.jpg`, `sgurr_mor_loch_cuaich.jpg`

#### Mountains with 2 Variants
- **A' Chailleach**: `a_chailleach_fannichs.jpg`, `a_chailleach_monadhliath.jpg`
- **Aonach Beag**: `aonach_beag_nevis.jpg`, `aonach_beag_alder.jpg`
- **Beinn a' Chaorainn**: `beinn_a_chaorainn_cairngorms.jpg`, `beinn_a_chaorainn_glen_spean.jpg`
- **Beinn Dearg**: `beinn_dearg_blair_atholl.jpg`, `beinn_dearg_ullapool.jpg`
- **Beinn Fhionnlaidh**: `beinn_fhionnlaidh_glen_etive.jpg`, `beinn_fhionnlaidh_carn_eige.jpg`
- **Ben More**: `ben_more_crianlarich.jpg`, `ben_more_mull.jpg`
- **Ben Vorlich**: `ben_vorlich_loch_earn.jpg`, `ben_vorlich_loch_lomond.jpg`
- **Càrn Liath**: `carn_liath_beinn_a_ghlo.jpg`, `carn_liath_creag_meagaidh.jpg`
- **Càrn nan Gobhar**: `carn_nan_gobhar_loch_mullardoch.jpg`, `carn_nan_gobhar_strathfarrar.jpg`
- **Creag Mhòr**: `creag_mhor_glen_lochay.jpg`, `creag_mhor_meall_na_aighean.jpg`
- **Meall Buidhe**: `meall_buidhe_glen_lyon.jpg`, `meall_buidhe_knoydart.jpg`
- **Meall Garbh**: `meall_garbh_ben_lawers.jpg`, `meall_garbh_carn_mairg.jpg`
- **Ruadh Stac Mòr**: `ruadh_stac_mor_fisherfield.jpg`, `ruadh_stac_mor_beinn_eighe.jpg`
- **Sgùrr nan Coireachan**: `sgurr_nan_coireachan_glen_dessary.jpg`, `sgurr_nan_coireachan_glenfinnan.jpg`
- **Stob Bàn**: `stob_ban_grey_corries.jpg`, `stob_ban_mamores.jpg`

## File Naming Rules

1. Convert to lowercase
2. Replace spaces with underscores
3. Remove apostrophes and special characters
4. Add region identifier before extension
5. Use `.jpg` extension

## Fallback Behavior

If a specific image file is not found, the application will fall back to:
- `munro.png` - Generic Munro placeholder image

## Adding New Images

When adding images for mountains with similar names:

1. Check the database for the correct `image_filename` value
2. Name your image file exactly as specified in the database
3. Place it in `public/images/munros/` directory
4. The file will be copied to `dist/images/munros/` during build

## Database Migrations

The image filenames were updated using these migrations:
- `supabase/migrations/[timestamp]_fix_duplicate_munro_image_filenames.sql` - Initial fix for 9 mountains
- `supabase/migrations/[timestamp]_fix_all_duplicate_munro_image_filenames.sql` - Comprehensive fix for all 35+ duplicates

These migrations ensure each mountain variant has a unique image filename that can be used to store and display distinct images.

## Summary

**Fixed:** 35+ mountains across 14 different base names now have unique image filenames. No two mountains share the same image filename anymore.
