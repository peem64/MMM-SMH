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
        maxWidth: "100%",
        maxHeight: "100%",
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
        
        // Validate configuration
        if (!this.config.supabaseUrl || !this.config.supabaseAnonKey) {
            this.error = "Supabase configuration missing. Please set supabaseUrl and supabaseAnonKey in config.";
            this.updateDom();
            return;
        }
        
        // Validate that built files exist
        this.validateBuildFiles();
        
        // Set up update timer
        this.scheduleUpdate();
    },

    // Validate that the built files exist
    validateBuildFiles: function() {
        var self = this;
        
        // Check if CSS file exists
        var cssPath = this.file("dist/assets/index.css");
        var jsPath = this.file("dist/assets/index.js");
        
        // Create test elements to check if files exist
        var cssTest = document.createElement("link");
        cssTest.rel = "stylesheet";
        cssTest.href = cssPath;
        cssTest.onerror = function() {
            self.error = "Built CSS file not found. Please run 'npm run build' in the module directory.";
            self.updateDom();
        };
        
        // Don't actually add the test elements to DOM
    },

    // Schedule the next update
    scheduleUpdate: function() {
        var self = this;
        
        setInterval(function() {
            if (self.loaded) {
                // Only update DOM if we're not still loading
                self.updateDom(self.config.animationSpeed);
            }
        }, this.config.updateInterval);
    },

    // Override dom creation
    getDom: function() {
        var wrapper = document.createElement("div");
        wrapper.className = "mmm-smh-wrapper";
        wrapper.style.width = this.config.maxWidth;
        wrapper.style.height = this.config.maxHeight;
        wrapper.style.position = "relative";
        
        if (this.error) {
            wrapper.innerHTML = `
                <div class="error-container" style="
                    color: #ff6b6b;
                    text-align: center;
                    padding: 20px;
                    font-family: 'Roboto', sans-serif;
                    background: rgba(0,0,0,0.8);
                    border-radius: 10px;
                    margin: 20px;
                    border: 2px solid #ff6b6b;
                ">
                    <div style="font-size: 24px; margin-bottom: 10px;">⚠️</div>
                    <div style="font-size: 16px; margin-bottom: 10px; font-weight: bold;">MMM-SMH Error</div>
                    <div style="font-size: 12px; margin-top: 10px; opacity: 0.9; max-width: 500px; line-height: 1.4;">
                        ${this.error}
                    </div>
                    <div style="font-size: 10px; margin-top: 15px; opacity: 0.7; font-style: italic;">
                        Check the MagicMirror logs for more details
                    </div>
                </div>
            `;
            return wrapper;
        }
        
        if (!this.loaded) {
            wrapper.innerHTML = `
                <div class="loading-container" style="
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    min-height: 300px;
                    color: white;
                    font-family: 'Roboto', sans-serif;
                    background: linear-gradient(135deg, rgba(0,0,0,0.8), rgba(30,58,138,0.8));
                    border-radius: 15px;
                    margin: 20px;
                    border: 1px solid rgba(255,255,255,0.1);
                ">
                    <div style="text-align: center;">
                        <div style="font-size: 48px; margin-bottom: 20px; animation: pulse 2s infinite;">⛰️</div>
                        <div style="font-size: 18px; margin-bottom: 10px;">Loading Scottish Munros...</div>
                        <div style="font-size: 12px; margin-top: 10px; opacity: 0.7;">
                            Initializing React application...
                        </div>
                        <div style="margin-top: 20px;">
                            <div style="width: 200px; height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; overflow: hidden;">
                                <div style="width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.6), transparent); animation: loading 2s infinite;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <style>
                    @keyframes pulse {
                        0%, 100% { opacity: 1; transform: scale(1); }
                        50% { opacity: 0.7; transform: scale(1.05); }
                    }
                    @keyframes loading {
                        0% { transform: translateX(-100%); }
                        100% { transform: translateX(100%); }
                    }
                </style>
            `;
            
            // Load the React app after a short delay
            if (!this.reactAppLoaded) {
                this.reactAppLoaded = true;
                setTimeout(() => {
                    this.loadReactApp(wrapper);
                }, 1000);
            }
            
            return wrapper;
        }

        // React app container
        wrapper.innerHTML = '<div id="mmm-smh-root" style="width: 100%; height: 100%; min-height: 400px;"></div>';
        
        // Initialize React app if not already done
        if (!this.reactAppInitialized) {
            this.reactAppInitialized = true;
            setTimeout(() => {
                this.initializeReactApp();
            }, 100);
        }
        
        return wrapper;
    },

    // Load the React application
    loadReactApp: function(container) {
        var self = this;
        
        Log.info("MMM-SMH: Loading React application...");
        
        // Set environment variables for the React app
        if (typeof window !== 'undefined') {
            window.VITE_SUPABASE_URL = this.config.supabaseUrl;
            window.VITE_SUPABASE_ANON_KEY = this.config.supabaseAnonKey;
        }
        
        // Create a script element to load the built React app
        var script = document.createElement("script");
        script.type = "module";
        script.src = this.file("dist/assets/index.js"); // Built JS from Vite
        
        script.onload = function() {
            Log.info("MMM-SMH: React app script loaded successfully");
            
            // Mark as loaded and update DOM
            self.loaded = true;
            self.updateDom(self.config.animationSpeed);
        };
        
        script.onerror = function(error) {
            Log.error("MMM-SMH: Failed to load React app script:", error);
            self.error = "Failed to load React application. Please ensure that the module is built correctly with 'npm run build'";
            self.updateDom();
        };
        
        // Add script to head
        document.head.appendChild(script);
    },

    // Initialize the React app in the container
    initializeReactApp: function() {
        var self = this;
        
        try {
            Log.info("MMM-SMH: Initializing React app...");
            
            // Check if React app is available
            if (typeof window !== 'undefined' && window.MMMSMHApp && window.MMMSMHApp.init) {
                window.MMMSMHApp.init('mmm-smh-root');
                Log.info("MMM-SMH: React app initialized successfully");
            } else {
                // If not available yet, try again after a delay
                setTimeout(function() {
                    if (window.MMMSMHApp && window.MMMSMHApp.init) {
                        window.MMMSMHApp.init('mmm-smh-root');
                        Log.info("MMM-SMH: React app initialized successfully (delayed)");
                    } else {
                        Log.warn("MMM-SMH: React app not available, will retry...");
                        // The app should still work as it will auto-initialize
                    }
                }, 2000);
            }
        } catch (error) {
            Log.error("MMM-SMH: Failed to initialize React app:", error);
            this.error = "Failed to initialize React app: " + error.message;
            this.updateDom();
        }
    },

    // Handle notifications from other modules
    notificationReceived: function(notification, payload, sender) {
        if (notification === "DOM_OBJECTS_CREATED") {
            Log.info("MMM-SMH: DOM objects created");
        }
    },

    // Handle socket notifications
    socketNotificationReceived: function(notification, payload) {
        // Handle any socket notifications if needed
    }
});