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
        <div style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            height: '64px',
            background: '#1a1f2e',
            borderBottom: '1px solid #334155',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '0 24px',
            zIndex: 1000
        }}>
            {/* Logo */}
            <div
                style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '12px',
                    cursor: 'pointer'
                }}
                onClick={() => navigate('/painel')}
            >
                <div style={{
                    width: '40px',
                    height: '40px',
                    background: 'linear-gradient(135deg, #4F46E5 0%, #818cf8 100%)',
                    borderRadius: '10px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '24px'
                }}>
                    🦉
                </div>
                <span style={{
                    fontSize: '20px',
                    fontWeight: '700',
                    color: '#fff'
                }}>
                    Corrige<span style={{ color: '#4F46E5' }}>AI</span>
                </span>
            </div>

            {/* Right Side - Credits & User */}
            <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '20px'
            }}>
                {/* CorriCoins Display */}
                <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '12px',
                    background: '#0f1419',
                    padding: '8px 16px',
                    borderRadius: '8px',
                    border: '1px solid #334155'
                }}>
                    <div style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '6px'
                    }}>
                        <span style={{ fontSize: '18px' }}>🪙</span>
                        <span style={{
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#fbbf24'
                        }}>
                            CorriCoins: {credits}
                        </span>
                    </div>
                    <div style={{
                        width: '1px',
                        height: '20px',
                        background: '#334155'
                    }}></div>
                    <div style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '6px'
                    }}>
                        <span style={{ fontSize: '16px' }}>⚡</span>
                        <span style={{
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#10b981'
                        }}>
                            Grátis: {freeCredits}
                        </span>
                    </div>
                </div>

                {/* Logout Button */}
                <button
                    onClick={handleLogout}
                    style={{
                        background: '#ef4444',
                        color: '#fff',
                        border: 'none',
                        padding: '8px 16px',
                        borderRadius: '8px',
                        fontSize: '14px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        transition: 'all 0.2s'
                    }}
                    onMouseEnter={(e) => {
                        e.currentTarget.style.background = '#dc2626';
                    }}
                    onMouseLeave={(e) => {
                        e.currentTarget.style.background = '#ef4444';
                    }}
                >
                    Sair
                </button>
            </div>
        </div>
    );
};

export default TopBar;
