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
        this.reactAppInitialized = false;
        this.domCreated = false;
        
        // Validate configuration
        if (!this.config.supabaseUrl || !this.config.supabaseAnonKey) {
            this.error = "Supabase configuration missing. Please set supabaseUrl and supabaseAnonKey in config.";
            this.updateDom();
            return;
        }
        
        // Set up update timer
        this.scheduleUpdate();
    },

    // Schedule the next update
    scheduleUpdate: function() {
        var self = this;
        
        setInterval(function() {
            if (self.loaded && self.domCreated) {
                // Only update DOM if we're not still loading
                self.updateDom(self.config.animationSpeed);
            }
        }, this.config.updateInterval);
    },

    // Override dom creation
    getDom: function() {
        var self = this;
        var wrapper = document.createElement("div");
        wrapper.className = "mmm-smh-wrapper";
        wrapper.id = "mmm-smh-module-" + this.identifier;
        
        // Set dimensions based on position
        var position = this.data.position;
        if (position.includes("fullscreen")) {
            wrapper.style.width = "100vw";
            wrapper.style.height = "100vh";
            wrapper.style.position = "fixed";
            wrapper.style.top = "0";
            wrapper.style.left = "0";
            wrapper.style.zIndex = "0";
        } else {
            wrapper.style.width = this.config.maxWidth;
            wrapper.style.maxHeight = this.config.maxHeight;
            wrapper.style.position = "relative";
        }
        
        // Ensure proper isolation and prevent conflicts
        wrapper.style.isolation = "isolate";
        wrapper.style.contain = "layout style";
        wrapper.style.boxSizing = "border-box";
        
        if (this.error) {
            wrapper.innerHTML = `
                <div class="error-container" style="
                    color: #ff6b6b;
                    text-align: center;
                    padding: 20px;
                    font-family: 'Inter', 'Roboto', sans-serif;
                    background: rgba(0,0,0,0.8);
                    border-radius: 10px;
                    margin: 20px;
                    border: 2px solid #ff6b6b;
                    max-width: 500px;
                    box-sizing: border-box;
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
                    font-family: 'Inter', 'Roboto', sans-serif;
                    background: linear-gradient(135deg, rgba(0,0,0,0.8), rgba(30,58,138,0.8));
                    border-radius: 15px;
                    margin: 20px;
                    border: 1px solid rgba(255,255,255,0.1);
                    box-sizing: border-box;
                    max-width: 600px;
                ">
                    <div style="text-align: center;">
                        <div style="font-size: 48px; margin-bottom: 20px; animation: mmm-smh-pulse 2s infinite;">⛰️</div>
                        <div style="font-size: 18px; margin-bottom: 10px;">Loading Scottish Munros...</div>
                        <div style="font-size: 12px; margin-top: 10px; opacity: 0.7;">
                            Initializing React application...
                        </div>
                        <div style="margin-top: 20px;">
                            <div style="width: 200px; height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; overflow: hidden; margin: 0 auto;">
                                <div style="width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.6), transparent); animation: mmm-smh-loading 2s infinite;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <style>
                    @keyframes mmm-smh-pulse {
                        0%, 100% { opacity: 1; transform: scale(1); }
                        50% { opacity: 0.7; transform: scale(1.05); }
                    }
                    @keyframes mmm-smh-loading {
                        0% { transform: translateX(-100%); }
                        100% { transform: translateX(100%); }
                    }
                </style>
            `;
            
            // Load the React app after a short delay
            if (!this.reactAppLoaded) {
                this.reactAppLoaded = true;
                setTimeout(() => {
                    this.loadReactApp();
                }, 1000);
            }
            
            this.domCreated = true;
            return wrapper;
        }

        // React app container - create persistent container
        var reactContainer = document.createElement("div");
        reactContainer.id = "mmm-smh-root-" + this.identifier;
        reactContainer.style.width = "100%";
        reactContainer.style.height = "100%";
        reactContainer.style.minHeight = "400px";
        reactContainer.style.boxSizing = "border-box";
        reactContainer.style.position = "relative";
        
        wrapper.appendChild(reactContainer);
        
        // Initialize React app if not already done
        if (!this.reactAppInitialized) {
            this.reactAppInitialized = true;
            setTimeout(() => {
                this.initializeReactApp();
            }, 100);
        }
        
        this.domCreated = true;
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
        var existingScript = document.querySelector('script[src*="mmm-smh"]');
        if (existingScript) {
            Log.info("MMM-SMH: React script already loaded, initializing...");
            self.loaded = true;
            self.updateDom(self.config.animationSpeed);
            return;
        }
        
        // Create a script element to load the built React app
        var script = document.createElement("script");
        script.type = "module";
        script.src = this.file("dist/assets/index.js"); // Built JS from Vite
        script.setAttribute("data-module", "mmm-smh");
        
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
        var containerId = "mmm-smh-root-" + this.identifier;
        
        try {
            Log.info("MMM-SMH: Initializing React app in container:", containerId);
            
            // Check if React app is available
            if (typeof window !== 'undefined' && window.MMMSMHApp && window.MMMSMHApp.init) {
                window.MMMSMHApp.init(containerId);
                Log.info("MMM-SMH: React app initialized successfully");
            } else {
                // If not available yet, try again after a delay
                var retryCount = 0;
                var maxRetries = 10;
                
                var retryInit = function() {
                    retryCount++;
                    if (window.MMMSMHApp && window.MMMSMHApp.init) {
                        window.MMMSMHApp.init(containerId);
                        Log.info("MMM-SMH: React app initialized successfully (retry " + retryCount + ")");
                    } else if (retryCount < maxRetries) {
                        Log.warn("MMM-SMH: React app not available, retrying... (" + retryCount + "/" + maxRetries + ")");
                        setTimeout(retryInit, 1000);
                    } else {
                        Log.error("MMM-SMH: Failed to initialize React app after " + maxRetries + " retries");
                        self.error = "Failed to initialize React app after multiple attempts";
                        self.updateDom();
                    }
                };
                
                setTimeout(retryInit, 1000);
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
    },

    // Clean up when module is hidden or removed
    suspend: function() {
        Log.info("MMM-SMH: Module suspended");
    },

    resume: function() {
        Log.info("MMM-SMH: Module resumed");
        if (this.loaded && this.domCreated) {
            this.updateDom(this.config.animationSpeed);
        }
    }
});