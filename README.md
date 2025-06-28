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

## MagicMirror Installation

### Prerequisites
- MagicMirror² installed and running
- Node.js and npm
- Supabase account and project

### Step 1: Install the Module

Navigate to your MagicMirror modules directory and clone this repository:

```bash
cd ~/MagicMirror/modules
git clone https://github.com/yourusername/MMM-SMH.git
cd MMM-SMH
npm install
```

### Step 2: Database Setup

1. **Create a Supabase Project**
   - Go to [supabase.com](https://supabase.com) and create a new project
   - Note your project URL and anon key

2. **Run Database Migration**
   - In your Supabase dashboard, go to SQL Editor
   - Copy and paste the contents of `supabase/migrations/20250628092129_silent_credit.sql`
   - Run the migration to create the munros table and populate it with data

### Step 3: Build the Module

**IMPORTANT**: You must build the module before using it in MagicMirror:

```bash
cd ~/MagicMirror/modules/MMM-SMH
npm run build
```

This creates the `dist/` folder with the compiled React application that MagicMirror will load.

### Step 4: Image Setup

1. **Prepare Munro Images**
   - Place all 282 Munro images in `public/images/munros/`
   - Use naming convention: lowercase with underscores (e.g., `ben_nevis.jpg`)
   - Recommended specs:
     - Format: JPEG
     - Size: Minimum 800x600 pixels
     - Orientation: Landscape preferred

2. **Image Naming Examples**
   ```
   public/images/munros/
   ├── ben_nevis.jpg
   ├── cairn_gorm.jpg
   ├── aonach_beag.jpg
   ├── braeriach.jpg
   ├── schiehallion.jpg
   ├── ben_macdui.jpg
   └── ... (all 282 munros)
   ```

### Step 5: MagicMirror Configuration

Add the module to your MagicMirror config file (`~/MagicMirror/config/config.js`):

```javascript
{
    module: "MMM-SMH",
    position: "fullscreen_below", // or your preferred position
    config: {
        // REQUIRED: Your Supabase credentials
        supabaseUrl: "https://your-project.supabase.co",
        supabaseAnonKey: "your-anon-key-here",
        
        // Optional settings
        updateInterval: 60000,      // Check for updates every minute
        animationSpeed: 1000,       // Animation speed in ms
        maxWidth: "100%",           // Maximum width
        maxHeight: "100%"           // Maximum height
    }
}
```

**CRITICAL**: You must set your Supabase credentials in the config. Get these from your Supabase project dashboard:
- **supabaseUrl**: Found in Project Settings > API > Project URL
- **supabaseAnonKey**: Found in Project Settings > API > Project API keys > anon public

### Step 6: Start MagicMirror

```bash
cd ~/MagicMirror
npm start
```

## Module Positions

The module works best in these MagicMirror positions:
- `fullscreen_below` - Full screen display (recommended)
- `middle_center` - Center region
- `lower_third` - Bottom section

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `supabaseUrl` | String | **Required** | Your Supabase project URL |
| `supabaseAnonKey` | String | **Required** | Your Supabase anonymous key |
| `updateInterval` | Number | 60000 | Update interval in milliseconds |
| `animationSpeed` | Number | 1000 | Animation speed in milliseconds |
| `maxWidth` | String | "100%" | Maximum width of the module |
| `maxHeight` | String | "100%" | Maximum height of the module |

## Troubleshooting

### Common Issues

1. **"Loading Scottish Munros" stuck**
   - Check that you've set `supabaseUrl` and `supabaseAnonKey` in your config
   - Verify your Supabase credentials are correct
   - Check MagicMirror logs: `pm2 logs MagicMirror`
   - Ensure you've run `npm run build` in the module directory

2. **"no MMM-SMH/MMM-SMH.js found"**
   - Make sure the module is in `~/MagicMirror/modules/MMM-SMH/`
   - Verify `MMM-SMH.js` exists in the module root directory
   - Check file permissions

3. **Module not displaying**
   - Ensure you've built the module: `npm run build`
   - Check that `dist/` folder exists with `assets/index.js` and `assets/index.css`
   - Verify Supabase configuration in MagicMirror config
   - Check browser console for errors (F12)

4. **Images not loading**
   - Verify image files exist in `public/images/munros/`
   - Check image naming matches database `image_filename` field
   - Ensure proper file permissions

5. **Database connection issues**
   - Verify Supabase URL and key are correct
   - Check Supabase project is active
   - Ensure RLS policies allow public read access
   - Test connection in Supabase dashboard

### Development Mode

For development and testing outside of MagicMirror:

```bash
cd ~/MagicMirror/modules/MMM-SMH
cp .env.example .env
# Edit .env with your Supabase credentials
npm run dev
```

This starts a development server at `http://localhost:5173`

### Rebuilding After Changes

If you make changes to the source code:

```bash
cd ~/MagicMirror/modules/MMM-SMH
npm run build
# Restart MagicMirror
```

## Technical Details

### Architecture
- **Frontend**: React + TypeScript + Vite
- **Database**: Supabase PostgreSQL
- **Styling**: Tailwind CSS
- **Icons**: Lucide React
- **Image Handling**: Local file system with fallback placeholders

### Data Flow
1. Module calculates current Munro based on UTC hour
2. Fetches Munro data from Supabase
3. Displays with smooth transitions every hour
4. Images loaded locally with graceful fallbacks

### File Structure
```
MMM-SMH/
├── MMM-SMH.js                    # MagicMirror module file
├── src/
│   ├── components/
│   │   └── MunroDisplay.tsx      # Main display component
│   ├── lib/
│   │   └── supabase.ts           # Database client
│   └── App.tsx                   # Root component
├── public/
│   └── images/
│       └── munros/               # Local Munro images
├── dist/                         # Built files (after npm run build)
│   └── assets/
│       ├── index.js              # Built JavaScript
│       └── index.css             # Built CSS
├── supabase/
│   └── migrations/               # Database schema
└── package.json
```

## Performance

- **Memory Usage**: ~50MB typical
- **CPU Usage**: Minimal (updates hourly)
- **Network**: Initial data load only, then cached
- **Storage**: ~500MB for all images

## License

Private use only - not intended for public distribution.

## Contributing

This module is designed for personal use. To modify:

1. Fork the repository
2. Make your changes in the `src/` directory
3. Run `npm run build` to compile
4. Test thoroughly with MagicMirror
5. Update documentation as needed

## Support

For issues specific to this module:
1. Check the troubleshooting section above
2. Verify your MagicMirror installation is working
3. Test the module in development mode first
4. Check browser console and MagicMirror logs for errors

## Version History

- **v1.0.0** - Initial release with all 282 Scottish Munros
- Complete database with comprehensive mountain information
- Local image support with fallback system
- Hourly rotation based on UTC time
- Optimized for MagicMirror display