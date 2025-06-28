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

3. **Configure Environment Variables**
   - Copy `.env.example` to `.env`
   - Update with your Supabase credentials:
   ```env
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-key-here
   ```

### Step 3: Image Setup

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

### Step 4: MagicMirror Configuration

Add the module to your MagicMirror config file (`~/MagicMirror/config/config.js`):

```javascript
{
    module: "MMM-SMH",
    position: "fullscreen_below", // or your preferred position
    config: {
        // Module is self-contained and requires no additional config
        // All settings are handled via environment variables
    }
}
```

### Step 5: Build and Start

1. **Build the Module**
   ```bash
   cd ~/MagicMirror/modules/MMM-SMH
   npm run build
   ```

2. **Restart MagicMirror**
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

The module is designed to work out-of-the-box with minimal configuration. All settings are handled through environment variables:

| Variable | Description | Required |
|----------|-------------|----------|
| `VITE_SUPABASE_URL` | Your Supabase project URL | Yes |
| `VITE_SUPABASE_ANON_KEY` | Your Supabase anonymous key | Yes |

## Customization

### Styling for MagicMirror

The module uses a dark theme optimized for mirror displays. To customize:

1. **Colors**: Edit `src/index.css` to modify the color scheme
2. **Layout**: Adjust `src/components/MunroDisplay.tsx` for different layouts
3. **Timing**: Modify the hourly rotation in the component logic

### Adding Custom Munros

To add additional peaks or modify existing data:

1. Update the database directly through Supabase dashboard
2. Or modify the migration file and re-run it
3. Ensure corresponding images are added to the images directory

## Troubleshooting

### Common Issues

1. **Module not displaying**
   - Check MagicMirror logs: `pm2 logs MagicMirror`
   - Verify environment variables are set correctly
   - Ensure database migration completed successfully

2. **Images not loading**
   - Verify image files exist in `public/images/munros/`
   - Check image naming matches database `image_filename` field
   - Ensure proper file permissions

3. **Database connection issues**
   - Verify Supabase URL and key are correct
   - Check Supabase project is active
   - Ensure RLS policies allow public read access

### Development Mode

For development and testing:

```bash
cd ~/MagicMirror/modules/MMM-SMH
npm run dev
```

This starts a development server at `http://localhost:5173`

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
├── src/
│   ├── components/
│   │   └── MunroDisplay.tsx      # Main display component
│   ├── lib/
│   │   └── supabase.ts           # Database client
│   └── App.tsx                   # Root component
├── public/
│   └── images/
│       └── munros/               # Local Munro images
├── supabase/
│   └── migrations/               # Database schema
├── dist/                         # Built files (after npm run build)
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
2. Make your changes
3. Test thoroughly with MagicMirror
4. Update documentation as needed

## Support

For issues specific to this module:
1. Check the troubleshooting section above
2. Verify your MagicMirror installation is working
3. Test the module in development mode first

## Version History

- **v1.0.0** - Initial release with all 282 Scottish Munros
- Complete database with comprehensive mountain information
- Local image support with fallback system
- Hourly rotation based on UTC time
- Optimized for MagicMirror display