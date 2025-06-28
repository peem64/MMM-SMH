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

// Standard React app initialization
function initStandardApp() {
  const rootElement = document.getElementById('root');
  if (rootElement) {
    console.log('MMM-SMH: Initializing standalone React app');
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
  const container = document.getElementById(containerId);
  if (container) {
    createRoot(container).render(
      <StrictMode>
        <App />
      </StrictMode>
    );
    console.log('MMM-SMH: React app mounted successfully');
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
  const mmContainer = document.getElementById('mmm-smh-root');
  if (mmContainer) {
    console.log('MMM-SMH: Auto-initializing MagicMirror app');
    initMagicMirrorApp('mmm-smh-root');
  }
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
    autoInitialize();
  }
  
  console.log('MMM-SMH: Module loaded and ready');
}