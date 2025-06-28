# MMM-SMH - Scottish Munros Highland Module

A beautiful MagicMirror module that displays detailed information about Scottish Munros, rotating through all 282 peaks every hour.

## Features

- **Hourly Rotation**: Automatically cycles through all 282 Scottish Munros every hour
- **Comprehensive Data**: Each Munro includes:
  - Height (meters and feet) and prominence
  - Location, region, and OS grid reference
  - Difficulty rating (1-5 scale)
  - Estimated completion time
  - Popular climbing routes
  - Best seasons for climbing
  - Historical information and significance
  - Detailed descriptions

- **Local Image Support**: Displays high-quality images stored locally
- **Real-time Clock**: Shows current time and next rotation schedule
- **Responsive Design**: Optimized for mirror displays with high contrast
- **Smooth Transitions**: Elegant fade effects between Munros

## Directory Structure

```
MMM-SMH/
├── src/
│   ├── components/
│   │   └── MunroDisplay.tsx
│   ├── lib/
│   │   └── supabase.ts
│   └── App.tsx
├── public/
│   └── images/
│       └── munros/
│           ├── ben_nevis.jpg
│           ├── cairn_gorm.jpg
│           └── ... (all 282 munro images)
├── supabase/
│   └── migrations/
│       └── create_munros_table.sql
└── package.json
```

## Setup Instructions

### 1. Database Setup
1. Set up a Supabase project
2. Run the migration file to create the munros table
3. Populate with all 282 Scottish Munros data
4. Configure environment variables

### 2. Image Setup
1. Place all Munro images in `public/images/munros/`
2. Use naming convention: lowercase with underscores (e.g., `ben_nevis.jpg`)
3. Recommended image specs:
   - Format: JPEG
   - Size: Minimum 800x600 pixels
   - Orientation: Landscape preferred

### 3. Environment Variables
Create a `.env` file with:
```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Installation
```bash
npm install
npm run dev
```

## Usage

The module automatically starts displaying Munros once loaded. Each Munro is shown for exactly one hour, with the rotation based on UTC time to ensure consistency across restarts.

## Technical Details

- **Framework**: React + TypeScript + Vite
- **Database**: Supabase PostgreSQL
- **Styling**: Tailwind CSS
- **Icons**: Lucide React
- **Image Handling**: Local file system with fallback placeholders

## MagicMirror Integration

To integrate with MagicMirror², you would need to:
1. Convert the React components to vanilla JavaScript
2. Follow MagicMirror module structure conventions
3. Use the MM notification system
4. Adapt the styling for mirror display requirements

## Data Schema

The munros table includes:
- Basic info: name, height, prominence, classification
- Location: region, area, grid reference, coordinates
- Climbing info: difficulty rating, estimated time, routes
- Additional: description, best seasons, historical notes, image filename

## Contributing

This module is designed for local use with personal image collections. To add new Munros or update information, modify the database directly or update the migration file.

## License

Private use only - not intended for public distribution.