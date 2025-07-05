# MMM-SMH - Scottish Mountains Highland Module

A beautiful MagicMirror module that displays detailed information about Scottish mountains, rotating through all peaks every hour. Supports both **Munros** (282 peaks) and **Corbetts** (219 peaks) with identical visual design.

## 🏔️ Features

- **Dual Mountain Support**: Display either Scottish Munros or Corbetts using the same component
- **Hourly Rotation**: Automatically cycles through all mountains every hour based on UTC time
- **Comprehensive Data**: Each mountain includes:
  - Height, prominence, and location details
  - Difficulty rating (1-5 scale) with star display
  - Estimated completion time
  - Popular climbing routes
  - Best seasons for climbing
  - Detailed descriptions and historical information
  - High-quality mountain images

- **Smart Image System**: Local image support with intelligent fallback paths
- **Real-time Clock**: Shows current UTC time and countdown to next rotation
- **Responsive Design**: Optimized for MagicMirror displays with high contrast
- **Smooth Transitions**: Elegant fade effects between mountains
- **Development Tools**: Arrow key navigation for testing

## 🚀 Quick Start

### Prerequisites
- MagicMirror² installed and running
- Node.js 16+ and npm
- Supabase account and project

### 1. Install the Module

```bash
cd ~/MagicMirror/modules
git clone https://github.com/yourusername/MMM-SMH.git
cd MMM-SMH
npm install
```

### 2. Database Setup

