import React, { useState, useEffect } from 'react';
import { Mountain, MapPin, Clock, TrendingUp, Calendar, Info, Route } from 'lucide-react';
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

  // Update time every second
  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 1000);

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
      5: 'text-red-600'
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
      <div className={`flex items-center justify-center min-h-screen bg-gray-900 text-white ${className}`}>
        <div className="text-center">
          <Mountain className="w-16 h-16 mx-auto mb-4 text-blue-400 animate-pulse" />
          <p className="text-xl">Loading Scottish Munros...</p>
        </div>
      </div>
    );
  }

  return (
    <div className={`min-h-screen bg-gradient-to-br from-gray-900 via-blue-900 to-gray-800 text-white p-6 ${className}`}>
      {/* Header with time */}
      <div className="flex justify-between items-center mb-8 border-b border-gray-700 pb-4">
        <div className="flex items-center space-x-3">
          <Mountain className="w-8 h-8 text-blue-400" />
          <h1 className="text-2xl font-bold">Scottish Munros</h1>
        </div>
        <div className="text-right">
          <div className="text-2xl font-mono">
            {currentTime.toLocaleTimeString()}
          </div>
          <div className="text-sm text-gray-400">
            Munro {currentIndex + 1} of {munroCount}
          </div>
        </div>
      </div>

      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-0' : 'opacity-100'}`}>
        {/* Main content grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left column - Image and basic info */}
          <div className="lg:col-span-1">
            <div className="bg-gray-800 rounded-lg overflow-hidden shadow-2xl">
              <div className="aspect-w-16 aspect-h-12 bg-gray-700 flex items-center justify-center">
                <img 
                  src={`/images/munros/${currentMunro.image_filename}`}
                  alt={currentMunro.name}
                  className="w-full h-64 object-cover"
                  onError={(e) => {
                    // Fallback to placeholder if image not found
                    (e.target as HTMLImageElement).src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAwIiBoZWlnaHQ9IjMwMCIgdmlld0JveD0iMCAwIDQwMCAzMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI0MDAiIGhlaWdodD0iMzAwIiBmaWxsPSIjMzc0MTUxIi8+Cjxwb2x5Z29uIHBvaW50cz0iMjAwLDgwIDI4MCwxODAgMTIwLDE4MCIgZmlsbD0iIzZCNzI4MCIvPgo8cG9seWdvbiBwb2ludHM9IjMwMCwxMjAgMzYwLDE4MCAyNDAsMTgwIiBmaWxsPSIjOTE5N0E3Ii8+Cjx0ZXh0IHg9IjIwMCIgeT0iMjMwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjRDFENURCIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPk11bnJvIEltYWdlPC90ZXh0Pgo8L3N2Zz4K';
                  }}
                />
              </div>
              <div className="p-6">
                <h2 className="text-3xl font-bold mb-2">{currentMunro.name}</h2>
                <div className="space-y-3">
                  <div className="flex items-center space-x-2">
                    <TrendingUp className="w-5 h-5 text-blue-400" />
                    <span className="text-lg">
                      {currentMunro.height_m}m ({currentMunro.height_ft}ft)
                    </span>
                  </div>
                  <div className="flex items-center space-x-2">
                    <MapPin className="w-5 h-5 text-green-400" />
                    <span>{currentMunro.area}, {currentMunro.region}</span>
                  </div>
                  <div className="flex items-center space-x-2">
                    <Mountain className="w-5 h-5 text-purple-400" />
                    <span>Grid Ref: {currentMunro.grid_ref}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Right columns - Detailed information */}
          <div className="lg:col-span-2 space-y-6">
            {/* Quick stats */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              <div className="bg-gray-800 rounded-lg p-4 text-center">
                <div className="text-2xl font-bold text-blue-400">{currentMunro.prominence_m}m</div>
                <div className="text-sm text-gray-400">Prominence</div>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 text-center">
                <div className={`text-2xl font-bold ${getDifficultyColor(currentMunro.difficulty_rating)}`}>
                  {currentMunro.difficulty_rating}/5
                </div>
                <div className="text-sm text-gray-400">
                  {getDifficultyText(currentMunro.difficulty_rating)}
                </div>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 text-center">
                <div className="text-2xl font-bold text-yellow-400">
                  {currentMunro.estimated_time_hours}h
                </div>
                <div className="text-sm text-gray-400">Est. Time</div>
              </div>
              <div className="bg-gray-800 rounded-lg p-4 text-center">
                <div className="text-2xl font-bold text-green-400">
                  {currentMunro.first_ascent_year || 'Unknown'}
                </div>
                <div className="text-sm text-gray-400">First Ascent</div>
              </div>
            </div>

            {/* Description */}
            <div className="bg-gray-800 rounded-lg p-6">
              <div className="flex items-center space-x-2 mb-4">
                <Info className="w-5 h-5 text-blue-400" />
                <h3 className="text-xl font-semibold">Description</h3>
              </div>
              <p className="text-gray-300 leading-relaxed">{currentMunro.description}</p>
              {currentMunro.significant_info && (
                <div className="mt-4 p-4 bg-blue-900/30 rounded-lg border-l-4 border-blue-400">
                  <p className="text-blue-200">{currentMunro.significant_info}</p>
                </div>
              )}
            </div>

            {/* Routes and Seasons */}
            <div className="grid md:grid-cols-2 gap-6">
              <div className="bg-gray-800 rounded-lg p-6">
                <div className="flex items-center space-x-2 mb-4">
                  <Route className="w-5 h-5 text-green-400" />
                  <h3 className="text-xl font-semibold">Popular Routes</h3>
                </div>
                <ul className="space-y-2">
                  {currentMunro.popular_routes.map((route, index) => (
                    <li key={index} className="flex items-start space-x-2">
                      <span className="text-green-400 mt-1">•</span>
                      <span className="text-gray-300">{route}</span>
                    </li>
                  ))}
                </ul>
              </div>

              <div className="bg-gray-800 rounded-lg p-6">
                <div className="flex items-center space-x-2 mb-4">
                  <Calendar className="w-5 h-5 text-orange-400" />
                  <h3 className="text-xl font-semibold">Best Seasons</h3>
                </div>
                <div className="flex flex-wrap gap-2">
                  {currentMunro.best_seasons.map((season, index) => (
                    <span 
                      key={index}
                      className="px-3 py-1 bg-orange-900/30 text-orange-200 rounded-full text-sm border border-orange-700"
                    >
                      {season}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Next change indicator */}
        <div className="mt-8 text-center text-gray-400">
          <Clock className="w-4 h-4 inline mr-2" />
          Next Munro changes at {new Date(Math.ceil(Date.now() / (1000 * 60 * 60)) * (1000 * 60 * 60)).toLocaleTimeString()}
        </div>
      </div>
    </div>
  );
}