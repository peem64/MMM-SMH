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
        return [
            this.file("dist/assets/index.css") // Built CSS from Vite
        ];
    },

    // Start the module
    start: function() {
        Log.info("Starting module: " + this.name);
        this.loaded = false;
        this.error = null;
        this.reactAppLoaded = false;
        this.reactAppInitialized = false;
        this.moduleContainer = null;
        
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
        
        // Create main wrapper with proper MagicMirror styling
        var wrapper = document.createElement("div");
        wrapper.className = "mmm-smh-module";
        wrapper.style.width = this.config.maxWidth;
        wrapper.style.maxHeight = this.config.maxHeight;
        wrapper.style.position = "relative";
        wrapper.style.overflow = "visible";
        wrapper.style.boxSizing = "border-box";
        
        // Store reference to container
        this.moduleContainer = wrapper;
        
        if (this.error) {
            wrapper.innerHTML = `
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
            return wrapper;
        }
        
        if (!this.loaded) {
            wrapper.innerHTML = `
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
            return wrapper;
        }

        // Create React container
        var reactContainer = document.createElement("div");
        reactContainer.id = "mmm-smh-react-" + this.identifier;
        reactContainer.style.width = "100%";
        reactContainer.style.height = "auto";
        reactContainer.style.position = "relative";
        reactContainer.style.overflow = "visible";
        
        wrapper.appendChild(reactContainer);
        
        // Initialize React app
        setTimeout(function() {
            self.initializeReactApp(reactContainer.id);
        }, 100);
        
        return wrapper;
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
                
                if (typeof window !== 'undefined' && window.MMMSMHApp && window.MMMSMHApp.init) {
                    try {
                        window.MMMSMHApp.init(containerId);
                        Log.info("MMM-SMH: React app initialized successfully");
                        return;
                    } catch (error) {
                        Log.error("MMM-SMH: Error initializing React app:", error);
                    }
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