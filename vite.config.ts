import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  optimizeDeps: {
    exclude: ['lucide-react'],
  },
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    // Clean the output directory before building
    emptyOutDir: true,
    rollupOptions: {
      output: {
        // Ensure consistent file names for MagicMirror
        entryFileNames: 'assets/index.js',
        chunkFileNames: 'assets/[name]-[hash].js',
        assetFileNames: (assetInfo) => {
          if (assetInfo.name && assetInfo.name.endsWith('.css')) {
            return 'assets/index.css';
          }
          return 'assets/[name]-[hash].[ext]';
        }
      }
    },
    // Ensure the build works in different environments
    target: 'es2015',
    minify: 'terser'
  },
  // Copy public assets to dist
  publicDir: 'public'
});