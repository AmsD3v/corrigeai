import { Link } from 'react-router-dom';
import { useState } from 'react';

interface SidebarProps {
    activePage: string;
}

const Sidebar = ({ activePage }: SidebarProps) => {
    const [isOpen, setIsOpen] = useState(false);

    const menuItems = [
        { path: '/painel', icon: '🏠', label: 'Painel' },
        { path: '/painel/minhas-redacoes', icon: '📄', label: 'Minhas Redações' },
        { path: '/painel/redigir-redacao', icon: '✍️', label: 'Redigir Redação' },
        { path: '/painel/desenvolvimento', icon: '📊', label: 'Meu Desenvolvimento' },
        { path: '/painel/comprar-creditos', icon: '💰', label: 'Comprar CorriCoins' },
        { path: '/painel/transacoes', icon: '🛒', label: 'Minhas Compras' },
        { path: '/painel/configuracoes', icon: '⚙️', label: 'Configurações' },
        { path: '/painel/feedback', icon: '💬', label: 'Feedback' }
    ];

    return (
        <>
            {/* Mobile Menu Button */}
            <button
                onClick={() => setIsOpen(!isOpen)}
                className="lg:hidden fixed top-4 left-4 z-[1001] p-3 bg-[#1a1f2e] border border-[#334155] rounded-lg text-white text-xl"
            >
                {isOpen ? '✕' : '☰'}
            </button>

            {/* Overlay for mobile */}
            {isOpen && (
                <div
                    onClick={() => setIsOpen(false)}
                    className="lg:hidden fixed inset-0 bg-black/50 z-[999]"
                />
            )}

            {/* Sidebar */}
            <div
                className={`fixed left-0 bottom-0 w-[280px] bg-[#1a1f2e] border-r border-[#334155] flex flex-col z-[999] transition-transform duration-300 top-0 lg:top-16 ${isOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'
                    }`}
            >
                {/* Menu */}
                <nav className="mt-16 lg:mt-6 flex-1 overflow-y-auto px-3">
                    {menuItems.map((item) => {
                        const isActive = activePage === item.path;
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                onClick={() => setIsOpen(false)}
                                className={`flex items-center gap-3 px-6 py-3 text-sm font-medium transition-all border-l-[3px] ${isActive
                                    ? 'bg-[#334155] text-white border-l-[#4F46E5]'
                                    : 'bg-transparent text-[#94a3b8] border-l-transparent hover:bg-[#334155] hover:text-white'
                                    } no-underline`}
                            >
                                <span>{item.icon}</span>
                                {item.label}
                            </Link>
                        );
                    })}
                </nav>

                {/* Footer */}
                <div className="p-6 border-t border-[#334155] text-xs text-[#64748b] text-center">
                    © 2025 CorrigeAI
                </div>
            </div>
        </>
    );
};

export default Sidebar;
