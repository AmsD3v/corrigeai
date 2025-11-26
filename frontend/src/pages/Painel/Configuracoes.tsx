import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';
import { useAuth } from '../../contexts/AuthContext';

const Configuracoes = () => {
    const navigate = useNavigate();
    const { logout } = useAuth();
    const [personalInfoOpen, setPersonalInfoOpen] = useState(false);
    const [complementaryInfoOpen, setComplementaryInfoOpen] = useState(false);
    const [theme, setTheme] = useState<'light' | 'dark'>('dark');

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    const handleDeleteAccount = () => {
        if (window.confirm('Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.')) {
            // TODO: Implement account deletion
            console.log('Delete account');
        }
    };

    return (
        <PanelLayout activePage="/painel/configuracoes">
            {/* Header */}
            <div style={{
                marginBottom: '32px'
            }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Configurações e Informações do Usuário
                </h1>
            </div>

            {/* Personal Information Section */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                marginBottom: '16px',
                overflow: 'hidden'
            }}>
                <button
                    onClick={() => setPersonalInfoOpen(!personalInfoOpen)}
                    style={{
                        width: '100%',
                        padding: '20px 24px',
                        background: 'transparent',
                        border: 'none',
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        cursor: 'pointer',
                        color: '#fff',
                        fontSize: '16px',
                        fontWeight: '600'
                    }}
                >
                    <span>Minhas Informações Pessoais</span>
                    <span style={{
                        transform: personalInfoOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                        transition: 'transform 0.3s'
                    }}>
                        ▼
                    </span>
                </button>

                {personalInfoOpen && (
                    <div style={{
                        padding: '0 24px 24px',
                        borderTop: '1px solid #334155'
                    }}>
                        <div style={{ marginTop: '20px' }}>
                            <label style={{
                                display: 'block',
                                fontSize: '13px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                Nome Completo
                            </label>
                            <input
                                type="text"
                                placeholder="Seu nome completo"
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    marginBottom: '16px'
                                }}
                            />

                            <label style={{
                                display: 'block',
                                fontSize: '13px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                Email
                            </label>
                            <input
                                type="email"
                                placeholder="seu@email.com"
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    marginBottom: '16px'
                                }}
                            />

                            <button style={{
                                padding: '10px 24px',
                                background: '#4F46E5',
                                color: '#fff',
                                border: 'none',
                                borderRadius: '8px',
                                fontSize: '14px',
                                fontWeight: '600',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                                onMouseEnter={(e) => e.currentTarget.style.background = '#4338ca'}
                                onMouseLeave={(e) => e.currentTarget.style.background = '#4F46E5'}>
                                Salvar Alterações
                            </button>
                        </div>
                    </div>
                )}
            </div>

            {/* Complementary Information Section */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                marginBottom: '24px',
                overflow: 'hidden'
            }}>
                <button
                    onClick={() => setComplementaryInfoOpen(!complementaryInfoOpen)}
                    style={{
                        width: '100%',
                        padding: '20px 24px',
                        background: 'transparent',
                        border: 'none',
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        cursor: 'pointer',
                        color: '#fff',
                        fontSize: '16px',
                        fontWeight: '600'
                    }}
                >
                    <span>Informações Complementares</span>
                    <span style={{
                        transform: complementaryInfoOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                        transition: 'transform 0.3s'
                    }}>
                        ▼
                    </span>
                </button>

                {complementaryInfoOpen && (
                    <div style={{
                        padding: '0 24px 24px',
                        borderTop: '1px solid #334155'
                    }}>
                        <div style={{ marginTop: '20px' }}>
                            <label style={{
                                display: 'block',
                                fontSize: '13px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                Telefone
                            </label>
                            <input
                                type="tel"
                                placeholder="(00) 00000-0000"
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    marginBottom: '16px'
                                }}
                            />

                            <label style={{
                                display: 'block',
                                fontSize: '13px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                Data de Nascimento
                            </label>
                            <input
                                type="date"
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    marginBottom: '16px'
                                }}
                            />

                            <button style={{
                                padding: '10px 24px',
                                background: '#4F46E5',
                                color: '#fff',
                                border: 'none',
                                borderRadius: '8px',
                                fontSize: '14px',
                                fontWeight: '600',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                                onMouseEnter={(e) => e.currentTarget.style.background = '#4338ca'}
                                onMouseLeave={(e) => e.currentTarget.style.background = '#4F46E5'}>
                                Salvar Alterações
                            </button>
                        </div>
                    </div>
                )}
            </div>

            {/* Theme Settings */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '24px',
                marginBottom: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Aparência
                </h2>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button
                        onClick={() => setTheme('light')}
                        style={{
                            flex: 1,
                            padding: '12px',
                            background: theme === 'light' ? '#4F46E5' : '#0f1419',
                            border: `1px solid ${theme === 'light' ? '#4F46E5' : '#334155'}`,
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: 'pointer'
                        }}
                    >
                        ☀️ Claro
                    </button>
                    <button
                        onClick={() => setTheme('dark')}
                        style={{
                            flex: 1,
                            padding: '12px',
                            background: theme === 'dark' ? '#4F46E5' : '#0f1419',
                            border: `1px solid ${theme === 'dark' ? '#4F46E5' : '#334155'}`,
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: 'pointer'
                        }}
                    >
                        🌙 Escuro
                    </button>
                </div>
            </div>

            {/* Danger Zone */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Zona de Perigo
                </h2>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    <button
                        onClick={handleLogout}
                        style={{
                            padding: '12px 24px',
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => e.currentTarget.style.borderColor = '#64748b'}
                        onMouseLeave={(e) => e.currentTarget.style.borderColor = '#334155'}
                    >
                        Sair da Conta
                    </button>
                    <button
                        onClick={handleDeleteAccount}
                        style={{
                            padding: '12px 24px',
                            background: '#0f1419',
                            border: '1px solid #ef4444',
                            borderRadius: '8px',
                            color: '#ef4444',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.background = '#ef4444';
                            e.currentTarget.style.color = '#fff';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.background = '#0f1419';
                            e.currentTarget.style.color = '#ef4444';
                        }}
                    >
                        Excluir Conta
                    </button>
                </div>
            </div>
        </PanelLayout>
    );
};

export default Configuracoes;
