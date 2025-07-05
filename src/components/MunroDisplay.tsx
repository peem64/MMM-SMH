import React, { useState, useEffect } from 'react';
import { Mountain, MapPin, Clock, TrendingUp, Route, Star } from 'lucide-react';
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
  const [imageStatus, setImageStatus] = useState<'loading' | 'loaded' | 'error'>('loading');
  const [imageUrl, setImageUrl] = useState<string>('');
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

  // Preload image when munro changes
  useEffect(() => {
    if (!currentMunro?.image_filename) {
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
      const filename = currentMunro.image_filename;
      const altPaths = [
        'modules/MMM-SMH/public/images/munros/' + filename,
        'modules/MMM-SMH/images/munros/' + filename,
        '/modules/MMM-SMH/dist/images/munros/' + filename,
        '/modules/MMM-SMH/public/images/munros/' + filename,
        '/modules/MMM-SMH/images/munros/' + filename,
        'images/munros/' + filename,
        './images/munros/' + filename,
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
        // All paths failed
        console.log(`MMM-SMH: All image paths failed for: ${filename}`);
        setImageStatus('error');
        setImageUrl('');
      }
    };
    
    img.addEventListener('load', handleLoad);
    img.addEventListener('error', handleError);
    
    // Start loading with the first path
    img.src = getImagePath(currentMunro.image_filename);
    
    return () => {
      img.removeEventListener('load', handleLoad);
      img.removeEventListener('error', handleError);
    };
  }, [currentMunro?.image_filename]);

  // Load munro by index
  const loadMunro = async (index: number) => {
    if (munroCount === 0) return;
    
    try {
      console.log(`MMM-SMH: Loading Munro at index ${index} of ${munroCount}`);
      setIsTransitioning(true);
      setImageStatus('loading');
      setImageUrl('');
      
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

  // Calculate time until next Munro change
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

  if (!currentMunro) {
    return (
      <div className={`text-white max-w-xs ${className}`}>
        <div className="flex items-center space-x-2 mb-2">
          <Mountain className="w-4 h-4 text-blue-400 animate-pulse" />
          <div>
            <div className="text-sm font-light">Scottish Munros</div>
            <div className="text-xs text-gray-400">
              {munroCount > 0 ? `Loading... (${debugInfo})` : 'Connecting...'}
            </div>
          </div>
        </div>
      </div>
    );
  }

  const minutesUntilNext = getTimeUntilNextChange();

  return (
    <div className={`text-white max-w-xs ${className}`}>
      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'}`}>
        
        {/* Header - exactly like Corbett module */}
        <div className="flex items-center space-x-2 mb-2">
          <Mountain className="w-4 h-4 text-blue-400" />
          <div>
            <div className="text-sm font-light">Scottish Munros</div>
            <div className="text-xs text-gray-400">
              {currentTime.toLocaleTimeString('en-GB', { 
                hour: '2-digit', 
                minute: '2-digit',
                timeZone: 'UTC'
              })} • {currentIndex + 1} of {munroCount} • {minutesUntilNext}min
            </div>
          </div>
        </div>

        {/* Mountain name and height - simple layout like Corbett */}
        <div className="mb-3">
          <div className="flex items-center justify-between">
            <h2 className="text-lg font-medium text-white">
              {currentMunro.name}
            </h2>
            <div className="text-lg font-bold text-green-400">
              {currentMunro.height_m}m
            </div>
          </div>
          <div className="text-xs text-gray-400 mt-1">
            {currentMunro.area}, {currentMunro.region}
          </div>
        </div>

        {/* Mountain image - simple without overlay */}
        <div className="mb-3">
          {imageStatus === 'loaded' && imageUrl ? (
            <img 
              src={imageUrl}
              alt={currentMunro.name}
              className="w-full h-20 object-cover rounded"
            />
          ) : imageStatus === 'loading' ? (
            <div className="w-full h-20 bg-gray-700 flex items-center justify-center rounded">
              <Mountain className="w-8 h-8 text-gray-400 animate-pulse" />
            </div>
          ) : (
            <div className="w-full h-20 bg-gray-700 flex items-center justify-center rounded">
              <Mountain className="w-8 h-8 text-gray-400" />
            </div>
          )}
        </div>

        {/* Stats - simple grid like Corbett */}
        <div className="grid grid-cols-3 gap-2 mb-3 text-xs">
          <div className="text-center">
            <div className="text-blue-400 font-medium">{currentMunro.prominence_m}m</div>
            <div className="text-gray-400">Prominence</div>
          </div>
          <div className="text-center">
            <div className="text-green-400 font-medium">{currentMunro.estimated_time_hours}h</div>
            <div className="text-gray-400">Time</div>
          </div>
          <div className="text-center">
            <div className="flex justify-center space-x-1 mb-1">
              {getDifficultyStars(currentMunro.difficulty_rating)}
            </div>
            <div className="text-gray-400">Difficulty</div>
          </div>
        </div>

        {/* Description - simple text like Corbett */}
        <div className="mb-3">
          <p className="text-xs text-gray-300 leading-relaxed line-clamp-3">
            {currentMunro.description}
          </p>
        </div>

        {/* Routes - simple list like Corbett */}
        {currentMunro.popular_routes && currentMunro.popular_routes.length > 0 && (
          <div className="mb-3">
            <div className="text-xs text-orange-400 mb-1">Popular Routes:</div>
            <div className="text-xs text-gray-300">
              {currentMunro.popular_routes.slice(0, 2).join(', ')}
            </div>
          </div>
        )}

        {/* Seasons - simple badges like Corbett */}
        {currentMunro.best_seasons && currentMunro.best_seasons.length > 0 && (
          <div className="mb-3">
            <div className="text-xs text-green-400 mb-1">Best Seasons:</div>
            <div className="flex flex-wrap gap-1">
              {currentMunro.best_seasons.slice(0, 3).map((season, index) => (
                <span 
                  key={index}
                  className="px-2 py-1 bg-green-600 bg-opacity-30 text-green-300 rounded text-xs"
                >
                  {season}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* Debug info (development only) */}
        {process.env.NODE_ENV === 'development' && (
          <div className="text-xs text-yellow-400 mt-3">
            Debug: Index {currentIndex}, UTC Hour: {new Date().getUTCHours()}, Next: {minutesUntilNext}min
            <br />Use ← → arrow keys to cycle
          </div>
        )}
      </div>
    </div>
  );
}