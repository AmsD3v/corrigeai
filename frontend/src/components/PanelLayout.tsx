import type { ReactNode } from 'react';
import Sidebar from './Sidebar';
import TopBar from './TopBar';

interface PanelLayoutProps {
    children: ReactNode;
    activePage: string;
}

const PanelLayout = ({ children, activePage }: PanelLayoutProps) => {
    return (
        <div className="min-h-screen bg-[#0f1419]">
            <TopBar userCredits={0} userCoins={0} />
            <Sidebar activePage={activePage} />

            {/* Main Content */}
            <div className="mt-16 min-h-[calc(100vh-4rem)] p-5 md:p-8 lg:p-10 lg:ml-[280px]">
                {children}
            </div>
        </div>
    );
};

export default PanelLayout;
