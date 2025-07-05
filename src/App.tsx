import React from 'react';
import MountainDisplay from './components/MunroDisplay';

function App() {
  return (
    <div className="mmm-smh-app">
      <MountainDisplay mountainType="munros" title="Scottish Munros" iconColor="text-blue-400" />
    </div>
  );
}

export default App;