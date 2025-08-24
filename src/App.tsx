import React from 'react';
import MountainDisplay from './components/MunroDisplay';

interface AppProps {
  mountainType?: 'munros' | 'corbetts';
  title?: string;
  iconColor?: string;
  moduleBasePath?: string;
}

function App({ 
  mountainType = 'munros', 
  title = 'Scottish Munros', 
  iconColor = 'text-blue-400',
  moduleBasePath = ''
}: AppProps) {
  return (
    <div className="mmm-smh-app">
      <MountainDisplay 
        mountainType={mountainType} 
        title={title} 
        iconColor={iconColor} 
        moduleBasePath={moduleBasePath}
        moduleBasePath={moduleBasePath}
      />
    </div>
  );
}

export default App;