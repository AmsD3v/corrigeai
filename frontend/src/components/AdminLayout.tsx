import type { ReactNode } from 'react';
import AdminSidebar from './AdminSidebar';
import AdminTopBar from './AdminTopBar';

interface AdminLayoutProps {
    children: ReactNode;
    activePage: string;
}

const AdminLayout = ({ children, activePage }: AdminLayoutProps) => {
    return (
        <div style={{
            minHeight: '100vh',
            background: '#0f1419'
        }}>
            <AdminTopBar />
            <AdminSidebar activePage={activePage} />

            {/* Main Content */}
            <div style={{
                marginLeft: '280px',
                marginTop: '64px',
                padding: '40px',
                minHeight: 'calc(100vh - 64px)'
            }}>
                {children}
            </div>
        </div>
    );
};

export default AdminLayout;
