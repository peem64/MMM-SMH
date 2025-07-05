import React, { useState, useEffect } from 'react';
import { Mountain, MapPin, Clock, TrendingUp, Route, Star } from 'lucide-react';

interface Corbett {
  id: number;
  name: string;
  location: string;
  region: string;
  height: number;
  prominence: number;
  classification: string;
  estimated_time: string;
  description: string;
  difficulty_rating: number;
  popular_routes: string[];
  best_seasons: string[];
  grid_reference: string;
  nearest_town: string;
  parking_info: string;
  image_filename: string;
  created_at: string;
  updated_at: string;
}

interface CorbettDisplayProps {
  className?: string;
}

export default function CorbettDisplay({ className = '' }: CorbettDisplayProps) {
  const [currentCorbett, setCurrentCorbett] = useState<Corbett | null>(null);
  const [corbettCount, setCorbettCount] = useState<number>(0);
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());
  const [imageStatus, setImageStatus] = useState<'loading' | 'loaded' | 'error'>('loading');
  const [imageUrl, setImageUrl] = useState<string>('');
  const [debugInfo, setDebugInfo] = useState<string>('');

  // Mock data for demonstration
  const mockCorbetts: Corbett[] = [
    {
      id: 1,
      name: "Ben Nevis",
      location: "Fort William",
      region: "Lochaber",
      height: 1345,
      prominence: 1345,
      classification: "Corbett",
      estimated_time: "7-9 hours",
      description: "The highest mountain in Scotland and the British Isles, Ben Nevis is a challenging climb with spectacular views. The summit plateau can be treacherous in poor weather conditions.",
      difficulty_rating: 4,
      popular_routes: ["Tourist Path", "CMD Arete", "Tower Ridge"],
      best_seasons: ["Late Spring", "Summer", "Early Autumn"],
      grid_reference: "NN166712",
      nearest_town: "Fort William",
      parking_info: "Glen Nevis car park",
      image_filename: "ben_nevis.jpg",
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    }
  ];

  // Update time every minute
  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentTime(new Date());
    }, 60000);

    return () => clearInterval(timer);
  }, []);

  // Initialize with mock data
  useEffect(() => {
    setCorbettCount(mockCorbetts.length);
    setCurrentCorbett(mockCorbetts[0]);
    setCurrentIndex(0);
    setDebugInfo(`Mock data: ${mockCorbetts.length} corbetts`);
  }, []);

  // Mock image handling
  useEffect(() => {
    if (!currentCorbett?.image_filename) {
      setImageStatus('error');
      setImageUrl('');
      return;
    }

    setImageStatus('loading');
    setTimeout(() => {
      setImageStatus('error'); // Mock no images available
      setImageUrl('');
    }, 1000);
  }, [currentCorbett?.image_filename]);

  const getDifficultyStars = (rating: number) => {
    return Array.from({ length: 5 }, (_, i) => (
      <Star 
        key={i} 
        className={`w-3 h-3 ${i < rating ? 'text-yellow-400 fill-current' : 'text-gray-600'}`} 
      />
    ));
  };

  // Calculate time until next change
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

  if (!currentCorbett) {
    return (
      <div className={`text-white max-w-xs ${className}`}>
        <div className="flex items-center space-x-2 mb-2">
          <Mountain className="w-4 h-4 text-blue-400 animate-pulse" />
          <div>
            <div className="text-sm font-light">Scottish Corbetts</div>
            <div className="text-xs text-gray-400">
              {corbettCount > 0 ? `Loading... (${debugInfo})` : 'Connecting...'}
            </div>
          </div>
        </div>
      </div>
    );
  }

  const minutesUntilNext = getTimeUntilNextChange();

  return (
    <div className={`text-white max-w-xs ${className}`}>
      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'} space-y-3`}>
        
        {/* Header with title and time */}
        <div className="bg-gray-800 bg-opacity-50 rounded-xl p-4 border border-gray-700">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center space-x-3">
              <Mountain className="w-5 h-5 text-blue-400" />
              <span className="text-lg font-light">Scottish Corbetts</span>
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
            {currentIndex + 1} of {corbettCount} • {minutesUntilNext}min
          </div>
        </div>

        {/* Mountain name and height */}
        <div className="bg-gray-800 bg-opacity-50 rounded-xl p-4 border border-gray-700">
          <div className="flex items-center justify-between mb-2">
            <Mountain className="w-6 h-6 text-green-400" />
            <div className="text-2xl font-bold text-green-400">
              {currentCorbett.height}m
            </div>
          </div>
          <h2 className="text-xl font-medium text-white leading-relaxed">
            {currentCorbett.name}
          </h2>
        </div>

        {/* Mountain image */}
        <div className="bg-gray-800 bg-opacity-50 rounded-xl overflow-hidden border border-gray-700">
          <div className="relative">
            {imageStatus === 'loaded' && imageUrl ? (
              <img 
                src={imageUrl}
                alt={currentCorbett.name}
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
                <span className="text-sm">{currentCorbett.location}, {currentCorbett.region}</span>
              </div>
            </div>
          </div>
        </div>

        {/* Stats grid */}
        <div className="bg-gray-800 bg-opacity-50 rounded-xl p-4 border border-gray-700">
          <div className="grid grid-cols-3 gap-4">
            <div className="text-center">
              <div className="text-lg font-bold text-blue-400">{currentCorbett.prominence}m</div>
              <div className="text-xs text-gray-400">Prominence</div>
            </div>
            <div className="text-center">
              <div className="text-lg font-bold text-green-400">{currentCorbett.estimated_time}</div>
              <div className="text-xs text-gray-400">Time</div>
            </div>
            <div className="text-center">
              <div className="flex justify-center space-x-1 mb-1">
                {getDifficultyStars(currentCorbett.difficulty_rating)}
              </div>
              <div className="text-xs text-gray-400">Difficulty</div>
            </div>
          </div>
        </div>

        {/* Description */}
        <div className="bg-gray-800 bg-opacity-50 rounded-xl p-4 border border-gray-700">
          <p className="text-sm text-gray-300 leading-relaxed line-clamp-4">
            {currentCorbett.description}
          </p>
        </div>

        {/* Popular Routes */}
        {currentCorbett.popular_routes && currentCorbett.popular_routes.length > 0 && (
          <div className="bg-gray-800 bg-opacity-50 rounded-xl p-4 border border-gray-700">
            <div className="flex items-center space-x-2 mb-3">
              <Route className="w-4 h-4 text-orange-400" />
              <span className="text-sm font-medium text-orange-400">Popular Routes</span>
            </div>
            <div className="space-y-2">
              {currentCorbett.popular_routes.slice(0, 3).map((route, index) => (
                <div key={index} className="text-sm text-gray-300">
                  • {route}
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Best Seasons */}
        {currentCorbett.best_seasons && currentCorbett.best_seasons.length > 0 && (
          <div className="bg-gray-800 bg-opacity-50 rounded-xl p-4 border border-gray-700">
            <div className="flex items-center space-x-2 mb-3">
              <Clock className="w-4 h-4 text-green-400" />
              <span className="text-sm font-medium text-green-400">Best Seasons</span>
            </div>
            <div className="flex flex-wrap gap-2">
              {currentCorbett.best_seasons.slice(0, 4).map((season, index) => (
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
          <div className="bg-gray-900 bg-opacity-50 rounded-xl p-4 border border-gray-600">
            <div className="text-xs text-gray-400 space-y-1">
              <div>Debug: Index {currentIndex}, UTC Hour: {new Date().getUTCHours()}</div>
              <div>Next change: {minutesUntilNext} minutes</div>
              <div>Image status: {imageStatus}</div>
              <div className="text-yellow-400">Mock data - no database connection</div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}