import React, { useState, useEffect } from 'react';
import { Mountain, MapPin, Clock, TrendingUp, Route, Star } from 'lucide-react';
import { Mountain as MountainType, getMountainByIndex, getMountainCount } from '../lib/supabase';
import '../lib/database-check'; // Auto-run database verification in dev

interface MountainDisplayProps {
  className?: string;
  mountainType?: 'munros' | 'corbetts';
  title?: string;
  iconColor?: string;
}

export default function MountainDisplay({ 
  className = '', 
  mountainType = 'munros',
  title = 'Scottish Munros',
  iconColor = 'text-blue-400'
}: MountainDisplayProps) {
  const [currentMountain, setCurrentMountain] = useState<MountainType | null>(null);
  const [mountainCount, setMountainCount] = useState<number>(0);
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());
  const [imageStatus, setImageStatus] = useState<'loading' | 'loaded' | 'error'>('loading');
  const [imageUrl, setImageUrl] = useState<string>('');
  const [debugInfo, setDebugInfo] = useState<string>('');

  // Add state for actual database counts
  const [actualCount, setActualCount] = useState<number>(0);
  const [expectedCount, setExpectedCount] = useState<number>(0);

  // Update time every minute
  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 60000);

    return () => clearInterval(timer);
  }, []);

  // Initialize mountain count
  useEffect(() => {
    const initializeCount = async () => {
      try {
        const count = await getMountainCount(mountainType);
        const expected = mountainType === 'munros' ? 282 : 222;
        
        console.log(`MMM-SMH: ${mountainType.toUpperCase()} - Found: ${count}, Expected: ${expected}`);
        setMountainCount(count);
        setActualCount(count);
        setExpectedCount(expected);
        
        if (count !== expected) {
          setDebugInfo(`⚠️ ${count}/${expected}`);
          console.warn(`🚨 MMM-SMH: INCOMPLETE DATABASE`);
          console.warn(`   ${mountainType.toUpperCase()}: ${count}/${expected} (missing ${expected - count})`);
          console.warn(`   Check Supabase migrations and RLS policies`);
        } else {
          setDebugInfo(`✅ ${count}/${expected}`);
          console.log(`✅ MMM-SMH: ${mountainType.toUpperCase()} database complete`);
        }
      } catch (error) {
        console.error(`❌ MMM-SMH: Error getting ${mountainType} count:`, error);
        setDebugInfo(`❌ DB Error`);
      }
    };

    initializeCount();
  }, [mountainType]);

  // Preload image when mountain changes
  useEffect(() => {
    if (!currentMountain?.image_filename) {
      setImageStatus('error');
      setImageUrl('');
      return;
    }

    setImageStatus('loading');
    const img = new Image();
    
    const handleLoad = () => {
      setImageStatus('loaded');
      setImageUrl(img.src);
    };
    
    const handleError = () => {
      // Try alternative paths
      const filename = currentMountain.image_filename;
      const basePath = mountainType === 'munros' ? 'munros' : 'corbetts';
      const altPaths = [
        `modules/MMM-SMH/public/images/${basePath}/${filename}`,
        `modules/MMM-SMH/images/${basePath}/${filename}`,
        `/modules/MMM-SMH/dist/images/${basePath}/${filename}`,
        `/modules/MMM-SMH/public/images/${basePath}/${filename}`,
        `/modules/MMM-SMH/images/${basePath}/${filename}`,
        `images/${basePath}/${filename}`,
        `./images/${basePath}/${filename}`,
        `/images/${basePath}/${filename}`
      ];
      
      const currentSrc = img.src;
      const currentPathIndex = altPaths.findIndex(path => currentSrc.includes(path.split('/').pop() || ''));
      
      if (currentPathIndex < altPaths.length - 1) {
        // Try next path
        const nextPath = altPaths[currentPathIndex + 1];
        console.log(`MMM-SMH: Image failed, trying: ${nextPath}`);
        img.src = nextPath;
      } else {
        // All paths failed
        console.log(`MMM-SMH: All image paths failed for: ${filename}`);
        setImageStatus('error');
        setImageUrl('');
      }
    };
    
    img.addEventListener('load', handleLoad);
    img.addEventListener('error', handleError);
    
    // Start loading with the first path
    img.src = getImagePath(currentMountain.image_filename);
    
    return () => {
      img.removeEventListener('load', handleLoad);
      img.removeEventListener('error', handleError);
    };
  }, [currentMountain?.image_filename, mountainType]);

  // Load mountain by index
  const loadMountain = async (index: number) => {
    if (mountainCount === 0) return;
    
    try {
      console.log(`MMM-SMH: Loading ${mountainType} at index ${index} of ${mountainCount}`);
      setIsTransitioning(true);
      setImageStatus('loading');
      setImageUrl('');
      
      const mountain = await getMountainByIndex(index, mountainType);
      
      if (mountain) {
        console.log(`MMM-SMH: Loaded ${mountainType}: ${mountain.name} (${index + 1}/${mountainCount})`);
        setTimeout(() => {
          setCurrentMountain(mountain);
          setIsTransitioning(false);
        }, 300);
      } else {
        console.error(`MMM-SMH: No ${mountainType} found at index ${index}`);
        setDebugInfo(`No ${mountainType} at index ${index}`);
      }
    } catch (error) {
      console.error(`MMM-SMH: Error loading ${mountainType}:`, error);
      setDebugInfo(`Error loading index ${index}`);
      setIsTransitioning(false);
    }
  };

  // Calculate current mountain index based on UTC hour
  const getCurrentMountainIndex = () => {
    if (mountainCount === 0) return 0;
    
    const now = new Date();
    const hoursSinceEpoch = Math.floor(now.getTime() / (1000 * 60 * 60));
    const calculatedIndex = hoursSinceEpoch % mountainCount;
    
    console.log(`MMM-SMH: Time calculation - UTC: ${now.toISOString()}, Hours since epoch: ${hoursSinceEpoch}, Index: ${calculatedIndex}`);
    
    return calculatedIndex;
  };

  // Initialize with calculated current mountain based on time
  useEffect(() => {
    if (mountainCount > 0) {
      const calculatedIndex = getCurrentMountainIndex();
      console.log(`MMM-SMH: Initializing with calculated index ${calculatedIndex}`);
      setCurrentIndex(calculatedIndex);
      loadMountain(calculatedIndex);
    }
  }, [mountainCount, mountainType]);

  // Check for hour changes and update mountain accordingly
  useEffect(() => {
    if (mountainCount === 0) return;

    const checkForHourChange = () => {
      const newIndex = getCurrentMountainIndex();
      
      if (newIndex !== currentIndex) {
        console.log(`MMM-SMH: Hour changed! Switching from ${mountainType} ${currentIndex} to ${newIndex}`);
        setCurrentIndex(newIndex);
        loadMountain(newIndex);
      }
    };

    // Check every minute for hour changes
    const interval = setInterval(checkForHourChange, 60000);

    return () => clearInterval(interval);
  }, [mountainCount, currentIndex, mountainType]);

  // REMOVE IN PRODUCTION: Manual cycling for testing
  useEffect(() => {
    // Only enable manual controls in development mode
    if (process.env.NODE_ENV !== 'development') return;

    const handleKeyPress = (event: KeyboardEvent) => {
      if (event.key === 'ArrowRight' && mountainCount > 0) {
        const nextIndex = (currentIndex + 1) % mountainCount;
        console.log(`MMM-SMH: Manual advance to index ${nextIndex}`);
        setCurrentIndex(nextIndex);
        loadMountain(nextIndex);
      } else if (event.key === 'ArrowLeft' && mountainCount > 0) {
        const prevIndex = currentIndex === 0 ? mountainCount - 1 : currentIndex - 1;
        console.log(`MMM-SMH: Manual back to index ${prevIndex}`);
        setCurrentIndex(prevIndex);
        loadMountain(prevIndex);
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, [currentIndex, mountainCount]);

  const getDifficultyStars = (rating: number) => {
    return Array.from({ length: 5 }, (_, i) => (
      <Star 
        key={i} 
        className={`w-3 h-3 ${i < rating ? 'text-yellow-400 fill-current' : 'text-gray-600'}`} 
      />
    ));
  };

  // Get the correct image path for MagicMirror and development
  const getImagePath = (filename: string) => {
    const basePath = mountainType === 'munros' ? 'munros' : 'corbetts';
    
    // For development mode, use the public folder directly
    if (import.meta.env.DEV) {
      return `/images/${basePath}/${filename}`;
    }
    
    // For production/MagicMirror, try multiple possible paths
    const basePaths = [
      `modules/MMM-SMH/dist/images/${basePath}/`,
      `modules/MMM-SMH/public/images/${basePath}/`,
      `modules/MMM-SMH/images/${basePath}/`,
      `/modules/MMM-SMH/dist/images/${basePath}/`,
      `/modules/MMM-SMH/public/images/${basePath}/`,
      `/modules/MMM-SMH/images/${basePath}/`,
      // Also try relative paths from dist
      `images/${basePath}/`,
      `./images/${basePath}/`
    ];
    
    // Return the first path (we'll handle fallbacks in onError)
    return basePaths[0] + filename;
  };

  // Calculate time until next mountain change
  const getTimeUntilNextChange = () => {
    const now = new Date();
    const nextHour = new Date(now);
    nextHour.setHours(nextHour.getHours() + 1);
    nextHour.setMinutes(0);
    nextHour.setSeconds(0);
    nextHour.setMilliseconds(0);
    
    const diffMinutes = Math.floor((nextHour.getTime() - now.getTime()) / (1000 * 60));
    return diffMinutes;
  };

  // Format estimated time based on mountain type
  const formatEstimatedTime = (time: number | string) => {
    if (typeof time === 'number') {
      return `${time}h`;
    }
    return time;
  };

  // Get location string based on mountain type
  const getLocationString = (mountain: MountainType) => {
    if (mountain.area) {
      return `${mountain.area}, ${mountain.region}`;
    }
    if (mountain.location) {
      return `${mountain.location}, ${mountain.region}`;
    }
    return mountain.region;
  };

  if (!currentMountain) {
    return (
      <div className={`text-white max-w-xs bg-gray-900 bg-opacity-95 p-4 rounded-lg border border-gray-600 ${className}`}>
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
          <div className="flex items-center space-x-2 mb-2">
            <Mountain className={`w-4 h-4 ${iconColor} animate-pulse`} />
            <div>
              <div className="text-sm font-light">{title}</div>
              <div className="text-xs text-gray-400">
                {mountainCount > 0 ? `Loading... (${debugInfo})` : 'Connecting...'}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const minutesUntilNext = getTimeUntilNextChange();

  return (
    <div className={`text-white max-w-xs bg-gray-900 bg-opacity-95 p-4 rounded-lg border border-gray-600 ${className}`}>
      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'} space-y-3`}>
        
        {/* Header with title and time */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center space-x-3">
              <Mountain className={`w-5 h-5 ${iconColor}`} />
              <span className="text-lg font-light">{title}</span>
            </div>
            <div className="text-sm text-gray-400">
              {currentTime.toLocaleTimeString('en-GB', { 
                hour: '2-digit', 
                minute: '2-digit',
                timeZone: 'UTC'
              })}
            </div>
          </div>
          <div className="text-sm text-gray-300">
            {currentIndex + 1} of {actualCount} • {minutesUntilNext}min
            {actualCount !== expectedCount && (
              <span className="text-red-400 text-xs ml-2 font-medium">
                ⚠️ Missing {expectedCount - actualCount}
              </span>
            )}
          </div>
        </div>

        {/* Mountain name and height */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
          <div className="flex items-center justify-between mb-2">
            <Mountain className="w-6 h-6 text-green-400" />
            <div className="text-2xl font-bold text-green-400">
              {currentMountain.height}m
            </div>
          </div>
          <h2 className="text-xl font-medium text-white leading-relaxed">
            {currentMountain.name}
          </h2>
        </div>

        {/* Mountain image */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg overflow-hidden border border-gray-600 shadow-lg">
          <div className="relative">
            {imageStatus === 'loaded' && imageUrl ? (
              <img 
                src={imageUrl}
                alt={currentMountain.name}
                className="w-full h-35 object-cover"
              />
            ) : imageStatus === 'loading' ? (
              <div className="w-full h-35 bg-gray-700 flex items-center justify-center">
                <Mountain className="w-12 h-12 text-gray-400 animate-pulse" />
              </div>
            ) : (
              <div className="w-full h-35 bg-gray-700 flex items-center justify-center">
                <Mountain className="w-12 h-12 text-gray-400" />
              </div>
            )}
            
            {/* Location overlay */}
            <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/70 to-transparent p-3">
              <div className="flex items-center space-x-2 text-white">
                <MapPin className="w-4 h-4 text-green-400 flex-shrink-0" />
                <span className="text-sm">{getLocationString(currentMountain)}</span>
              </div>
            </div>
          </div>
        </div>

        {/* Stats grid */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
          <div className="grid grid-cols-3 gap-4">
            <div className="text-center">
              <div className="text-lg font-bold text-blue-400">{currentMountain.prominence}m</div>
              <div className="text-xs text-gray-400">Prominence</div>
            </div>
            <div className="text-center">
              <div className="text-lg font-bold text-green-400">{formatEstimatedTime(currentMountain.estimated_time)}</div>
              <div className="text-xs text-gray-400">Time</div>
            </div>
            <div className="text-center">
              <div className="flex justify-center space-x-1 mb-1">
                {getDifficultyStars(currentMountain.difficulty_rating)}
              </div>
              <div className="text-xs text-gray-400">Difficulty</div>
            </div>
          </div>
        </div>

        {/* Description */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
          <p className="text-sm text-gray-300 leading-relaxed line-clamp-4">
            {currentMountain.description}
          </p>
        </div>

        {/* Popular Routes */}
        {currentMountain.popular_routes && currentMountain.popular_routes.length > 0 && (
          <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
            <div className="flex items-center space-x-2 mb-3">
              <Route className="w-4 h-4 text-orange-400" />
              <span className="text-sm font-medium text-orange-400">Popular Routes</span>
            </div>
            <div className="space-y-2">
              {currentMountain.popular_routes.slice(0, 3).map((route, index) => (
                <div key={index} className="text-sm text-gray-300">
                  • {route}
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Best Seasons */}
        {currentMountain.best_seasons && currentMountain.best_seasons.length > 0 && (
          <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
            <div className="flex items-center space-x-2 mb-3">
              <Clock className="w-4 h-4 text-green-400" />
              <span className="text-sm font-medium text-green-400">Best Seasons</span>
            </div>
            <div className="flex flex-wrap gap-2">
              {currentMountain.best_seasons.slice(0, 4).map((season, index) => (
                <span 
                  key={index}
                  className="px-3 py-1 bg-green-600 bg-opacity-30 text-green-300 rounded text-sm border border-green-600 border-opacity-30"
                >
                  {season}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* Debug info (development only) */}
        {process.env.NODE_ENV === 'development' && (
          <div className="bg-gray-900 bg-opacity-90 rounded-lg p-3 border border-gray-500 shadow-lg">
            <div className="text-xs text-gray-400 space-y-1">
              <div>Debug: Index {currentIndex}, UTC Hour: {new Date().getUTCHours()}</div>
              <div>Next change: {minutesUntilNext} minutes</div>
              <div>Image status: {imageStatus}</div>
              <div>Type: {mountainType}</div>
              <div>Count: {actualCount}/{expectedCount} {mountainType}</div>
              <div className={actualCount === expectedCount ? "text-green-400" : "text-yellow-400"}>
                {actualCount === expectedCount ? "✅ Complete dataset" : `⚠️ Missing ${expectedCount - actualCount} ${mountainType}`}
              </div>
              <div className="text-yellow-400">Use ← → arrow keys to cycle</div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}