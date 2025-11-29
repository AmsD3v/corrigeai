import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext'; 
import apiClient from '../../services/api';
import ConfirmModal from '../../components/ConfirmModal';

// Phone mask helper
const formatPhone = (value: string) => {
    const numbers = value.replace(/\D/g, '');
    if (numbers.length <= 10) {
        return numbers.replace(/(\d{2})(\d{4})(\d{0,4})/, '($1) $2-$3');
    }
    return numbers.replace(/(\d{2})(\d{5})(\d{0,4})/, '($1) $2-$3');
};

const Configuracoes = () => {
    const navigate = useNavigate();
    const { logout } = useAuth();

    // UI State
    const [personalInfoOpen, setPersonalInfoOpen] = useState(true);
    const [complementaryInfoOpen, setComplementaryInfoOpen] = useState(false);
    const { theme, setTheme } = useTheme();

    // Form State
    const [fullName, setFullName] = useState('');
    const [email, setEmail] = useState('');
    const [phone, setPhone] = useState('');
    const [birthDate, setBirthDate] = useState('');

    // Loading & Feedback State
    const [loading, setLoading] = useState(true);
    const [savingPersonal, setSavingPersonal] = useState(false);
    const [savingComplementary, setSavingComplementary] = useState(false);
    const [personalSuccess, setPersonalSuccess] = useState(false);
    const [complementarySuccess, setComplementarySuccess] = useState(false);
    const [error, setError] = useState('');

    // Delete account modal state
    const [showDeleteModal, setShowDeleteModal] = useState(false);
    const [deleting, setDeleting] = useState(false);

    // Load user data on mount
    useEffect(() => {
        const fetchUserData = async () => {
            try {
                const response = await apiClient.get('/users/me');
                const user = response.data;

                setFullName(user.full_name || '');
                setEmail(user.email || '');
                setPhone(user.phone ? formatPhone(user.phone) : '');
                setBirthDate(user.birth_date || '');
            } catch (err) {
                console.error('Error loading user data:', err);
                setError('Erro ao carregar dados do usuário');
            } finally {
                setLoading(false);
            }
        };

        fetchUserData();
    }, []);

    const handleSavePersonalInfo = async () => {
        setSavingPersonal(true);
        setError('');
        setPersonalSuccess(false);

        try {
            await apiClient.put('/users/me/profile', {
                full_name: fullName,
                email: email
            });

            setPersonalSuccess(true);
            setTimeout(() => setPersonalSuccess(false), 3000);
        } catch (err: any) {
            setError(err.response?.data?.detail || 'Erro ao salvar informações');
        } finally {
            setSavingPersonal(false);
        }
    };

    const handleSaveComplementaryInfo = async () => {
        setSavingComplementary(true);
        setError('');
        setComplementarySuccess(false);

        try {
            const phoneNumbers = phone.replace(/\D/g, '');

            await apiClient.put('/users/me/profile', {
                phone: phoneNumbers || null,
                birth_date: birthDate || null
            });

            setComplementarySuccess(true);
            setTimeout(() => setComplementarySuccess(false), 3000);
        } catch (err: any) {
            setError(err.response?.data?.detail || 'Erro ao salvar informações');
        } finally {
            setSavingComplementary(false);
        }
    };

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    const handleDeleteAccount = () => {
        setShowDeleteModal(true);
    };

    const confirmDeleteAccount = async () => {
        try {
            setDeleting(true);
            await apiClient.delete('/users/me');

            // Logout and redirect to login
            logout();
            navigate('/login');
        } catch (err: any) {
            console.error('Error deleting account:', err);
            setError(err.response?.data?.detail || 'Erro ao excluir conta');
            setShowDeleteModal(false);
        } finally {
            setDeleting(false);
        }
    };

    if (loading) {
        return (
            <PanelLayout activePage="/painel/configuracoes">
                <div style={{ textAlign: 'center', padding: '60px', color: '#94a3b8' }}>
                    Carregando...
                </div>
            </PanelLayout>
        );
    }

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

            {/* Error Alert */}
            {error && (
                <div style={{
                    background: '#ef444420',
                    border: '1px solid #ef4444',
                    borderRadius: '8px',
                    padding: '16px',
                    marginBottom: '16px',
                    color: '#ef4444',
                    fontSize: '14px'
                }}>
                    {error}
                </div>
            )}

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
                                value={fullName}
                                onChange={(e) => setFullName(e.target.value)}
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
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
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

                            <button
                                onClick={handleSavePersonalInfo}
                                disabled={savingPersonal}
                                style={{
                                    padding: '10px 24px',
                                    background: personalSuccess ? '#10b981' : '#4F46E5',
                                    color: '#fff',
                                    border: 'none',
                                    borderRadius: '8px',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: savingPersonal ? 'not-allowed' : 'pointer',
                                    transition: 'all 0.2s',
                                    opacity: savingPersonal ? 0.7 : 1
                                }}
                                onMouseEnter={(e) => {
                                    if (!savingPersonal && !personalSuccess) {
                                        e.currentTarget.style.background = '#4338ca';
                                    }
                                }}
                                onMouseLeave={(e) => {
                                    if (!personalSuccess) {
                                        e.currentTarget.style.background = '#4F46E5';
                                    }
                                }}>
                                {savingPersonal ? 'Salvando...' : personalSuccess ? '✓ Salvo!' : 'Salvar Alterações'}
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
                                value={phone}
                                onChange={(e) => setPhone(formatPhone(e.target.value))}
                                placeholder="(00) 00000-0000"
                                maxLength={15}
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
                                value={birthDate}
                                onChange={(e) => setBirthDate(e.target.value)}
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    marginBottom: '16px',
                                    colorScheme: 'dark'
                                }}
                            />

                            <button
                                onClick={handleSaveComplementaryInfo}
                                disabled={savingComplementary}
                                style={{
                                    padding: '10px 24px',
                                    background: complementarySuccess ? '#10b981' : '#4F46E5',
                                    color: '#fff',
                                    border: 'none',
                                    borderRadius: '8px',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: savingComplementary ? 'not-allowed' : 'pointer',
                                    transition: 'all 0.2s',
                                    opacity: savingComplementary ? 0.7 : 1
                                }}
                                onMouseEnter={(e) => {
                                    if (!savingComplementary && !complementarySuccess) {
                                        e.currentTarget.style.background = '#4338ca';
                                    }
                                }}
                                onMouseLeave={(e) => {
                                    if (!complementarySuccess) {
                                        e.currentTarget.style.background = '#4F46E5';
                                    }
                                }}>
                                {savingComplementary ? 'Salvando...' : complementarySuccess ? '✓ Salvo!' : 'Salvar Alterações'}
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

            {/* Delete Account Confirmation Modal */}
            <ConfirmModal
                isOpen={showDeleteModal}
                title="Excluir Conta"
                message="Tem certeza que deseja excluir sua conta permanentemente? Todas as suas redações e dados serão perdidos. Esta ação não pode ser desfeita."
                confirmText={deleting ? "Excluindo..." : "Sim, Excluir"}
                cancelText="Cancelar"
                variant="danger"
                onConfirm={confirmDeleteAccount}
                onCancel={() => setShowDeleteModal(false)}
            />
        </PanelLayout>
    );
};

export default Configuracoes;

