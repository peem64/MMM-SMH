# Munro Images Directory

This directory should contain all 282 Scottish Munro images.

## Required Images

The database expects these image filenames (examples):
- `ben_nevis.jpg`
- `cairn_gorm.jpg` 
- `aonach_beag.jpg`
- `braeriach.jpg`
- `schiehallion.jpg`
- `ben_macdui.jpg`
- `ben_lawers.jpg`
- `beinn_ghlas.jpg`
- `meall_corranaich.jpg`
- `meall_a_choire_leith.jpg`

## Image Requirements

- **Format**: JPEG (.jpg)
- **Size**: Minimum 800x600 pixels, recommended 1200x800
- **Orientation**: Landscape preferred
- **Quality**: High quality for best display
- **Naming**: Lowercase with underscores replacing spaces

## Where to Get Images

### Free Sources (with proper attribution):
1. **Wikimedia Commons** - Creative Commons licensed
2. **Unsplash** - Free for commercial use
3. **Pexels** - Free stock photos
4. **Your own photography** - Best option if you've climbed the Munros!

### Search Tips:
- Search for "Scottish mountains", "Munros", "Highlands"
- Look for specific peak names
- Check licensing carefully

## Example Structure:
```
public/images/munros/
├── ben_nevis.jpg
├── cairn_gorm.jpg
├── aonach_beag.jpg
├── braeriach.jpg
├── schiehallion.jpg
├── ben_macdui.jpg
├── ben_lawers.jpg
├── beinn_ghlas.jpg
├── meall_corranaich.jpg
├── meall_a_choire_leith.jpg
├── carn_liath.jpg
├── braigh_coire_chruinn_bhalgain.jpg
├── carn_a_gheoidh.jpg
├── the_cairnwell.jpg
├── carn_aosda.jpg
├── ben_more_crianlarich.jpg
├── stob_binnein.jpg
├── ben_cruachan.jpg
├── stob_dearg_cruachan.jpg
├── stob_ghabhar.jpg
└── ... (all 282 munros)
```

## After Adding Images:
1. Run `npm run build` to copy images to dist/
2. Images will be automatically displayed in the module
3. Fallback mountain icon shows if image not found

## Current Status:
- ✅ Directory structure ready
- ✅ Build process configured
- ✅ Fallback system working
- ⏳ Waiting for actual image files