1. **Create Supabase Project**
   - Go to [supabase.com](https://supabase.com) and create a new project
   - Note your project URL and anon key from Settings > API

2. **Run Database Migrations**
   - In Supabase dashboard, go to SQL Editor
   - Run the migration files in order from `supabase/migrations/`
   - This creates both `munros` and `corbetts` tables with complete datasets

### 3. Build the Module

**CRITICAL**: You must build before using in MagicMirror:

```bash
cd ~/MagicMirror/modules/MMM-SMH
npm run build
```

### 4. Configure MagicMirror

Add to your `~/MagicMirror/config/config.js`:

```javascript
{
    module: "MMM-SMH",
    position: "top_left", // or top_right, bottom_left, bottom_right
    config: {
        // REQUIRED: Your Supabase credentials
        supabaseUrl: "https://your-project.supabase.co",
        supabaseAnonKey: "your-anon-key-here",
        
        // Choose mountain type
        mountainType: "munros", // or "corbetts"
        title: "Scottish Munros", // or "Scottish Corbetts"
        iconColor: "text-blue-400", // or any Tailwind color class
        
        // Optional settings
        updateInterval: 60000,      // Check for updates every minute
        animationSpeed: 1000,       // Animation speed in ms
        maxWidth: "300px",          // Maximum width
        maxHeight: "auto"           // Maximum height
    }
}
```

### 5. Add Images (Optional)

Place mountain images in the appropriate directories:
- Munros: `public/images/munros/`
- Corbetts: `public/images/corbetts/`

Expected naming: `ben_nevis.jpg`, `schiehallion.jpg`, etc. (lowercase, underscores)

### 6. Start MagicMirror

```bash
cd ~/MagicMirror
npm start
```

## 🏗️ Architecture

### Component Structure

```
MMM-SMH/
├── MMM-SMH.js                    # MagicMirror module file
├── src/
│   ├── components/
│   │   └── MunroDisplay.tsx      # Main mountain display component
│   ├── lib/
│   │   └── supabase.ts           # Database client & utilities
│   └── App.tsx                   # Root component
├── public/
│   └── images/
│       ├── munros/               # Munro images
│       └── corbetts/             # Corbett images
├── dist/                         # Built files (after npm run build)
├── supabase/
│   └── migrations/               # Database schema & data
└── package.json
```

### Data Flow

1. **Time-Based Selection**: Module calculates current mountain based on UTC hour
2. **Database Query**: Fetches mountain data from Supabase (munros or corbetts table)
3. **Image Loading**: Attempts to load local images with intelligent fallback
4. **Display Update**: Shows mountain with smooth transitions every hour
5. **Auto-Rotation**: Automatically advances to next mountain each hour

### Database Schema

#### Munros Table
- **282 Scottish Munros** (mountains over 3,000 feet)
- Includes Ben Nevis (1,345m) to Sgurr a Chaorachain (792m)
- Complete with routes, seasons, difficulty ratings

#### Corbetts Table  
- **219 Scottish Corbetts** (mountains 2,500-3,000 feet with 500ft prominence)
- Includes detailed climbing information
- Regional coverage across Scotland

## 🔧 Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `supabaseUrl` | String | **Required** | Your Supabase project URL |
| `supabaseAnonKey` | String | **Required** | Your Supabase anonymous key |
| `mountainType` | String | "munros" | "munros" or "corbetts" |
| `title` | String | "Scottish Munros" | Display title |
| `iconColor` | String | "text-blue-400" | Tailwind color class for icons |
| `updateInterval` | Number | 60000 | Update interval in milliseconds |
| `animationSpeed` | Number | 1000 | Animation speed in milliseconds |
| `maxWidth` | String | "300px" | Maximum width of module |
| `maxHeight` | String | "auto" | Maximum height of module |

## 🎯 Multiple Instances

You can run both Munros and Corbetts simultaneously:

```javascript
// First instance - Munros
{
    module: "MMM-SMH",
    position: "top_left",
    config: {
        supabaseUrl: "https://your-project.supabase.co",
        supabaseAnonKey: "your-anon-key",
        mountainType: "munros",
        title: "Scottish Munros",
        iconColor: "text-blue-400"
    }
},
// Second instance - Corbetts  
{
    module: "MMM-SMH",
    position: "top_right",
    config: {
        supabaseUrl: "https://your-project.supabase.co",
        supabaseAnonKey: "your-anon-key",
        mountainType: "corbetts",
        title: "Scottish Corbetts", 
        iconColor: "text-purple-400"
    }
}
```

## 🖼️ Image Management

### Image Requirements
- **Format**: JPEG (.jpg)
- **Size**: Minimum 800x600 pixels, recommended 1200x800
- **Orientation**: Landscape preferred
- **Naming**: Lowercase with underscores (e.g., `ben_nevis.jpg`)

### Image Sources
- **Wikimedia Commons**: Creative Commons licensed
- **Unsplash/Pexels**: Free stock photos
- **Personal Photography**: Best option if you've climbed the mountains!

### Fallback System
The module includes intelligent image fallback:
1. Tries multiple path variations automatically
2. Shows mountain icon if image not found
3. No broken images or layout issues

## 🛠️ Development

### Development Mode

```bash
cd ~/MagicMirror/modules/MMM-SMH
cp .env.example .env
# Edit .env with your Supabase credentials
npm run dev
```

This starts a development server at `http://localhost:5173` with:
- Hot reload for code changes
- Arrow key navigation (← →) for testing
- Debug information overlay
- Console logging for troubleshooting

### Building for Production

```bash
npm run build
```

This creates optimized files in `dist/` that MagicMirror loads.

### Code Structure

#### Generic Mountain Interface
```typescript
interface Mountain {
  id: string | number;
  name: string;
  height: number;
  prominence: number;
  region: string;
  description: string;
  difficulty_rating: number;
  estimated_time: number | string;
  popular_routes: string[];
  best_seasons: string[];
  image_filename: string;
  classification: string;
}
```

#### Conversion Functions
- `munroToMountain()`: Converts Munro data to generic format
- `corbettToMountain()`: Converts Corbett data to generic format
- `getMountainByIndex()`: Unified function for both types
- `getMountainCount()`: Gets total count for either type

## 🐛 Troubleshooting

### Common Issues

1. **"Loading..." stuck forever**
   - ✅ Check Supabase credentials in config
   - ✅ Verify database migrations ran successfully
   - ✅ Check browser console for errors (F12)
   - ✅ Ensure `npm run build` was executed

2. **Module not appearing**
   - ✅ Verify module is in `~/MagicMirror/modules/MMM-SMH/`
   - ✅ Check `MMM-SMH.js` exists in module root
   - ✅ Ensure `dist/` folder exists with built files
   - ✅ Restart MagicMirror after config changes

3. **Images not loading**
   - ✅ Check image files exist in correct directories
   - ✅ Verify naming matches database `image_filename` field
   - ✅ Ensure proper file permissions
   - ✅ Images will fallback to mountain icon if missing

4. **Database connection issues**
   - ✅ Test Supabase connection in dashboard
   - ✅ Verify RLS policies allow public read access
   - ✅ Check project is active and not paused

### Debug Mode

In development, the module shows debug information:
- Current index and UTC hour
- Time until next change
- Image loading status
- Mountain type being displayed
- Arrow key controls for manual navigation

### Logs

Check MagicMirror logs for detailed information:
```bash
pm2 logs MagicMirror
```

## 🔄 How Rotation Works

### Time-Based Algorithm
```javascript
const hoursSinceEpoch = Math.floor(Date.now() / (1000 * 60 * 60));
const mountainIndex = hoursSinceEpoch % totalMountains;
```

### Synchronization
- All instances worldwide show the same mountain at the same time
- Based on UTC time to avoid timezone issues
- Changes exactly on the hour (e.g., 14:00:00 UTC)
- Countdown shows minutes until next change

### Examples
- Hour 0: Mountain index 0 (first in alphabetical order)
- Hour 1: Mountain index 1 (second mountain)
- Hour 282: Mountain index 0 (cycles back to first Munro)
- Hour 283: Mountain index 1 (second Munro again)

## 📊 Performance

- **Memory Usage**: ~50MB typical
- **CPU Usage**: Minimal (updates hourly)
- **Network**: Initial data load only, then cached
- **Storage**: ~500MB for all images (optional)
- **Database**: Efficient indexed queries
- **Startup Time**: ~2-3 seconds

## 🔒 Security

- **RLS Enabled**: Row Level Security on all tables
- **Public Read**: Anonymous read access for mountain data
- **No Writes**: Module only reads data, never modifies
- **Environment Variables**: Credentials stored securely
- **HTTPS**: All Supabase connections encrypted

## 🚀 Deployment

### Production Checklist
- [ ] Supabase project configured
- [ ] Database migrations completed
- [ ] Module built (`npm run build`)
- [ ] Config file updated with credentials
- [ ] Images added (optional)
- [ ] MagicMirror restarted
- [ ] Module appears and rotates correctly

### Performance Optimization
- Images are lazy-loaded and cached
- Database queries are minimal and indexed
- Component updates only when necessary
- Smooth transitions prevent jarring changes

## 🤝 Contributing

### Adding New Mountains
1. Add entries to appropriate database table
2. Follow existing data format and naming conventions
3. Add corresponding images to public directories
4. Test with both development and production builds

### Code Contributions
1. Follow existing TypeScript patterns
2. Maintain component modularity
3. Add proper error handling
4. Update documentation for new features

## 📝 License

Private use only - not intended for public distribution.

## 🆘 Support

For issues specific to this module:
1. Check troubleshooting section above
2. Verify MagicMirror installation is working
3. Test module in development mode first
4. Check browser console and MagicMirror logs for errors
5. Ensure all prerequisites are met

## 📈 Version History

- **v1.0.0** - Initial release
  - Complete Munros dataset (282 peaks)
  - Complete Corbetts dataset (219 peaks)
  - Unified component architecture
  - Local image support with fallback system
  - Hourly rotation based on UTC time
  - Optimized for MagicMirror display
  - Development and production modes
  - Comprehensive documentation

---

**🏔️ Enjoy exploring Scotland's magnificent mountains from your MagicMirror!**