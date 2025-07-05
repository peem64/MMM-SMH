import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.tsx';
import './index.css';

// For MagicMirror integration
declare global {
  interface Window {
    MMMSMHApp: {
      init: (containerId: string, shadowRoot?: ShadowRoot) => void;
    };
  }
}

// Keep track of initialized containers to prevent double mounting
const initializedContainers = new Set<string>();
const rootInstances = new Map<string, any>();

// Standard React app initialization
function initStandardApp() {
  const rootElement = document.getElementById('root');
  if (rootElement && !initializedContainers.has('root')) {
    console.log('MMM-SMH: Initializing standalone React app');
    initializedContainers.add('root');
    const root = createRoot(rootElement);
    rootInstances.set('root', root);
    root.render(
      <StrictMode>
        <App />
      </StrictMode>
    );
  }
}

// MagicMirror module initialization with shadow DOM support
function initMagicMirrorApp(containerId: string, shadowRoot?: ShadowRoot, config?: any) {
  console.log('MMM-SMH: Attempting to initialize React app in container:', containerId);
  console.log('MMM-SMH: Module config received:', config);
  
  // Prevent double initialization
  if (initializedContainers.has(containerId)) {
    console.log('MMM-SMH: Container already initialized:', containerId);
    return;
  }
  
  // Wait for container to be available
  let attempts = 0;
  const maxAttempts = 50;
  
  const tryInit = () => {
    attempts++;
    
    // Look for container in shadow DOM first, then regular DOM
    let container = null;
    if (shadowRoot) {
      container = shadowRoot.getElementById(containerId);
    } else {
      container = document.getElementById(containerId);
    }
    
    if (container) {
      try {
        console.log('MMM-SMH: Found container, initializing React app:', containerId);
        initializedContainers.add(containerId);
        
        // Clear any existing content
        container.innerHTML = '';
        
        // Create root and render
        const root = createRoot(container);
        rootInstances.set(containerId, root);
        
        // Use config from MagicMirror module or defaults
        const appConfig = config || {
          mountainType: 'munros',
          title: 'Scottish Munros',
          iconColor: 'text-blue-400'
        };
        
        root.render(
          <StrictMode>
            <App {...appConfig} />
          </StrictMode>
        );
        
        console.log('MMM-SMH: React app mounted successfully in container:', containerId);
      } catch (error) {
        console.error('MMM-SMH: Error mounting React app:', error);
        initializedContainers.delete(containerId);
      }
    } else if (attempts < maxAttempts) {
      console.log(`MMM-SMH: Container not found, retrying... (${attempts}/${maxAttempts})`);
      setTimeout(tryInit, 200);
    } else {
      console.error('MMM-SMH: Container not found after maximum attempts:', containerId);
    }
  };
  
  tryInit();
}

// Auto-initialize for standalone mode
function autoInitialize() {
  // If there's a root element, initialize as standalone app
  if (document.getElementById('root')) {
    initStandardApp();
  }
  
  // If there's already a MagicMirror container, initialize it
  const mmContainers = document.querySelectorAll('[id^="mmm-smh-react-"]');
  mmContainers.forEach((container) => {
    if (container.id && !initializedContainers.has(container.id)) {
      console.log('MMM-SMH: Auto-initializing MagicMirror app for:', container.id);
      setTimeout(() => initMagicMirrorApp(container.id), 100);
    }
  });
}

// Check if we're running in browser environment
if (typeof window !== 'undefined') {
  // Expose MagicMirror initialization function with shadow DOM support
  window.MMMSMHApp = {
    init: initMagicMirrorApp
  };
  
  // Auto-initialize when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', autoInitialize);
  } else {
    // DOM is already ready, initialize immediately
    setTimeout(autoInitialize, 100);
  }
  
  console.log('MMM-SMH: Module loaded and ready');
}