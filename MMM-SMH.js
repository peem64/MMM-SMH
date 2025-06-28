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
        maxHeight: "100%"
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
        
        // Set up update timer
        this.scheduleUpdate();
    },

    // Schedule the next update
    scheduleUpdate: function() {
        var self = this;
        
        setInterval(function() {
            self.updateDom(self.config.animationSpeed);
        }, this.config.updateInterval);
    },

    // Override dom creation
    getDom: function() {
        var wrapper = document.createElement("div");
        wrapper.className = "mmm-smh-wrapper";
        wrapper.style.width = this.config.maxWidth;
        wrapper.style.height = this.config.maxHeight;
        
        if (!this.loaded) {
            wrapper.innerHTML = `
                <div class="loading-container" style="
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    min-height: 200px;
                    color: white;
                    font-family: 'Roboto', sans-serif;
                ">
                    <div style="text-align: center;">
                        <div style="font-size: 24px; margin-bottom: 10px;">⛰️</div>
                        <div>Loading Scottish Munros...</div>
                    </div>
                </div>
            `;
            
            // Load the React app
            this.loadReactApp(wrapper);
            return wrapper;
        }

        if (this.error) {
            wrapper.innerHTML = `
                <div class="error-container" style="
                    color: #ff6b6b;
                    text-align: center;
                    padding: 20px;
                    font-family: 'Roboto', sans-serif;
                ">
                    <div style="font-size: 24px; margin-bottom: 10px;">⚠️</div>
                    <div>Error loading Munros module</div>
                    <div style="font-size: 12px; margin-top: 10px; opacity: 0.7;">
                        ${this.error}
                    </div>
                </div>
            `;
            return wrapper;
        }

        return wrapper;
    },

    // Load the React application
    loadReactApp: function(container) {
        var self = this;
        
        // Create a script element to load the built React app
        var script = document.createElement("script");
        script.type = "module";
        script.src = this.file("dist/assets/index.js"); // Built JS from Vite
        
        script.onload = function() {
            self.loaded = true;
            Log.info("MMM-SMH React app loaded successfully");
            
            // Clear the loading message and let React take over
            container.innerHTML = '<div id="mmm-smh-root"></div>';
            
            // Initialize React app in the container
            if (window.MMMSMHApp && window.MMMSMHApp.init) {
                window.MMMSMHApp.init('mmm-smh-root');
            }
        };
        
        script.onerror = function() {
            self.error = "Failed to load React application. Please ensure the module is built correctly.";
            self.updateDom();
            Log.error("Failed to load MMM-SMH React app");
        };
        
        document.head.appendChild(script);
    },

    // Handle notifications from other modules
    notificationReceived: function(notification, payload, sender) {
        if (notification === "DOM_OBJECTS_CREATED") {
            // Module is ready
        }
    },

    // Handle socket notifications
    socketNotificationReceived: function(notification, payload) {
        // Handle any socket notifications if needed
    }
});