import React from 'react';
import type { ReactNode } from 'react';
import Sidebar from './Sidebar';

interface PainelLayoutProps {
  children: ReactNode;
}

const PainelLayout: React.FC<PainelLayoutProps> = ({ children }) => {
  return (
    <div className="flex h-screen bg-gray-900 text-white">
      <Sidebar />
      <main className="flex-1 p-6">
        {children}
      </main>
    </div>
  );
};

export default PainelLayout;
