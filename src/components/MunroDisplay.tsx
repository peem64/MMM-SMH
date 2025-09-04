import React, { useState, useEffect } from 'react';
import { Mountain, MapPin, Clock, TrendingUp, Route, Star, Check } from 'lucide-react';
import { 
  Mountain as MountainType, 
  getMountainByIndex, 
  getMountainCount, 
  getCurrentUser, 
  getUserCompletionStats, 
  CompletionStats,
  toggleMountainCompletion,
  getMountainCompletion,
  signInAnonymously
} from '../lib/supabase';
import { signInWithEmail, signUpWithEmail } from '../lib/supabase';
import '../lib/database-check'; // Auto-run database verification in dev

interface MountainDisplayProps {
  className?: string;
  mountainType?: 'munros' | 'corbetts';
  title?: string;
  iconColor?: string;
  moduleBasePath?: string;
}

export default function MountainDisplay({ 
  className = '', 
  mountainType = 'munros',
  title = 'Scottish Munros',
  iconColor = 'text-blue-400',
  moduleBasePath = ''
}: MountainDisplayProps) {
  const [currentMountain, setCurrentMountain] = useState<MountainType | null>(null);
  const [mountainCount, setMountainCount] = useState<number>(0);
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [currentTime, setCurrentTime] = useState(new Date());
  const [imageStatus, setImageStatus] = useState<'loading' | 'loaded' | 'error'>('loading');
  const [imageFilename, setImageFilename] = useState<string>('');
  const [debugInfo, setDebugInfo] = useState<string>('');

  // User authentication and completion tracking
  const [currentUser, setCurrentUser] = useState<any>(null);
  const [completionStats, setCompletionStats] = useState<CompletionStats | null>(null);
  const [isCompleted, setIsCompleted] = useState<boolean>(false);
  const [isTogglingCompletion, setIsTogglingCompletion] = useState<boolean>(false);
  const [showAuthForm, setShowAuthForm] = useState<boolean>(false);
  const [authEmail, setAuthEmail] = useState<string>('');
  const [authPassword, setAuthPassword] = useState<string>('');
  const [isAuthenticating, setIsAuthenticating] = useState<boolean>(false);

  // Database status
  const [actualCount, setActualCount] = useState<number>(0);
  const [expectedCount, setExpectedCount] = useState<number>(0);

  // Initialize user authentication
  useEffect(() => {
    const initializeUser = async () => {
      try {
        let user = await getCurrentUser();
        
        setCurrentUser(user);
        
        if (user) {
          const stats = await getUserCompletionStats(mountainType);
          setCompletionStats(stats);
        } else {
          // Show auth form if no user
          setShowAuthForm(true);
        }
      } catch (error) {
        console.error('Error initializing user:', error);
        setCurrentUser(null);
        setCompletionStats(null);
        setShowAuthForm(true);
      }
    };

    initializeUser();
  }, [mountainType]);

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

  // Check if current mountain is completed
  useEffect(() => {
    const checkCompletion = async () => {
      if (!currentMountain || !currentUser) {
        setIsCompleted(false);
        return;
      }

      try {
        const completion = await getMountainCompletion(currentMountain.id, mountainType);
        setIsCompleted(!!completion);
      } catch (error) {
        console.error('Error checking completion:', error);
        setIsCompleted(false);
      }
    };

    checkCompletion();
  }, [currentMountain, currentUser, mountainType]);

  // Preload image when mountain changes
  useEffect(() => {
    if (!currentMountain?.image_filename) {
      setImageStatus('error');
      setImageFilename('munro.png');
      return;
    }

    setImageStatus('loading');
    
    const filename = currentMountain.image_filename;
    const fallbackFilename = 'munro.png';
    
    console.log(`MMM-SMH: Loading ${mountainType} image: ${filename}`);
    console.log(`MMM-SMH: Mountain type: ${mountainType}`);
    console.log(`MMM-SMH: Module base path: "${moduleBasePath}"`);
    console.log(`MMM-SMH: Fallback filename: ${fallbackFilename}`);
    
    // Test if main image exists without storing URL
    const img = new Image();
    
    img.onload = () => {
      console.log(`MMM-SMH: SUCCESS! ${mountainType} image loaded: ${filename}`);
      setImageStatus('loaded');
      setImageFilename(filename);
    };
    
    img.onerror = () => {
      console.log(`MMM-SMH: Main ${mountainType} image failed (${getImagePath(filename)}), trying fallback: ${fallbackFilename}`);
      
      const fallbackImg = new Image();
      
      fallbackImg.onload = () => {
        console.log(`MMM-SMH: Fallback ${mountainType} image loaded: ${fallbackFilename}`);
        setImageStatus('loaded');
        setImageFilename(fallbackFilename);
      };
      
      fallbackImg.onerror = () => {
        console.log(`MMM-SMH: Both main and fallback ${mountainType} images failed (${getImagePath(fallbackFilename)}), showing placeholder`);
        setImageStatus('error');
        setImageFilename('');
      };
      
      // Use the correct path via getImagePath function
      fallbackImg.src = getImagePath(fallbackFilename);
    };
    
    // Use the correct path via getImagePath function
    img.src = getImagePath(filename);
  }, [currentMountain, mountainType, moduleBasePath]);

  // Load mountain data
  const loadMountain = async (index: number) => {
    if (mountainCount === 0) return;
    
    setIsTransitioning(true);
    try {
      const mountain = await getMountainByIndex(index, mountainType);
      if (mountain) {
        console.log(`MMM-SMH: Loaded ${mountainType} ${index}: ${mountain.name} (${mountain.height}m)`);
        setCurrentMountain(mountain);
      } else {
        console.error(`MMM-SMH: Failed to load ${mountainType} at index ${index}`);
      }
    } catch (error) {
      console.error(`❌ MMM-SMH: Error loading ${mountainType}:`, error);
      if (error instanceof TypeError && error.message.includes('Failed to fetch')) {
        console.error('❌ SUPABASE CONNECTION FAILED - Check your .env file and restart dev server');
      }
    } finally {
      setTimeout(() => setIsTransitioning(false), 300);
    }
  };

  // Calculate current mountain index based on time
  const getCurrentMountainIndex = () => {
    if (mountainCount === 0) return 0;
    
    const now = new Date();
    const epochStart = new Date('1970-01-01T00:00:00Z');
    const halfHoursSinceEpoch = Math.floor((now.getTime() - epochStart.getTime()) / (30 * 60 * 1000));
    const calculatedIndex = halfHoursSinceEpoch % mountainCount;
    
    console.log(`MMM-SMH: Time calculation - UTC: ${now.toISOString()}, Half-hours since epoch: ${halfHoursSinceEpoch}, Index: ${calculatedIndex}`);
    
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

    const checkForHalfHourChange = () => {
      const newIndex = getCurrentMountainIndex();
      
      if (newIndex !== currentIndex) {
        console.log(`MMM-SMH: Half-hour changed! Switching from ${mountainType} ${currentIndex} to ${newIndex}`);
        setCurrentIndex(newIndex);
        loadMountain(newIndex);
      }
    };

    // Check every minute for half-hour changes
    const interval = setInterval(checkForHalfHourChange, 60000);

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

    document.addEventListener('keydown', handleKeyPress);
    return () => document.removeEventListener('keydown', handleKeyPress);
  }, [mountainCount, currentIndex, mountainType]);

  // Helper function to get image path
  const getImagePath = (filename: string) => {
    const imageFolder = mountainType;
    const imagePath = `/images/${imageFolder}/${filename}`;
    console.log(`MMM-SMH: Using ${mountainType} image path: ${imagePath}`);
    return imagePath;
  };

  // Calculate time until next mountain change
  const getTimeUntilNextChange = () => {
    const now = new Date();
    const nextHalfHour = new Date(now);
    const currentMinutes = nextHalfHour.getMinutes();
    
    if (currentMinutes < 30) {
      nextHalfHour.setMinutes(30);
    } else {
      nextHalfHour.setHours(nextHalfHour.getHours() + 1);
      nextHalfHour.setMinutes(0);
    }
    nextHalfHour.setSeconds(0);
    nextHalfHour.setMilliseconds(0);
    
    const diffMs = nextHalfHour.getTime() - now.getTime();
    const diffMinutes = Math.ceil(diffMs / (1000 * 60));
    
    return diffMinutes;
  };

  // Format estimated time
  const formatEstimatedTime = (timeStr: string | number) => {
    if (!timeStr) return 'N/A';
    
    // Convert to string to handle both string and number inputs
    const timeString = String(timeStr);
    
    // Handle various time formats
    if (timeString.includes('-')) {
      return timeString; // Already formatted like "4-6h"
    }
    
    // Convert single numbers to hours
    const num = parseFloat(timeString);
    if (!isNaN(num)) {
      if (num < 1) {
        return `${Math.round(num * 60)}min`;
      } else {
        return `${num}h`;
      }
    }
    
    return timeString;
  };

  // Handle completion toggle
  const handleToggleCompletion = async () => {
    if (!currentMountain || !currentUser || isTogglingCompletion) return;
    
    setIsTogglingCompletion(true);
    try {
      console.log('🎯 Toggling completion for:', currentMountain.name);
      
      const result = await toggleMountainCompletion(
        currentMountain.id,
        mountainType,
        `Completed ${currentMountain.name} on ${new Date().toLocaleDateString()}`
      );

      console.log('🎯 Toggle completion result:', result);
      
      if (result) {
        setIsCompleted(result.completed);
        console.log('✅ Updated completion status:', result.completed);
        
        // Refresh completion stats
        if (currentUser) {
          console.log('📊 Refreshing completion stats...');
          const stats = await getUserCompletionStats(mountainType);
          console.log('📊 Updated stats:', stats);
          setCompletionStats(stats);
        }
      } else {
        console.error('❌ No result from toggle completion');
      }
    } catch (error) {
      console.error('💥 Error toggling completion:', error);
    } finally {
      setIsTogglingCompletion(false);
    }
  };

  // Handle authentication
  const handleAuth = async (isSignUp: boolean = false) => {
    if (!authEmail || !authPassword) return;
    
    setIsAuthenticating(true);
    try {
      let user;
      if (isSignUp) {
        user = await signUpWithEmail(authEmail, authPassword);
      } else {
        user = await signInWithEmail(authEmail, authPassword);
      }
      
      if (user) {
        setCurrentUser(user);
        setShowAuthForm(false);
        
        // Load completion stats
        const stats = await getUserCompletionStats(mountainType);
        setCompletionStats(stats);
      }
    } catch (error) {
      console.error('Authentication error:', error);
    } finally {
      setIsAuthenticating(false);
    }
  };

  // Get location string based on mountain type
  const getLocationString = (mountain: MountainType) => {
    if (mountain.area && mountain.area !== mountain.region && mountain.area.trim() !== '') {
      return `${mountain.area}, ${mountain.region}`;
    }
    if (mountain.location && mountain.location !== mountain.region && mountain.location.trim() !== '') {
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
    <div className={`text-white max-w-xs bg-gray-900 bg-opacity-95 p-2 rounded-lg border border-gray-600 ${className}`}>
      <div className={`transition-opacity duration-300 ${isTransitioning ? 'opacity-50' : 'opacity-100'} space-y-2`}>
        
        {/* Header with title and time */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
          <div className="flex items-center justify-between mb-2">
            <div className="flex items-center space-x-2">
              <Mountain className={`w-4 h-4 ${iconColor}`} />
              <div className="flex items-center space-x-2">
                <span className="text-base font-light">{title}</span>
                {completionStats && (
                  <span className="text-xs text-green-400 font-medium">
                    {completionStats.completed_mountains}/{completionStats.total_mountains}
                  </span>
                )}
              </div>
            </div>
          </div>
          <div className="text-xs text-gray-300">
            {currentIndex + 1} of {actualCount} • {minutesUntilNext}min
            {actualCount !== expectedCount && (
              <span className="text-red-400 text-xs ml-2 font-medium">
                ⚠️ Missing {expectedCount - actualCount}
              </span>
            )}
          </div>
        </div>

        {/* Mountain name and height */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
          <div className="flex items-center justify-between mb-1">
            <div className="flex items-center space-x-2">
              <Mountain className="w-5 h-5 text-green-400" />
              {isCompleted && (
                <Check className="w-4 h-4 text-green-400" />
              )}
            </div>
            <div className="text-xl font-bold text-green-400">
              {currentMountain.height}m
            </div>
          </div>
          <h2 className="text-lg font-medium text-white leading-tight">
            {currentMountain.name}
          </h2>
          {isCompleted && (
            <div className="text-xs text-green-400 mt-1">✓ Completed</div>
          )}
        </div>

        {/* Mountain image */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg overflow-hidden border border-gray-600 shadow-lg">
          <div className="relative">
            {imageStatus === 'loaded' && imageFilename ? (
              <img 
                src={getImagePath(imageFilename)}
                alt={currentMountain.name}
                className="w-full h-30 object-cover"
                onError={() => {
                  console.log(`MMM-SMH: Image render error for: ${getImagePath(imageFilename)}`);
                  // Try fallback
                  if (imageFilename !== 'munro.png') {
                    console.log('MMM-SMH: Trying fallback image');
                    setImageFilename('munro.png');
                  } else {
                    setImageStatus('error');
                  }
                }}
              />
            ) : imageStatus === 'loading' ? (
              <div className="w-full h-30 bg-gray-700 flex items-center justify-center">
                <div className="text-center">
                  <Mountain className="w-8 h-8 text-gray-400 animate-pulse mx-auto mb-1" />
                  <div className="text-xs text-gray-500">Loading image...</div>
                </div>
              </div>
            ) : (
              <div className="w-full h-30 bg-gray-700 flex items-center justify-center">
                <div className="text-center">
                  <Mountain className="w-8 h-8 text-gray-400 mx-auto mb-1" />
                  <div className="text-xs text-gray-500">No image available</div>
                </div>
              </div>
            )}
            
            {/* Location overlay */}
            <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/70 to-transparent p-2">
              <div className="flex items-center space-x-2 text-white">
                <MapPin className="w-3 h-3 text-green-400 flex-shrink-0" />
                <span className="text-xs">{getLocationString(currentMountain)}</span>
              </div>
            </div>
          </div>
        </div>

        {/* Stats grid */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
          <div className="grid grid-cols-3 gap-2">
            <div className="text-center">
              <div className="text-base font-bold text-blue-400">{currentMountain.prominence}m</div>
              <div className="text-xs text-gray-400">Prominence</div>
            </div>
            <div className="text-center">
              <div className="text-base font-bold text-green-400">{formatEstimatedTime(currentMountain.estimated_time)}</div>
              <div className="text-xs text-gray-400">Time</div>
            </div>
            <div className="text-center">
              <div className="flex justify-center space-x-0.5 mb-1">
                {Array.from({ length: 5 }, (_, i) => (
                  <Star 
                    key={i} 
                    className={`w-2.5 h-2.5 ${i < currentMountain.difficulty_rating ? 'text-yellow-400 fill-current' : 'text-gray-600'}`} 
                  />
                ))}
              </div>
              <div className="text-xs text-gray-400">Difficulty</div>
            </div>
          </div>
        </div>

        {/* Description */}
        <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
          <p className="text-xs text-gray-300 leading-relaxed line-clamp-3">
            {currentMountain.description}
          </p>
        </div>

        {/* Popular Routes */}
        {currentMountain.popular_routes && Array.isArray(currentMountain.popular_routes) && currentMountain.popular_routes.length > 0 && (
          <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
            <div className="flex items-center space-x-2 mb-2">
              <Route className="w-3 h-3 text-orange-400" />
              <span className="text-xs font-medium text-orange-400">Popular Routes</span>
            </div>
            <div className="space-y-1">
              {currentMountain.popular_routes.slice(0, 2).map((route, index) => (
                <div key={index} className="text-xs text-gray-300">
                  • {route}
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Best Seasons */}
        {currentMountain.best_seasons && Array.isArray(currentMountain.best_seasons) && currentMountain.best_seasons.length > 0 && (
          <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
            <div className="flex items-center space-x-2 mb-2">
              <Clock className="w-3 h-3 text-green-400" />
              <span className="text-xs font-medium text-green-400">Best Seasons</span>
            </div>
            <div className="flex flex-wrap gap-1">
              {currentMountain.best_seasons.slice(0, 3).map((season, index) => (
                <span 
                  key={index}
                  className="px-2 py-0.5 bg-green-600 bg-opacity-30 text-green-300 rounded text-xs border border-green-600 border-opacity-30"
                >
                  {season}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* Authentication Form */}
        {showAuthForm && (
          <div className="bg-gray-800 bg-opacity-80 rounded-lg p-3 border border-gray-600 shadow-lg">
            <div className="flex items-center space-x-2 mb-3">
              <div className="w-4 h-4 bg-blue-400 rounded-full"></div>
              <span className="text-sm font-medium text-blue-400">Sign in to track completions</span>
            </div>
            <div className="space-y-2">
              <input
                type="email"
                placeholder="Email"
                value={authEmail}
                onChange={(e) => setAuthEmail(e.target.value)}
                className="w-full px-2 py-1 bg-gray-700 text-white text-xs rounded border border-gray-600 focus:border-blue-400 focus:outline-none"
              />
              <input
                type="password"
                placeholder="Password"
                value={authPassword}
                onChange={(e) => setAuthPassword(e.target.value)}
                className="w-full px-2 py-1 bg-gray-700 text-white text-xs rounded border border-gray-600 focus:border-blue-400 focus:outline-none"
              />
              <div className="flex space-x-2">
                <button
                  onClick={() => handleAuth(false)}
                  disabled={isAuthenticating || !authEmail || !authPassword}
                  className="flex-1 px-2 py-1 bg-blue-600 text-white text-xs rounded hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isAuthenticating ? 'Signing in...' : 'Sign In'}
                </button>
                <button
                  onClick={() => handleAuth(true)}
                  disabled={isAuthenticating || !authEmail || !authPassword}
                  className="flex-1 px-2 py-1 bg-green-600 text-white text-xs rounded hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isAuthenticating ? 'Signing up...' : 'Sign Up'}
                </button>
              </div>
              <button
                onClick={() => setShowAuthForm(false)}
                className="w-full px-2 py-1 bg-gray-600 text-gray-300 text-xs rounded hover:bg-gray-500"
              >
                Skip (view only)
              </button>
            </div>
          </div>
        )}

        {/* Completion Button */}
        {currentUser && !showAuthForm && (
          <div className="bg-gray-800 bg-opacity-80 rounded-lg p-2 border border-gray-600 shadow-lg">
            <button
              onClick={handleToggleCompletion}
              disabled={isTogglingCompletion}
              className={`w-full px-3 py-2 rounded text-sm font-medium transition-colors ${
                isCompleted
                  ? 'bg-green-600 text-white border border-green-500'
                  : 'bg-gray-700 text-gray-300 border border-gray-600 hover:bg-gray-600'
              } ${isTogglingCompletion ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'}`}
            >
              {isTogglingCompletion ? (
                'Updating...'
              ) : isCompleted ? (
                <div className="flex items-center justify-center space-x-2">
                  <Check className="w-4 h-4" />
                  <span>Completed</span>
                </div>
              ) : (
                'Mark as Completed'
              )}
            </button>
          </div>
        )}

        {/* Debug info (development only) */}
        {process.env.NODE_ENV === 'development' && (
          <div className="bg-gray-900 bg-opacity-90 rounded-lg p-2 border border-gray-500 shadow-lg">
            <div className="text-xs text-gray-400 space-y-1">
              <div>Debug: Index {currentIndex}, UTC Time: {new Date().getUTCHours()}:{String(new Date().getUTCMinutes()).padStart(2, '0')}</div>
              <div>Next change: {minutesUntilNext} minutes</div>
              <div>Image status: {imageStatus}</div>
              <div>Image file: {currentMountain?.image_filename}</div>
              <div>Final path: {imageFilename ? `images/${mountainType}/${imageFilename}` : 'none'}</div>
              <div>Type: {mountainType}</div>
              <div>Count: {actualCount}/{expectedCount} {mountainType}</div>
              <div className={actualCount === expectedCount ? "text-green-400" : "text-yellow-400"}>
                {actualCount === expectedCount ? "✅ Complete dataset" : `⚠️ Missing ${expectedCount - actualCount} ${mountainType}`}
              </div>
              <div>User: {currentUser ? `✅ ${currentUser.id?.slice(0, 8)}...` : '❌ Not authenticated'}</div>
              <div>Completion: {isCompleted ? '✅ Completed' : '❌ Not completed'}</div>
              {completionStats && (
                <div>Progress: {completionStats.completed_mountains}/{completionStats.total_mountains} ({completionStats.completion_percentage}%)</div>
              )}
              <div>Module base path: {moduleBasePath || 'none (dev mode)'}</div>
              <div>Computed image path: {currentMountain ? getImagePath(currentMountain.image_filename) : 'none'}</div>
              <div className="text-yellow-400">← → keys to cycle</div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}