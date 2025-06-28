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
    createRoot(rootElement).render(
      <StrictMode>
        <App />
      </StrictMode>
    );
  }
}

// MagicMirror module initialization
function initMagicMirrorApp(containerId: string) {
  const container = document.getElementById(containerId);
  if (container) {
    createRoot(container).render(
      <StrictMode>
        <App />
      </StrictMode>
    );
  }
}

// Check if we're running in MagicMirror or standalone
if (typeof window !== 'undefined') {
  // Expose MagicMirror initialization function
  window.MMMSMHApp = {
    init: initMagicMirrorApp
  };
  
  // If there's a root element, initialize as standalone app
  if (document.getElementById('root')) {
    initStandardApp();
  }
}