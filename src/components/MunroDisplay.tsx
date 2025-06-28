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
      const count = await getMunroCount();
      setMunroCount(count);
    };

    initializeCount();
  }, []);

  // Load munro by index
  const loadMunro = async (index: number) => {
    if (munroCount === 0) return;
    
    setIsTransitioning(true);
    setImageError(false);
    const munro = await getMunroByIndex(index);
    
    setTimeout(() => {
      setCurrentMunro(munro);
      setIsTransitioning(false);
    }, 300);
  };

  // Initialize with first munro
  useEffect(() => {
    if (munroCount > 0) {
      loadMunro(0);
    }
  }, [munroCount]);

  // Change munro every hour
  useEffect(() => {
    if (munroCount === 0) return;

    const updateMunro = () => {
      const hoursSinceEpoch = Math.floor(Date.now() / (1000 * 60 * 60));
      const newIndex = hoursSinceEpoch % munroCount;
      
      if (newIndex !== currentIndex) {
        setCurrentIndex(newIndex);
        loadMunro(newIndex);
      }
    };

    // Check immediately
    updateMunro();

    // Check every minute (to catch hour changes)
    const interval = setInterval(updateMunro, 60000);

    return () => clearInterval(interval);
  }, [munroCount, currentIndex]);

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

  // Get the correct image path for MagicMirror
  const getImagePath = (filename: string) => {
    // Try multiple possible paths for MagicMirror
    const basePaths = [
      'modules/MMM-SMH/dist/images/munros/',
      'modules/MMM-SMH/public/images/munros/',
      'modules/MMM-SMH/images/munros/',
      '/modules/MMM-SMH/dist/images/munros/',
      '/modules/MMM-SMH/public/images/munros/',
      '/modules/MMM-SMH/images/munros/'
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
      '/modules/MMM-SMH/images/munros/' + filename
    ];
    
    const currentSrc = img.src;
    const currentPathIndex = altPaths.findIndex(path => currentSrc.includes(path));
    
    if (currentPathIndex < altPaths.length - 1) {
      // Try next path
      img.src = altPaths[currentPathIndex + 1];
    } else {
      // All paths failed, show placeholder
      setImageError(true);
    }
  };

  if (!currentMunro) {
    return (
      <div className={`text-white ${className}`}>
        <div className="flex items-center space-x-3 mb-3">
          <Mountain className="w-6 h-6 text-blue-400 animate-pulse" />
          <div>
            <div className="text-lg font-light">Scottish Munros</div>
            <div className="text-sm text-gray-400">Loading...</div>
          </div>
        </div>
      </div>
    );
  }

  const nextChangeTime = new Date(Math.ceil(Date.now() / (1000 * 60 * 60)) * (1000 * 60 * 60));

  return (
    <div className={`text-white ${className}`}>
      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'}`}>
        {/* Header */}
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center space-x-3">
            <Mountain className="w-6 h-6 text-blue-400" />
            <div>
              <div className="text-lg font-light">Scottish Munros</div>
              <div className="text-xs text-gray-400">
                {currentIndex + 1} of {munroCount} • Next: {nextChangeTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
              </div>
            </div>
          </div>
        </div>

        {/* Main content - compact layout */}
        <div className="space-y-4">
          {/* Mountain image - small thumbnail */}
          <div className="flex items-start space-x-3">
            <div className="flex-shrink-0">
              {!imageError ? (
                <img 
                  src={getImagePath(currentMunro.image_filename)}
                  alt={currentMunro.name}
                  className="w-16 h-12 object-cover rounded-lg bg-gray-800"
                  onError={handleImageError}
                  style={{ minWidth: '64px', minHeight: '48px' }}
                />
              ) : (
                <div className="w-16 h-12 bg-gray-800 rounded-lg flex items-center justify-center">
                  <Mountain className="w-6 h-6 text-gray-400" />
                </div>
              )}
            </div>
            
            {/* Mountain name and basic info */}
            <div className="flex-1 min-w-0">
              <h2 className="text-2xl font-light mb-2 truncate">{currentMunro.name}</h2>
              <div className="grid grid-cols-1 gap-2 text-sm">
                <div className="flex items-center space-x-2">
                  <TrendingUp className="w-4 h-4 text-blue-400 flex-shrink-0" />
                  <span>{currentMunro.height_m}m ({currentMunro.height_ft}ft)</span>
                </div>
                <div className="flex items-center space-x-2">
                  <MapPin className="w-4 h-4 text-green-400 flex-shrink-0" />
                  <span className="truncate">{currentMunro.area}, {currentMunro.region}</span>
                </div>
              </div>
            </div>
          </div>

          {/* Key stats in compact format */}
          <div className="grid grid-cols-3 gap-3 text-center">
            <div className="bg-gray-800 bg-opacity-50 rounded-lg p-3">
              <div className="text-lg font-light text-blue-400">{currentMunro.prominence_m}m</div>
              <div className="text-xs text-gray-400">Prominence</div>
            </div>
            <div className="bg-gray-800 bg-opacity-50 rounded-lg p-3">
              <div className={`text-lg font-light ${getDifficultyColor(currentMunro.difficulty_rating)}`}>
                {currentMunro.difficulty_rating}/5
              </div>
              <div className="text-xs text-gray-400">{getDifficultyText(currentMunro.difficulty_rating)}</div>
            </div>
            <div className="bg-gray-800 bg-opacity-50 rounded-lg p-3">
              <div className="text-lg font-light text-yellow-400">{currentMunro.estimated_time_hours}h</div>
              <div className="text-xs text-gray-400">Est. Time</div>
            </div>
          </div>

          {/* Description - truncated for space */}
          <div className="bg-gray-800 bg-opacity-30 rounded-lg p-3">
            <p className="text-sm text-gray-300 leading-relaxed line-clamp-3">
              {currentMunro.description.length > 150 
                ? currentMunro.description.substring(0, 150) + '...'
                : currentMunro.description
              }
            </p>
          </div>

          {/* Best seasons - compact pills */}
          {currentMunro.best_seasons.length > 0 && (
            <div className="flex flex-wrap gap-2">
              {currentMunro.best_seasons.slice(0, 3).map((season, index) => (
                <span 
                  key={index}
                  className="px-2 py-1 bg-blue-900 bg-opacity-40 text-blue-200 rounded-full text-xs border border-blue-700 border-opacity-30"
                >
                  {season}
                </span>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}