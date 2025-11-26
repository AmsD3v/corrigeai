import type { ReactNode } from 'react';
import Sidebar from './Sidebar';
import TopBar from './TopBar';

interface PanelLayoutProps {
    children: ReactNode;
    activePage: string;
}

const PanelLayout = ({ children, activePage }: PanelLayoutProps) => {
    return (
        <div style={{
            minHeight: '100vh',
            background: '#0f1419'
        }}>
            <TopBar userCredits={0} userCoins={0} />
            <Sidebar activePage={activePage} />

            {/* Main Content */}
            <div style={{
                marginLeft: '280px', // Sidebar width
                marginTop: '64px', // TopBar height
                padding: '40px',
                minHeight: 'calc(100vh - 64px)'
            }}>
                {children}
            </div>
        </div>
    );
};

export default PanelLayout;
