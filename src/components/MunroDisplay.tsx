import React, { useState, useEffect } from 'react';
import { Mountain, MapPin, Clock, TrendingUp } from 'lucide-react';
import { Munro, getMunroByIndex, getMunroCount } from '../lib/supabase';

interface MunroDisplayProps {
  className?: string;
}

export default function MunroDisplay({ className = '' }: MunroDisplayProps) {
  const [currentMunro, setCurrentMunro] = useState<Munro | null>(null);
  const [munroCount, setMunroCount] = useState<number>(0);
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());
  const [imageError, setImageError] = useState(false);
  const [debugInfo, setDebugInfo] = useState<string>('');

  // Update time every minute
  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 60000);

    return () => clearInterval(timer);
  }, []);

  // Initialize munro count
  useEffect(() => {
    const initializeCount = async () => {
      try {
        const count = await getMunroCount();
        console.log('MMM-SMH: Total Munros in database:', count);
        setMunroCount(count);
        setDebugInfo(`DB Count: ${count}`);
      } catch (error) {
        console.error('MMM-SMH: Error getting munro count:', error);
        setDebugInfo('Error loading count');
      }
    };

    initializeCount();
  }, []);

  // Load munro by index
  const loadMunro = async (index: number) => {
    if (munroCount === 0) return;
    
    try {
      console.log(`MMM-SMH: Loading Munro at index ${index} of ${munroCount}`);
      setIsTransitioning(true);
      setImageError(false);
      
      const munro = await getMunroByIndex(index);
      
      if (munro) {
        console.log(`MMM-SMH: Loaded Munro: ${munro.name} (${index + 1}/${munroCount})`);
        setTimeout(() => {
          setCurrentMunro(munro);
          setIsTransitioning(false);
        }, 300);
      } else {
        console.error(`MMM-SMH: No Munro found at index ${index}`);
        setDebugInfo(`No Munro at index ${index}`);
      }
    } catch (error) {
      console.error('MMM-SMH: Error loading munro:', error);
      setDebugInfo(`Error loading index ${index}`);
      setIsTransitioning(false);
    }
  };

  // Calculate current Munro index based on UTC hour
  const getCurrentMunroIndex = () => {
    if (munroCount === 0) return 0;
    
    const now = new Date();
    const hoursSinceEpoch = Math.floor(now.getTime() / (1000 * 60 * 60));
    const calculatedIndex = hoursSinceEpoch % munroCount;
    
    console.log(`MMM-SMH: Time calculation - UTC: ${now.toISOString()}, Hours since epoch: ${hoursSinceEpoch}, Index: ${calculatedIndex}`);
    
    return calculatedIndex;
  };

  // Initialize with calculated current munro based on time
  useEffect(() => {
    if (munroCount > 0) {
      const calculatedIndex = getCurrentMunroIndex();
      console.log(`MMM-SMH: Initializing with calculated index ${calculatedIndex}`);
      setCurrentIndex(calculatedIndex);
      loadMunro(calculatedIndex);
    }
  }, [munroCount]);

  // Check for hour changes and update munro accordingly
  useEffect(() => {
    if (munroCount === 0) return;

    const checkForHourChange = () => {
      const newIndex = getCurrentMunroIndex();
      
      if (newIndex !== currentIndex) {
        console.log(`MMM-SMH: Hour changed! Switching from Munro ${currentIndex} to ${newIndex}`);
        setCurrentIndex(newIndex);
        loadMunro(newIndex);
      }
    };

    // Check every minute for hour changes
    const interval = setInterval(checkForHourChange, 60000);

    return () => clearInterval(interval);
  }, [munroCount, currentIndex]);

  // REMOVE IN PRODUCTION: Manual cycling for testing
  useEffect(() => {
    // Only enable manual controls in development mode
    if (process.env.NODE_ENV !== 'development') return;

    const handleKeyPress = (event: KeyboardEvent) => {
      if (event.key === 'ArrowRight' && munroCount > 0) {
        const nextIndex = (currentIndex + 1) % munroCount;
        console.log(`MMM-SMH: Manual advance to index ${nextIndex}`);
        setCurrentIndex(nextIndex);
        loadMunro(nextIndex);
      } else if (event.key === 'ArrowLeft' && munroCount > 0) {
        const prevIndex = currentIndex === 0 ? munroCount - 1 : currentIndex - 1;
        console.log(`MMM-SMH: Manual back to index ${prevIndex}`);
        setCurrentIndex(prevIndex);
        loadMunro(prevIndex);
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, [currentIndex, munroCount]);

  const getDifficultyColor = (rating: number) => {
    const colors = {
      1: 'text-green-400',
      2: 'text-yellow-400', 
      3: 'text-orange-400',
      4: 'text-red-400',
      5: 'text-red-500'
    };
    return colors[rating as keyof typeof colors] || 'text-gray-400';
  };

  const getDifficultyText = (rating: number) => {
    const texts = {
      1: 'Easy',
      2: 'Moderate', 
      3: 'Challenging',
      4: 'Difficult',
      5: 'Extreme'
    };
    return texts[rating as keyof typeof texts] || 'Unknown';
  };

  // Get the correct image path for MagicMirror and development
  const getImagePath = (filename: string) => {
    // For development mode, use the public folder directly
    if (import.meta.env.DEV) {
      return `/images/munros/${filename}`;
    }
    
    // For production/MagicMirror, try multiple possible paths
    const basePaths = [
      'modules/MMM-SMH/dist/images/munros/',
      'modules/MMM-SMH/public/images/munros/',
      'modules/MMM-SMH/images/munros/',
      '/modules/MMM-SMH/dist/images/munros/',
      '/modules/MMM-SMH/public/images/munros/',
      '/modules/MMM-SMH/images/munros/',
      // Also try relative paths from dist
      'images/munros/',
      './images/munros/'
    ];
    
    // Return the first path (we'll handle fallbacks in onError)
    return basePaths[0] + filename;
  };

  const handleImageError = (e: React.SyntheticEvent<HTMLImageElement>) => {
    const img = e.target as HTMLImageElement;
    const filename = currentMunro?.image_filename;
    
    if (!filename) return;
    
    // Try alternative paths
    const altPaths = [
      'modules/MMM-SMH/public/images/munros/' + filename,
      'modules/MMM-SMH/images/munros/' + filename,
      '/modules/MMM-SMH/dist/images/munros/' + filename,
      '/modules/MMM-SMH/public/images/munros/' + filename,
      '/modules/MMM-SMH/images/munros/' + filename,
      'images/munros/' + filename,
      './images/munros/' + filename,
      // Fallback to development path
      '/images/munros/' + filename
    ];
    
    const currentSrc = img.src;
    const currentPathIndex = altPaths.findIndex(path => currentSrc.includes(path.split('/').pop() || ''));
    
    if (currentPathIndex < altPaths.length - 1) {
      // Try next path
      const nextPath = altPaths[currentPathIndex + 1];
      console.log(`MMM-SMH: Image failed, trying: ${nextPath}`);
      img.src = nextPath;
    } else {
      // All paths failed, show placeholder
      console.log(`MMM-SMH: All image paths failed for: ${filename}`);
      setImageError(true);
    }
  };

  // Calculate time until next Munro change
  const getTimeUntilNextChange = () => {
    const now = new Date();
    const nextHour = new Date(now);
    nextHour.setHours(now.getHours() + 1, 0, 0, 0);
    const minutesUntilNext = Math.ceil((nextHour.getTime() - now.getTime()) / (1000 * 60));
    return minutesUntilNext;
  };

  if (!currentMunro) {
    return (
      <div className={`text-white max-w-md ${className}`}>
        <div className="flex items-center space-x-2 mb-2">
          <Mountain className="w-5 h-5 text-blue-400 animate-pulse" />
          <div>
            <div className="text-base font-light">Scottish Munros</div>
            <div className="text-sm text-gray-400">
              {munroCount > 0 ? `Loading... (${debugInfo})` : 'Connecting to database...'}
            </div>
          </div>
        </div>
      </div>
    );
  }

  const minutesUntilNext = getTimeUntilNextChange();

  return (
    <div className={`text-white max-w-md ${className}`}>
      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'}`}>
        {/* Header */}
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center space-x-2">
            <Mountain className="w-5 h-5 text-blue-400" />
            <div>
              <div className="text-base font-light">Scottish Munros</div>
              <div className="text-sm text-gray-400">
                {currentIndex + 1} of {munroCount} • Next in {minutesUntilNext}min
              </div>
            </div>
          </div>
          <div className="text-xs text-gray-500">
            {currentTime.toLocaleTimeString('en-GB', { 
              hour: '2-digit', 
              minute: '2-digit',
              timeZone: 'UTC'
            })} UTC
          </div>
        </div>

        {/* Main content */}
        <div className="space-y-4">
          {/* Larger mountain image */}
          <div className="w-full">
            {!imageError ? (
              <img 
                src={getImagePath(currentMunro.image_filename)}
                alt={currentMunro.name}
                className="w-full h-48 object-cover rounded-lg bg-gray-800"
                onError={handleImageError}
                style={{ width: '100%', height: '192px' }}
              />
            ) : (
              <div className="w-full h-48 bg-gray-800 rounded-lg flex items-center justify-center">
                <Mountain className="w-12 h-12 text-gray-400" />
              </div>
            )}
          </div>
          
          {/* Mountain name and basic info */}
          <div>
            <h2 className="text-xl font-light mb-3">{currentMunro.name}</h2>
            <div className="grid grid-cols-1 gap-2 text-sm mb-4">
              <div className="flex items-center space-x-2">
                <TrendingUp className="w-4 h-4 text-blue-400 flex-shrink-0" />
                <span>{currentMunro.height_m}m ({currentMunro.height_ft}ft)</span>
              </div>
              <div className="flex items-center space-x-2">
                <MapPin className="w-4 h-4 text-green-400 flex-shrink-0" />
                <span>{currentMunro.area}, {currentMunro.region}</span>
              </div>
            </div>
          </div>

          {/* Key stats in compact format */}
          <div className="grid grid-cols-3 gap-3 text-center">
            <div className="bg-gray-800 bg-opacity-50 rounded-lg p-3">
              <div className="text-base font-light text-blue-400">{currentMunro.prominence_m}m</div>
              <div className="text-xs text-gray-400">Prominence</div>
            </div>
            <div className="bg-gray-800 bg-opacity-50 rounded-lg p-3">
              <div className={`text-base font-light ${getDifficultyColor(currentMunro.difficulty_rating)}`}>
                {currentMunro.difficulty_rating}/5
              </div>
              <div className="text-xs text-gray-400">{getDifficultyText(currentMunro.difficulty_rating)}</div>
            </div>
            <div className="bg-gray-800 bg-opacity-50 rounded-lg p-3">
              <div className="text-base font-light text-yellow-400">{currentMunro.estimated_time_hours}h</div>
              <div className="text-xs text-gray-400">Est. Time</div>
            </div>
          </div>

          {/* Description - expanded for larger module */}
          <div className="bg-gray-800 bg-opacity-30 rounded-lg p-3">
            <p className="text-sm text-gray-300 leading-relaxed line-clamp-4">
              {currentMunro.description.length > 180 
                ? currentMunro.description.substring(0, 180) + '...'
                : currentMunro.description
              }
            </p>
          </div>

          {/* Best seasons - expanded pills */}
          {currentMunro.best_seasons.length > 0 && (
            <div className="flex flex-wrap gap-2">
              {currentMunro.best_seasons.slice(0, 4).map((season, index) => (
                <span 
                  key={index}
                  className="px-3 py-1 bg-blue-900 bg-opacity-40 text-blue-200 rounded-full text-sm border border-blue-700 border-opacity-30"
                >
                  {season}
                </span>
              ))}
            </div>
          )}

          {/* Debug info - only in development */}
          {process.env.NODE_ENV === 'development' && (
            <div className="text-xs text-gray-500 mt-2 p-2 bg-gray-900 bg-opacity-50 rounded">
              <div>Debug: Index {currentIndex}, UTC Hour: {new Date().getUTCHours()}</div>
              <div>Hours since epoch: {Math.floor(Date.now() / (1000 * 60 * 60))}</div>
              <div>Calc: {Math.floor(Date.now() / (1000 * 60 * 60)) % munroCount}</div>
              <div>Next change: {minutesUntilNext} minutes</div>
              <div className="text-yellow-400 mt-1">Use ← → arrow keys to manually cycle</div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}