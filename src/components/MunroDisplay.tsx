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
          {/* Mountain name and basic info */}
          <div>
            <h2 className="text-2xl font-light mb-2">{currentMunro.name}</h2>
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div className="flex items-center space-x-2">
                <TrendingUp className="w-4 h-4 text-blue-400" />
                <span>{currentMunro.height_m}m ({currentMunro.height_ft}ft)</span>
              </div>
              <div className="flex items-center space-x-2">
                <MapPin className="w-4 h-4 text-green-400" />
                <span>{currentMunro.area}</span>
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