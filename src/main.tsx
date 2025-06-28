import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.tsx';
import './index.css';

// For MagicMirror integration
declare global {
  interface Window {
    MMMSMHApp: {
      init: (containerId: string) => void;
    };
  }
}

// Keep track of initialized containers to prevent double mounting
const initializedContainers = new Set<string>();

// Standard React app initialization
function initStandardApp() {
  const rootElement = document.getElementById('root');
  if (rootElement && !initializedContainers.has('root')) {
    console.log('MMM-SMH: Initializing standalone React app');
    initializedContainers.add('root');
    createRoot(rootElement).render(
      <StrictMode>
        <App />
      </StrictMode>
    );
  }
}

// MagicMirror module initialization
function initMagicMirrorApp(containerId: string) {
  console.log('MMM-SMH: Initializing MagicMirror React app in container:', containerId);
  
  // Prevent double initialization
  if (initializedContainers.has(containerId)) {
    console.log('MMM-SMH: Container already initialized:', containerId);
    return;
  }
  
  const container = document.getElementById(containerId);
  if (container) {
    try {
      initializedContainers.add(containerId);
      
      // Clear any existing content
      container.innerHTML = '';
      
      // Create root and render
      const root = createRoot(container);
      root.render(
        <StrictMode>
          <App />
        </StrictMode>
      );
      
      console.log('MMM-SMH: React app mounted successfully in container:', containerId);
    } catch (error) {
      console.error('MMM-SMH: Error mounting React app:', error);
      initializedContainers.delete(containerId);
    }
  } else {
    console.error('MMM-SMH: Container not found:', containerId);
  }
}

// Auto-initialize for standalone mode
function autoInitialize() {
  // If there's a root element, initialize as standalone app
  if (document.getElementById('root')) {
    initStandardApp();
  }
  
  // If there's already a MagicMirror container, initialize it
  const mmContainers = document.querySelectorAll('[id^="mmm-smh-root-"]');
  mmContainers.forEach((container) => {
    if (container.id && !initializedContainers.has(container.id)) {
      console.log('MMM-SMH: Auto-initializing MagicMirror app for:', container.id);
      initMagicMirrorApp(container.id);
    }
  });
}

// Check if we're running in browser environment
if (typeof window !== 'undefined') {
  // Expose MagicMirror initialization function
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
  
  // Also listen for dynamic content changes (useful for MagicMirror)
  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      mutation.addedNodes.forEach((node) => {
        if (node.nodeType === Node.ELEMENT_NODE) {
          const element = node as Element;
          // Check if new MMM-SMH containers were added
          const newContainers = element.querySelectorAll('[id^="mmm-smh-root-"]');
          newContainers.forEach((container) => {
            if (container.id && !initializedContainers.has(container.id)) {
              console.log('MMM-SMH: New container detected:', container.id);
              setTimeout(() => initMagicMirrorApp(container.id), 100);
            }
          });
        }
      });
    });
  });
  
  // Start observing
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
  
  console.log('MMM-SMH: Module loaded and ready');
}