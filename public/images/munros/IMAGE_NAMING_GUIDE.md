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

| Mountain Name | Region | Image Filename |
|--------------|--------|----------------|
| A' Chailleach (Fannichs) | Ullapool | `a_chailleach_fannichs.jpg` |
| A' Chailleach (Monadhliath) | Cairngorms | `a_chailleach_monadhliath.jpg` |
| An Socach (Affric) | Loch Ness | `an_socach_affric.jpg` |
| An Socach (Braemar) | Cairngorms | `an_socach_braemar.jpg` |
| An Socach (Mullardoch) | Loch Ness | `an_socach_mullardoch.jpg` |
| Aonach Beag (Nevis Range) | Fort William | `aonach_beag_nevis.jpg` |
| Aonach Beag (Alder) | Cairngorms | `aonach_beag_alder.jpg` |
| Beinn a' Chaorainn (Cairngorms) | Cairngorms | `beinn_a_chaorainn_cairngorms.jpg` |
| Beinn a' Chaorainn (Glen Spean) | Fort William | `beinn_a_chaorainn_glen_spean.jpg` |

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

## Database Migration

The image filenames were updated using the migration:
- `supabase/migrations/[timestamp]_fix_duplicate_munro_image_filenames.sql`

This migration ensures each mountain variant has a unique image filename that can be used to store and display distinct images.
