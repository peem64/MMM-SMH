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
    nextHour.setHours(now.getHours() + 1, 0, 0, 0);
    const minutesUntilNext = Math.ceil((nextHour.getTime() - now.getTime()) / (1000 * 60));
    return minutesUntilNext;
  };

  if (!currentMunro) {
    return (
      <div className={`text-white w-80 ${className}`}>
        <div className="bg-gray-800 bg-opacity-90 rounded-xl p-4 backdrop-blur-sm border border-gray-700">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center space-x-2">
              <Mountain className="w-5 h-5 text-blue-400 animate-pulse" />
              <span className="text-lg font-light">Scottish Munros</span>
            </div>
            <div className="text-sm text-gray-400">
              {currentTime.toLocaleTimeString('en-GB', { 
                hour: '2-digit', 
                minute: '2-digit',
                timeZone: 'UTC'
              })}
            </div>
          </div>
          <div className="text-sm text-gray-400">
            {munroCount > 0 ? `Loading... (${debugInfo})` : 'Connecting...'}
          </div>
        </div>
      </div>
    );
  }

  const minutesUntilNext = getTimeUntilNextChange();

  return (
    <div className={`text-white w-80 ${className}`}>
      <div className={`bg-gray-800 bg-opacity-90 rounded-xl backdrop-blur-sm border border-gray-700 overflow-hidden transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'}`}>
        
        {/* Header */}
        <div className="flex items-center justify-between p-4 pb-2">
          <div className="flex items-center space-x-2">
            <Mountain className="w-5 h-5 text-blue-400" />
            <span className="text-lg font-light">Scottish Munros</span>
          </div>
          <div className="text-sm text-gray-400">
            {currentTime.toLocaleTimeString('en-GB', { 
              hour: '2-digit', 
              minute: '2-digit',
              timeZone: 'UTC'
            })}
          </div>
        </div>

        <div className="px-4 pb-3">
          <div className="text-xs text-gray-400">
            {currentIndex + 1} of {munroCount} • {minutesUntilNext}min
          </div>
        </div>

        {/* Mountain Name and Height Header - matching Corbetts style */}
        <div className="flex items-center justify-between px-4 pb-3">
          <div className="flex items-center space-x-2">
            <Mountain className="w-5 h-5 text-green-400" />
            <span className="text-xl font-medium text-white">{currentMunro.name}</span>
          </div>
          <div className="text-2xl font-bold text-green-400">
            {currentMunro.height_m}m
          </div>
        </div>

        {/* Mountain Image with location overlay */}
        <div className="relative mx-4 mb-4 rounded-lg overflow-hidden">
          {imageStatus === 'loaded' && imageUrl ? (
            <img 
              src={imageUrl}
              alt={currentMunro.name}
              className="w-full h-48 object-cover"
            />
          ) : imageStatus === 'loading' ? (
            <div className="w-full h-48 bg-gray-700 flex items-center justify-center">
              <Mountain className="w-12 h-12 text-gray-400 animate-pulse" />
            </div>
          ) : (
            <div className="w-full h-48 bg-gray-700 flex items-center justify-center">
              <Mountain className="w-12 h-12 text-gray-400" />
            </div>
          )}
          
          {/* Location Overlay */}
          <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/70 to-transparent p-3">
            <div className="flex items-center space-x-1 text-white text-sm">
              <MapPin className="w-4 h-4 text-green-400" />
              <span>{currentMunro.area}, {currentMunro.region}</span>
            </div>
          </div>
        </div>

        {/* Stats Grid - matching Corbetts layout */}
        <div className="grid grid-cols-3 gap-4 px-4 mb-4">
          <div className="bg-gray-700 bg-opacity-50 rounded-lg p-3 text-center">
            <div className="text-lg font-bold text-blue-400">{currentMunro.prominence_m}m</div>
            <div className="text-xs text-gray-400">Prominence</div>
          </div>
          <div className="bg-gray-700 bg-opacity-50 rounded-lg p-3 text-center">
            <div className="text-lg font-bold text-green-400">{currentMunro.estimated_time_hours}</div>
            <div className="text-xs text-gray-400">hours</div>
          </div>
          <div className="bg-gray-700 bg-opacity-50 rounded-lg p-3 text-center">
            <div className="flex justify-center space-x-1 mb-1">
              {getDifficultyStars(currentMunro.difficulty_rating)}
            </div>
            <div className="text-xs text-gray-400">Difficulty</div>
          </div>
        </div>

        {/* Description */}
        <div className="px-4 mb-4">
          <p className="text-sm text-gray-300 leading-relaxed">
            {currentMunro.description}
          </p>
        </div>

        {/* Popular Routes */}
        {currentMunro.popular_routes && currentMunro.popular_routes.length > 0 && (
          <div className="px-4 mb-4">
            <div className="flex items-center space-x-2 mb-2">
              <Route className="w-4 h-4 text-orange-400" />
              <span className="text-sm font-medium text-orange-400">Popular Routes</span>
            </div>
            <div className="space-y-1">
              {currentMunro.popular_routes.slice(0, 3).map((route, index) => (
                <div key={index} className="flex items-center space-x-2">
                  <div className="w-1 h-1 bg-green-400 rounded-full"></div>
                  <span className="text-xs text-gray-300">{route}</span>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Best Seasons */}
        {currentMunro.best_seasons.length > 0 && (
          <div className="px-4 pb-4">
            <div className="flex items-center space-x-2 mb-2">
              <Clock className="w-4 h-4 text-green-400" />
              <span className="text-sm font-medium text-green-400">Best Seasons</span>
            </div>
            <div className="flex flex-wrap gap-1">
              {currentMunro.best_seasons.slice(0, 4).map((season, index) => (
                <span 
                  key={index}
                  className="px-2 py-1 bg-green-600 bg-opacity-30 text-green-300 rounded text-xs border border-green-600 border-opacity-30"
                >
                  {season}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* Debug info - only in development */}
        {process.env.NODE_ENV === 'development' && (
          <div className="px-4 pb-4">
            <div className="text-xs text-gray-500 bg-gray-900 bg-opacity-50 rounded p-2 space-y-1">
              <div>Debug: Index {currentIndex}, UTC Hour: {new Date().getUTCHours()}</div>
              <div>Next change: {minutesUntilNext} minutes</div>
              <div>Image status: {imageStatus}</div>
              <div className="text-yellow-400">Use ← → arrow keys to cycle</div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}