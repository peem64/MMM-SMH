/* MagicMirror²
 * Module: MMM-SMH
 * Scottish Munros Highland Module
 * 
 * By: Your Name
 * MIT Licensed.
 */

Module.register("MMM-SMH", {
    // Default module config
    defaults: {
        updateInterval: 60000, // Check for updates every minute
        animationSpeed: 1000,
        initialLoadDelay: 0,
        retryDelay: 2500,
        maxWidth: "300px",
        maxHeight: "auto",
        // Supabase configuration - users need to set these
        supabaseUrl: "",
        supabaseAnonKey: ""
    },

    // Define required scripts
    getScripts: function() {
        return [];
    },

    // Define required styles
    getStyles: function() {
        return []; // Don't load any CSS - we'll handle everything in shadow DOM
    },

    // Start the module
    start: function() {
        Log.info("Starting module: " + this.name);
        this.loaded = false;
        this.error = null;
        this.reactAppLoaded = false;
        this.reactAppInitialized = false;
        this.moduleContainer = null;
        this.shadowRoot = null;
        
        // Validate configuration
        if (!this.config.supabaseUrl || !this.config.supabaseAnonKey) {
            this.error = "Supabase configuration missing. Please set supabaseUrl and supabaseAnonKey in config.";
            this.updateDom();
            return;
        }
        
        // Load React app immediately
        this.loadReactApp();
        
        // Set up update timer
        this.scheduleUpdate();
    },

    // Schedule the next update
    scheduleUpdate: function() {
        var self = this;
        
        setInterval(function() {
            // Don't update DOM unnecessarily once loaded
            if (!self.loaded) {
                self.updateDom(0); // No animation during loading
            }
        }, this.config.updateInterval);
    },

    // Override dom creation
    getDom: function() {
        var self = this;
        
        // Create wrapper with minimal styling
        var wrapper = document.createElement("div");
        wrapper.style.cssText = "display: block; position: relative; width: 100%; max-width: 300px;";
        
        // Create shadow DOM for complete isolation
        if (wrapper.attachShadow) {
            this.shadowRoot = wrapper.attachShadow({ mode: 'open' }); // Changed to 'open' for debugging
            
            // Create the actual content container inside shadow DOM
            var shadowContainer = document.createElement("div");
            shadowContainer.id = "mmm-smh-shadow-container";
            shadowContainer.style.cssText = "display: block; width: 100%; position: relative;";
            
            // Add all styles directly inside shadow DOM
            var shadowStyles = document.createElement("style");
            shadowStyles.textContent = this.getShadowStyles();
            
            this.shadowRoot.appendChild(shadowStyles);
            this.shadowRoot.appendChild(shadowContainer);
            
            // Store reference to shadow container
            this.moduleContainer = shadowContainer;
            
            Log.info("MMM-SMH: Shadow DOM created successfully");
        } else {
            // Fallback for browsers without shadow DOM support
            wrapper.className = "mmm-smh-fallback";
            wrapper.style.cssText += " font-family: 'Roboto Condensed', sans-serif; color: #ffffff;";
            this.moduleContainer = wrapper;
            Log.warn("MMM-SMH: Shadow DOM not supported, using fallback");
        }
        
        // Handle different states
        if (this.error) {
            this.showError();
            return wrapper;
        }
        
        if (!this.loaded) {
            this.showLoading();
            return wrapper;
        }

        // Create React container
        this.createReactContainer();
        
        return wrapper;
    },

    // Show error state
    showError: function() {
        this.moduleContainer.innerHTML = `
            <div style="
                color: #ff6b6b;
                text-align: center;
                padding: 15px;
                font-family: 'Roboto Condensed', sans-serif;
                background: rgba(0,0,0,0.3);
                border-radius: 8px;
                border: 1px solid #ff6b6b;
                max-width: 280px;
                font-size: 13px;
                line-height: 1.4;
            ">
                <div style="font-size: 18px; margin-bottom: 6px;">⚠️</div>
                <div style="font-weight: bold; margin-bottom: 6px;">MMM-SMH Error</div>
                <div style="font-size: 11px; opacity: 0.9;">
                    ${this.error}
                </div>
            </div>
        `;
    },

    // Show loading state
    showLoading: function() {
        this.moduleContainer.innerHTML = `
            <div style="
                display: flex;
                align-items: center;
                color: #ffffff;
                font-family: 'Roboto Condensed', sans-serif;
                text-align: left;
                padding: 10px 0;
            ">
                <div style="font-size: 20px; margin-right: 10px; animation: mmm-smh-pulse 2s infinite;">⛰️</div>
                <div>
                    <div style="font-size: 16px; margin-bottom: 4px; font-weight: 300;">Scottish Munros</div>
                    <div style="font-size: 12px; opacity: 0.7; color: #9ca3af;">
                        Loading...
                    </div>
                </div>
            </div>
            <style>
                @keyframes mmm-smh-pulse {
                    0%, 100% { opacity: 1; transform: scale(1); }
                    50% { opacity: 0.6; transform: scale(1.05); }
                }
            </style>
        `;
    },

    // Create React container
    createReactContainer: function() {
        var self = this;
        
        // Create React container
        var reactContainer = document.createElement("div");
        reactContainer.id = "mmm-smh-react-" + this.identifier;
        reactContainer.style.cssText = "display: block; width: 100%; position: relative; font-family: 'Roboto Condensed', 'Roboto', sans-serif; color: #ffffff;";
        reactContainer.className = "mmm-smh-module";
        
        // Clear existing content and add React container
        this.moduleContainer.innerHTML = '';
        this.moduleContainer.appendChild(reactContainer);
        
        Log.info("MMM-SMH: React container created with ID:", reactContainer.id);
        
        // Initialize React app
        setTimeout(function() {
            self.initializeReactApp(reactContainer.id);
        }, 100);
    },

    // Get all styles for shadow DOM
    getShadowStyles: function() {
        return `
            /* Complete reset and isolation */
            :host {
                display: block;
                contain: layout style paint;
                font-family: 'Roboto Condensed', 'Roboto', sans-serif;
                color: #ffffff;
                text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
                max-width: 300px;
                width: 100%;
            }


            /* Base styling */
            #mmm-smh-shadow-container {
                font-family: 'Roboto Condensed', 'Roboto', sans-serif;
                color: #ffffff;
                text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
                max-width: 300px;
                width: 100%;
                display: block;
                text-rendering: optimizeLegibility;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            /* All the Tailwind-like utilities we need */
            .text-white { color: #ffffff; }
            .text-gray-300 { color: #d1d5db; }
            .text-gray-400 { color: #9ca3af; }
            .text-gray-500 { color: #6b7280; }
            .text-blue-400 { color: #60a5fa; }
            .text-green-400 { color: #4ade80; }
            .text-yellow-400 { color: #facc15; }
            .text-orange-400 { color: #fb923c; }
            .text-red-400 { color: #f87171; }
            .text-red-500 { color: #ef4444; }
            .text-blue-200 { color: #bfdbfe; }

            .bg-gray-800, .mmm-smh-module .bg-gray-800 {
                background-color: rgba(31, 41, 55, 0.8) !important;
            }

            .bg-gray-900, .mmm-smh-module .bg-gray-900 {
                background-color: rgba(17, 24, 39, 0.9) !important;
            }

            .bg-blue-900, .mmm-smh-module .bg-blue-900 {
                background-color: rgba(30, 58, 138, 0.6) !important;
            }

            .bg-gray-700, .mmm-smh-module .bg-gray-700 {
                background-color: rgba(55, 65, 81, 1) !important;
            }

            .bg-green-600, .mmm-smh-module .bg-green-600 {
                background-color: rgba(22, 163, 74, 1) !important;
            }

            .bg-opacity-50, .mmm-smh-module .bg-opacity-50 {
                background-color: rgba(31, 41, 55, 0.5) !important;
            }

            .bg-opacity-30, .mmm-smh-module .bg-opacity-30 {
                background-color: rgba(22, 163, 74, 0.3) !important;
            }

            /* Force solid backgrounds globally within our module */
            .bg-gray-800,
            .bg-gray-900,
            .bg-gray-700,
            .mmm-smh-module .bg-gray-800,
            .mmm-smh-module .bg-gray-900,
            .mmm-smh-module .bg-gray-700 {
                opacity: 1 !important;
            }

            /* Border utilities */
            .border-gray-700, .mmm-smh-module .border-gray-700 {
                border-color: rgb(55, 65, 81) !important;
                border-width: 1px !important;
                border-style: solid !important;
            }

            .border-gray-600, .mmm-smh-module .border-gray-600 {
                border-color: rgb(75, 85, 99) !important;
                border-width: 1px !important;
                border-style: solid !important;
            }

            .border-green-600, .mmm-smh-module .border-green-600 {
                border-color: rgba(22, 163, 74, 1) !important;
                border-width: 1px !important;
                border-style: solid !important;
            }

            .border-opacity-30, .mmm-smh-module .border-opacity-30 {
                border-color: rgba(22, 163, 74, 0.3) !important;
            }

            .rounded-xl, .mmm-smh-module .rounded-xl {
                border-radius: 0.75rem !important;
            }

            .p-4, .mmm-smh-module .p-4 {
                padding: 1rem !important;
            }

            .p-3, .mmm-smh-module .p-3 {
                padding: 0.75rem !important;
            }

            .p-2, .mmm-smh-module .p-2 {
                padding: 0.5rem !important;
            }

            .border, .mmm-smh-module .border {
                border-width: 1px !important;
                border-style: solid !important;
            }

            .rounded, .mmm-smh-module .rounded {
                border-radius: 0.25rem !important;
            }

            .border-blue-700 { border-color: #1d4ed8; }
            .border-opacity-30 { border-color: rgba(29, 78, 216, 0.3); }

            .flex { display: flex; }
            .grid { display: grid; }
            .items-center { align-items: center; }
            .justify-between { justify-content: space-between; }
            .flex-wrap { flex-wrap: wrap; }
            .flex-shrink-0 { flex-shrink: 0; }

            .space-x-2 > :not([hidden]) ~ :not([hidden]) { margin-left: 0.5rem; }
            .space-x-3 > :not([hidden]) ~ :not([hidden]) { margin-left: 0.75rem; }
            .space-y-2 > :not([hidden]) ~ :not([hidden]) { margin-top: 0.5rem; }
            .space-y-3 > :not([hidden]) ~ :not([hidden]) { margin-top: 0.75rem; }
            .space-y-4 > :not([hidden]) ~ :not([hidden]) { margin-top: 1rem; }

            .gap-1 { gap: 0.25rem; }
            .gap-2 { gap: 0.5rem; }
            .gap-3 { gap: 0.75rem; }
            .gap-4 { gap: 1rem; }

            .grid-cols-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .grid-cols-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }

            .mb-2 { margin-bottom: 0.5rem; }
            .mb-3 { margin-bottom: 0.75rem; }
            .mb-4 { margin-bottom: 1rem; }

            .p-1 { padding: 0.25rem; }
            .p-2 { padding: 0.5rem; }
            .p-3 { padding: 0.75rem; }
            .px-2 { padding-left: 0.5rem; padding-right: 0.5rem; }
            .px-3 { padding-left: 0.75rem; padding-right: 0.75rem; }
            .py-1 { padding-top: 0.25rem; padding-bottom: 0.25rem; }

            .text-xs { font-size: 0.75rem; line-height: 1rem; }
            .text-sm { font-size: 0.875rem; line-height: 1.25rem; }
            .text-base { font-size: 1rem; line-height: 1.5rem; }
            .text-lg { font-size: 1.125rem; line-height: 1.5rem; }
            .text-xl { font-size: 1.25rem; line-height: 1.75rem; }
            .text-2xl { font-size: 1.5rem; line-height: 2rem; }

            .font-light { font-weight: 300; }
            .leading-relaxed { line-height: 1.625; }
            .text-center { text-align: center; }

            .w-3 { width: 0.75rem; }
            .w-4 { width: 1rem; }
            .w-5 { width: 1.25rem; }
            .w-6 { width: 1.5rem; }
            .w-8 { width: 2rem; }
            .w-12 { width: 3rem; }
            .w-full { width: 100%; }

            .h-3 { height: 0.75rem; }
            .h-4 { height: 1rem; }
            .h-5 { height: 1.25rem; }
            .h-6 { height: 1.5rem; }
            .h-8 { height: 2rem; }
            .h-12 { height: 3rem; }
            .h-20 { height: 5rem; }
            .h-30 { height: 7.5rem; }
            .h-35 { height: 8.75rem; }

            .max-w-xs { max-width: 20rem; }
            .max-w-md { max-width: 28rem; }

            .object-cover { object-fit: cover; }

            .rounded { border-radius: 0.25rem; }
            .rounded-lg { border-radius: 0.5rem; }
            .rounded-full { border-radius: 9999px; }
            .border { border-width: 1px; }

            .transition-opacity { 
                transition-property: opacity; 
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1); 
                transition-duration: 150ms; 
            }
            .duration-300 { transition-duration: 300ms; }
            .opacity-100 { opacity: 1; }
            .opacity-50 { opacity: 0.5; }

            .line-clamp-3 {
                overflow: hidden;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 3;
            }

            .line-clamp-4 {
                overflow: hidden;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 4;
            }

            @keyframes mmm-smh-pulse {
                0%, 100% { opacity: 1; }
                50% { opacity: 0.5; }
            }

            .animate-pulse {
                animation: mmm-smh-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
            }

            @media (max-width: 480px) {
                #mmm-smh-shadow-container {
                    max-width: 280px;
                }
                
                .text-base {
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                }
                
                .grid-cols-3 {
                    grid-template-columns: repeat(3, minmax(0, 1fr));
                    gap: 0.25rem;
                }
            }
        `;
    },

    // Load the React application
    loadReactApp: function() {
        var self = this;
        
        Log.info("MMM-SMH: Loading React application...");
        
        // Set environment variables for the React app
        if (typeof window !== 'undefined') {
            window.VITE_SUPABASE_URL = this.config.supabaseUrl;
            window.VITE_SUPABASE_ANON_KEY = this.config.supabaseAnonKey;
        }
        
        // Check if script is already loaded
        var existingScript = document.querySelector('script[data-mmm-smh="true"]');
        if (existingScript) {
            Log.info("MMM-SMH: React script already loaded");
            this.loaded = true;
            this.updateDom(this.config.animationSpeed);
            return;
        }
        
        // Create a script element to load the built React app
        var script = document.createElement("script");
        script.type = "module";
        script.src = this.file("dist/assets/index.js");
        script.setAttribute("data-mmm-smh", "true");
        
        script.onload = function() {
            Log.info("MMM-SMH: React app script loaded successfully");
            self.loaded = true;
            self.updateDom(self.config.animationSpeed);
        };
        
        script.onerror = function(error) {
            Log.error("MMM-SMH: Failed to load React app script:", error);
            self.error = "Failed to load React application. Run 'npm run build' in module directory.";
            self.updateDom();
        };
        
        // Add script to head
        document.head.appendChild(script);
    },

    // Initialize the React app in the container
    initializeReactApp: function(containerId) {
        var self = this;
        
        try {
            Log.info("MMM-SMH: Initializing React app in:", containerId);
            
            var initAttempts = 0;
            var maxAttempts = 20;
            
            var tryInit = function() {
                initAttempts++;
                
                // Look for container in shadow DOM first, then regular DOM
                var container = null;
                if (self.shadowRoot) {
                    container = self.shadowRoot.getElementById(containerId);
                    Log.info("MMM-SMH: Looking for container in shadow DOM:", containerId);
                } else {
                    container = document.getElementById(containerId);
                    Log.info("MMM-SMH: Looking for container in regular DOM:", containerId);
                }
                
                if (container && typeof window !== 'undefined' && window.MMMSMHApp && window.MMMSMHApp.init) {
                    try {
                        Log.info("MMM-SMH: Found container and React app, initializing...");
                        window.MMMSMHApp.init(containerId, self.shadowRoot);
                        Log.info("MMM-SMH: React app initialized successfully");
                        return;
                    } catch (error) {
                        Log.error("MMM-SMH: Error initializing React app:", error);
                    }
                } else {
                    Log.info(`MMM-SMH: Waiting for container or React app... (${initAttempts}/${maxAttempts})`);
                    Log.info("MMM-SMH: Container found:", !!container);
                    Log.info("MMM-SMH: React app available:", !!(window.MMMSMHApp && window.MMMSMHApp.init));
                }
                
                if (initAttempts < maxAttempts) {
                    setTimeout(tryInit, 500);
                } else {
                    Log.error("MMM-SMH: Failed to initialize React app after " + maxAttempts + " attempts");
                    self.error = "React app initialization failed";
                    self.updateDom();
                }
            };
            
            tryInit();
            
        } catch (error) {
            Log.error("MMM-SMH: Exception in initializeReactApp:", error);
            this.error = "React app initialization error: " + error.message;
            this.updateDom();
        }
    },

    // Handle notifications from other modules
    notificationReceived: function(notification, payload, sender) {
        if (notification === "DOM_OBJECTS_CREATED") {
            Log.info("MMM-SMH: DOM objects created");
        }
    },

    // Clean up when module is suspended
    suspend: function() {
        Log.info("MMM-SMH: Module suspended");
    },

    // Resume when module is shown again
    resume: function() {
        Log.info("MMM-SMH: Module resumed");
    }
});