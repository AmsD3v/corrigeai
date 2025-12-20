import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { useState, useEffect } from 'react';
import apiClient from '../services/api';

interface TopBarProps {
    userCredits?: number;
    userCoins?: number;
}

const TopBar = ({ userCredits = 0, userCoins = 0 }: TopBarProps) => {
    const navigate = useNavigate();
    const { logout } = useAuth();
    const [credits, setCredits] = useState(userCoins);
    const [freeCredits, setFreeCredits] = useState(userCredits);

    // Fetch user credits on mount and update every 10 seconds
    useEffect(() => {
        const fetchCredits = async () => {
            try {
                const response = await apiClient.get('/users/me');
                setCredits(response.data.credits || 0);
                setFreeCredits(response.data.free_credits || 0);
            } catch (error) {
                console.error('Error fetching credits:', error);
            }
        };

        fetchCredits();
        const interval = setInterval(fetchCredits, 10000); // Refresh every 10s

        return () => clearInterval(interval);
    }, []);

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    return (
        <div className="fixed top-0 left-0 right-0 h-16 bg-[#1a1f2e] border-b border-[#334155] flex items-center justify-between px-4 md:px-6 z-[1000]">
            {/* Logo */}
            <div
                className="flex items-center gap-3 cursor-pointer"
                onClick={() => navigate('/painel')}
            >
                <div className="w-8 h-8 md:w-10 md:h-10 bg-gradient-to-br from-[#4F46E5] to-[#818cf8] rounded-lg flex items-center justify-center overflow-hidden">
                    <img src="/owl_custom.webp" alt="Logo" className="w-[85%] h-[85%] object-contain" />
                </div>
                <span className="hidden sm:inline text-lg md:text-xl font-bold text-white">
                    Corrige<span className="text-[#4F46E5]">AI</span>
                </span>
            </div>

            {/* Right Side - Credits & User */}
            <div className="flex items-center gap-2 md:gap-5">
                {/* CorriCoins Display */}
                <div className="flex items-center gap-2 md:gap-3 bg-[#0f1419] px-2 md:px-4 py-2 rounded-lg border border-[#334155]">
                    <div className="flex items-center gap-1">
                        <span className="text-base md:text-lg">🪙</span>
                        <span className="text-xs md:text-sm font-semibold text-[#fbbf24]">
                            <span className="hidden md:inline">CorriCoins: </span>{credits}
                        </span>
                    </div>
                    <div className="w-px h-5 bg-[#334155] hidden md:block"></div>
                    <div className="flex items-center gap-1">
                        <span className="text-sm md:text-base">⚡</span>
                        <span className="text-xs md:text-sm font-semibold text-[#10b981]">
                            <span className="hidden md:inline">Grátis: </span>{freeCredits}
                        </span>
                    </div>
                </div>

                {/* Logout Button */}
                <button
                    onClick={handleLogout}
                    className="bg-[#ef4444] hover:bg-[#dc2626] text-white px-3 md:px-4 py-2 rounded-lg text-sm font-semibold transition-all"
                >
                    <span className="hidden md:inline">Sair</span>
                    <span className="md:hidden">🚪</span>
                </button>
            </div>
        </div>
    );
};

export default TopBar;
