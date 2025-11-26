import { useState, useEffect } from 'react';
import api from '../../services/api';
import AdminLayout from '../../components/AdminLayout';

interface Settings {
    siteName: string;
    contactEmail: string;
    supportEmail: string;
    geminiApiKey: string;
    aiProvider?: string;
    groqApiKey?: string;
    hfToken?: string;
    togetherApiKey?: string;
    maintenanceMode: boolean;
    creditValue: number; // Valor por CorriCoin em reais
    packages: {
        id: string;
        name: string;
        credits: number;
        price: number;
        discount_percentage: number;
        discount_text: string | null;
        bonus: number;
        feature1: string;
        feature2: string;
        feature3: string;
        feature4: string;
    }[];
}

const Configuracoes = () => {
    const [settings, setSettings] = useState<Settings>({
        siteName: 'CorrigeAI',
        contactEmail: 'contato@corrigeai.com',
        supportEmail: 'suporte@corrigeai.com',
        geminiApiKey: import.meta.env.VITE_GEMINI_API_KEY || '',
        aiProvider: 'groq',  // Default to Groq (recommended)
        groqApiKey: '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',
        hfToken: '',
        togetherApiKey: '',
        maintenanceMode: false,
        creditValue: 2.20, // Valor padrão por CorriCoin
        packages: []
    });

    const [saved, setSaved] = useState(false);
    const [showApiKey, setShowApiKey] = useState(false);

    useEffect(() => {
        // Load settings from localStorage
        const savedSettings = localStorage.getItem('admin_settings');
        if (savedSettings) {
            try {
                const parsed = JSON.parse(savedSettings);
                // Preserve packages from API if they are already loaded? No, API is truth.
                // But we want to load other settings.
                const { packages, ...otherSettings } = parsed;
                setSettings(prev => ({ ...prev, ...otherSettings }));
            } catch (e) {
                console.error('Error loading settings:', e);
            }
        }

        fetchPackages();
    }, []);

    const fetchPackages = async () => {
        try {
            const response = await api.get('/api/packages');
            const apiPackages = response.data.map((pkg: any) => ({
                id: pkg.id,
                name: pkg.name,
                credits: pkg.credits,
                price: pkg.price / 100,
                discount_percentage: pkg.discount_percentage || 0,
                discount_text: pkg.discount_text || null,
                bonus: pkg.bonus,
                feature1: pkg.feature1 || '',
                feature2: pkg.feature2 || '',
                feature3: pkg.feature3 || '',
                feature4: pkg.feature4 || ''
            }));

            setSettings(prev => ({
                ...prev,
                packages: apiPackages
            }));
        } catch (error) {
            console.error('Error fetching packages:', error);
        }
    };

    const handleSaveSettings = async () => {
        // Save local settings
        localStorage.setItem('admin_settings', JSON.stringify(settings));

        // Save packages to API
        try {
            await Promise.all(settings.packages.map(pkg =>
                api.put(`/api/packages/${pkg.id}`, {
                    name: pkg.name,
                    credits: pkg.credits,
                    price: Math.round(pkg.price * 100), // Convert to cents
                    discount_percentage: pkg.discount_percentage,
                    discount_text: pkg.discount_text,
                    bonus: pkg.bonus,
                    feature1: pkg.feature1,
                    feature2: pkg.feature2,
                    feature3: pkg.feature3,
                    feature4: pkg.feature4
                })
            ));

            setSaved(true);
            setTimeout(() => setSaved(false), 3000);
        } catch (error: any) {
            console.error('Error saving packages:', error);
            console.error('Error response:', error.response?.data);
            console.error('Error status:', error.response?.status);
            alert(`Erro ao salvar pacotes: ${error.response?.data?.detail || error.message}`);
        }
    };

    const handleUpdatePackage = (id: string, field: string, value: any) => {
        setSettings(prev => {
            const updatedPackages = prev.packages.map(pkg => {
                if (pkg.id === id) {
                    const updated = { ...pkg, [field]: value };

                    // Auto-calculate price when credits or discount changes
                    if (field === 'credits' || field === 'discount_percentage') {
                        const credits = field === 'credits' ? value : pkg.credits;
                        const discount = field === 'discount_percentage' ? value : pkg.discount_percentage;

                        // Price = Credits × CreditValue × (1 - Discount/100)
                        const basePrice = credits * prev.creditValue;
                        const finalPrice = basePrice * (1 - discount / 100);
                        updated.price = parseFloat(finalPrice.toFixed(2));

                        // Auto-generate discount_text when discount changes
                        if (field === 'discount_percentage') {
                            updated.discount_text = discount > 0 ? `${discount}% OFF!` : null;
                        }
                    }

                    return updated;
                }
                return pkg;
            });

            return { ...prev, packages: updatedPackages };
        });
    };

    return (
        <AdminLayout activePage="/admin/configuracoes">
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Configurações do Sistema
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Gerencie as configurações gerais da plataforma
                </p>
            </div>

            {/* Save Button */}
            <div style={{
                position: 'fixed',
                bottom: '32px',
                right: '32px',
                zIndex: 100
            }}>
                <button
                    onClick={handleSaveSettings}
                    style={{
                        padding: '16px 32px',
                        background: saved ? '#10b981' : '#ef4444',
                        border: 'none',
                        borderRadius: '12px',
                        color: '#fff',
                        fontSize: '16px',
                        fontWeight: '700',
                        cursor: 'pointer',
                        boxShadow: '0 8px 24px rgba(239, 68, 68, 0.4)',
                        transition: 'all 0.3s',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px'
                    }}
                >
                    {saved ? '✅ Salvo!' : '💾 Salvar Alterações'}
                </button>
            </div>

            {/* General Settings */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Configurações Gerais
                </h2>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Nome do Site
                        </label>
                        <input
                            type="text"
                            value={settings.siteName}
                            onChange={(e) => setSettings({ ...settings, siteName: e.target.value })}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px'
                            }}
                        />
                    </div>

                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Email de Contato
                        </label>
                        <input
                            type="email"
                            value={settings.contactEmail}
                            onChange={(e) => setSettings({ ...settings, contactEmail: e.target.value })}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px'
                            }}
                        />
                    </div>

                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Email de Suporte
                        </label>
                        <input
                            type="email"
                            value={settings.supportEmail}
                            onChange={(e) => setSettings({ ...settings, supportEmail: e.target.value })}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px'
                            }}
                        />
                    </div>
                </div>
            </div>

            {/* AI Settings */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Configurações de IA
                </h2>

                {/* Provider Selection */}
                <div style={{ marginBottom: '16px' }}>
                    <label style={{
                        display: 'block',
                        fontSize: '14px',
                        color: '#94a3b8',
                        marginBottom: '8px',
                        fontWeight: '500'
                    }}>
                        Provedor de IA
                    </label>
                    <select
                        value={settings.aiProvider || 'gemini'}
                        onChange={(e) => setSettings({ ...settings, aiProvider: e.target.value })}
                        style={{
                            width: '100%',
                            padding: '12px 16px',
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            cursor: 'pointer'
                        }}
                    >
                        <option value="gemini">🟢 Google Gemini (Atual)</option>
                        <option value="groq">⚡ Groq (Llama 3.1 - Recomendado)</option>
                        <option value="huggingface">🤗 HuggingFace (Mistral/Llama)</option>
                        <option value="together">🔷 Together AI (Llama 3.1/Mixtral)</option>
                    </select>
                    <p style={{
                        fontSize: '12px',
                        color: '#64748b',
                        marginTop: '8px'
                    }}>
                        {settings.aiProvider === 'groq' && '⚡ Groq: Muito rápido, sem bloqueios de segurança (Recomendado)'}
                        {(!settings.aiProvider || settings.aiProvider === 'gemini') && '🟢 Gemini: Pode bloquear avaliações de texto'}
                        {settings.aiProvider === 'huggingface' && '🤗 HuggingFace: Modelos open-source, bom custo-benefício'}
                        {settings.aiProvider === 'together' && '🔷 Together AI: Alta qualidade, $25 créditos iniciais grátis'}
                    </p>
                </div>

                {/* API Key Input */}
                <div>
                    <label style={{
                        display: 'block',
                        fontSize: '14px',
                        color: '#94a3b8',
                        marginBottom: '8px',
                        fontWeight: '500'
                    }}>
                        Chave API
                    </label>

                    {/* Input with Eye Toggle */}
                    <div style={{ position: 'relative' }}>
                        <input
                            type={showApiKey ? "text" : "password"}
                            value={
                                settings.aiProvider === 'groq' ? (settings.groqApiKey || '') :
                                    settings.aiProvider === 'huggingface' ? (settings.hfToken || '') :
                                        settings.aiProvider === 'together' ? (settings.togetherApiKey || '') :
                                            settings.geminiApiKey
                            }
                            onChange={(e) => {
                                if (settings.aiProvider === 'groq') {
                                    setSettings({ ...settings, groqApiKey: e.target.value });
                                } else if (settings.aiProvider === 'huggingface') {
                                    setSettings({ ...settings, hfToken: e.target.value });
                                } else if (settings.aiProvider === 'together') {
                                    setSettings({ ...settings, togetherApiKey: e.target.value });
                                } else {
                                    setSettings({ ...settings, geminiApiKey: e.target.value });
                                }
                            }}
                            placeholder={
                                settings.aiProvider === 'groq' ? 'gsk_...' :
                                    settings.aiProvider === 'huggingface' ? 'hf_...' :
                                        settings.aiProvider === 'together' ? 'together_...' :
                                            'AIza...'
                            }
                            style={{
                                width: '100%',
                                padding: '12px 48px 12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                fontFamily: 'monospace'
                            }}
                        />
                        <button
                            type="button"
                            onClick={() => setShowApiKey(!showApiKey)}
                            style={{
                                position: 'absolute',
                                right: '12px',
                                top: '50%',
                                transform: 'translateY(-50%)',
                                background: 'transparent',
                                border: 'none',
                                cursor: 'pointer',
                                fontSize: '18px',
                                color: '#64748b',
                                padding: '4px 8px',
                                transition: 'color 0.2s'
                            }}
                            onMouseEnter={(e) => e.currentTarget.style.color = '#94a3b8'}
                            onMouseLeave={(e) => e.currentTarget.style.color = '#64748b'}
                        >
                            {showApiKey ? '🙈' : '👁️'}
                        </button>
                    </div>

                    <p style={{
                        fontSize: '12px',
                        color: '#64748b',
                        marginTop: '8px'
                    }}>
                        {settings.aiProvider === 'groq' && 'Obtenha em: https://console.groq.com'}
                        {(!settings.aiProvider || settings.aiProvider === 'gemini') && 'Obtenha em: https://aistudio.google.com/app/apikey'}
                        {settings.aiProvider === 'huggingface' && 'Obtenha em: https://huggingface.co/settings/tokens'}
                        {settings.aiProvider === 'together' && 'Obtenha em: https://api.together.xyz/settings/api-keys'}
                    </p>
                </div>
            </div>

            {/* Credit Value Configuration */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Valor do CorriCoin
                </h2>

                <div>
                    <label style={{
                        display: 'block',
                        fontSize: '14px',
                        color: '#94a3b8',
                        marginBottom: '8px',
                        fontWeight: '500'
                    }}>
                        Valor por CorriCoin (R$)
                    </label>
                    <input
                        type="number"
                        step="0.01"
                        min="0"
                        value={settings.creditValue}
                        onChange={(e) => {
                            const newCreditValue = parseFloat(e.target.value) || 0;
                            setSettings(prev => {
                                // Recalculate all package prices with new credit value
                                const updatedPackages = prev.packages.map(pkg => {
                                    const basePrice = pkg.credits * newCreditValue;
                                    const finalPrice = basePrice * (1 - pkg.discount_percentage / 100);
                                    return {
                                        ...pkg,
                                        price: parseFloat(finalPrice.toFixed(2))
                                    };
                                });

                                return {
                                    ...prev,
                                    creditValue: newCreditValue,
                                    packages: updatedPackages
                                };
                            });
                        }}
                        style={{
                            width: '200px',
                            padding: '12px 16px',
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px'
                        }}
                    />
                    <p style={{
                        fontSize: '12px',
                        color: '#64748b',
                        marginTop: '8px'
                    }}>
                        Este valor será usado para calcular automaticamente o preço dos pacotes
                    </p>
                </div>
            </div>

            {/* Pricing Configuration */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Configuração de Preços
                </h2>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {settings.packages.map((pkg) => (
                        <div
                            key={pkg.id}
                            style={{
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                padding: '16px'
                            }}
                        >
                            <div style={{
                                display: 'grid',
                                gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr',
                                gap: '12px',
                                alignItems: 'center'
                            }}>
                                <div>
                                    <label style={{
                                        display: 'block',
                                        fontSize: '12px',
                                        color: '#64748b',
                                        marginBottom: '4px'
                                    }}>
                                        Nome do Pacote
                                    </label>
                                    <input
                                        type="text"
                                        value={pkg.name}
                                        onChange={(e) => handleUpdatePackage(pkg.id, 'name', e.target.value)}
                                        style={{
                                            width: '100%',
                                            padding: '8px 12px',
                                            background: '#1a1f2e',
                                            border: '1px solid #334155',
                                            borderRadius: '6px',
                                            color: '#fff',
                                            fontSize: '14px'
                                        }}
                                    />
                                </div>
                                <div>
                                    <label style={{
                                        display: 'block',
                                        fontSize: '12px',
                                        color: '#64748b',
                                        marginBottom: '4px'
                                    }}>
                                        Créditos
                                    </label>
                                    <input
                                        type="number"
                                        value={pkg.credits}
                                        onChange={(e) => handleUpdatePackage(pkg.id, 'credits', parseInt(e.target.value))}
                                        style={{
                                            width: '100%',
                                            padding: '8px 12px',
                                            background: '#1a1f2e',
                                            border: '1px solid #334155',
                                            borderRadius: '6px',
                                            color: '#fff',
                                            fontSize: '14px'
                                        }}
                                    />
                                </div>
                                <div>
                                    <label style={{
                                        display: 'block',
                                        fontSize: '12px',
                                        color: '#64748b',
                                        marginBottom: '4px'
                                    }}>
                                        Preço (R$) - Calculado Automaticamente
                                    </label>
                                    <input
                                        type="number"
                                        step="0.01"
                                        value={pkg.price}
                                        readOnly
                                        style={{
                                            width: '100%',
                                            padding: '8px 12px',
                                            background: '#0a0e14',
                                            border: '1px solid #1e293b',
                                            borderRadius: '6px',
                                            color: '#4ade80',
                                            fontSize: '14px',
                                            cursor: 'not-allowed',
                                            fontWeight: '600'
                                        }}
                                    />
                                </div>
                                <div>
                                    <label style={{
                                        display: 'block',
                                        fontSize: '12px',
                                        color: '#64748b',
                                        marginBottom: '4px'
                                    }}>
                                        Desconto (%)
                                    </label>
                                    <input
                                        type="number"
                                        min="0"
                                        max="100"
                                        value={pkg.discount_percentage}
                                        onChange={(e) => handleUpdatePackage(pkg.id, 'discount_percentage', parseInt(e.target.value) || 0)}
                                        style={{
                                            width: '100%',
                                            padding: '8px 12px',
                                            background: '#1a1f2e',
                                            border: '1px solid #334155',
                                            borderRadius: '6px',
                                            color: '#fff',
                                            fontSize: '14px'
                                        }}
                                    />
                                </div>
                                <div>
                                    <label style={{
                                        display: 'block',
                                        fontSize: '12px',
                                        color: '#64748b',
                                        marginBottom: '4px'
                                    }}>
                                        Bônus
                                    </label>
                                    <input
                                        type="number"
                                        value={pkg.bonus}
                                        onChange={(e) => handleUpdatePackage(pkg.id, 'bonus', parseInt(e.target.value))}
                                        style={{
                                            width: '100%',
                                            padding: '8px 12px',
                                            background: '#1a1f2e',
                                            border: '1px solid #334155',
                                            borderRadius: '6px',
                                            color: '#fff',
                                            fontSize: '14px'
                                        }}
                                    />
                                </div>
                            </div>

                            {/* Feature Fields */}
                            <div style={{
                                marginTop: '16px',
                                padding: '16px',
                                background: '#1a1f2e',
                                border: '1px solid #334155',
                                borderRadius: '8px'
                            }}>
                                <div style={{
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    color: '#fff',
                                    marginBottom: '12px'
                                }}>
                                    Features do Pacote
                                </div>
                                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                                    <div>
                                        <label style={{
                                            display: 'block',
                                            fontSize: '12px',
                                            color: '#64748b',
                                            marginBottom: '4px'
                                        }}>
                                            Feature 1
                                        </label>
                                        <input
                                            type="text"
                                            value={pkg.feature1}
                                            onChange={(e) => handleUpdatePackage(pkg.id, 'feature1', e.target.value)}
                                            placeholder="Ex: Feedback inteligente e detalhado"
                                            style={{
                                                width: '100%',
                                                padding: '8px 12px',
                                                background: '#0f1419',
                                                border: '1px solid #334155',
                                                borderRadius: '6px',
                                                color: '#fff',
                                                fontSize: '14px'
                                            }}
                                        />
                                    </div>
                                    <div>
                                        <label style={{
                                            display: 'block',
                                            fontSize: '12px',
                                            color: '#64748b',
                                            marginBottom: '4px'
                                        }}>
                                            Feature 2
                                        </label>
                                        <input
                                            type="text"
                                            value={pkg.feature2}
                                            onChange={(e) => handleUpdatePackage(pkg.id, 'feature2', e.target.value)}
                                            placeholder="Ex: Correção Imediata"
                                            style={{
                                                width: '100%',
                                                padding: '8px 12px',
                                                background: '#0f1419',
                                                border: '1px solid #334155',
                                                borderRadius: '6px',
                                                color: '#fff',
                                                fontSize: '14px'
                                            }}
                                        />
                                    </div>
                                    <div>
                                        <label style={{
                                            display: 'block',
                                            fontSize: '12px',
                                            color: '#64748b',
                                            marginBottom: '4px'
                                        }}>
                                            Feature 3
                                        </label>
                                        <input
                                            type="text"
                                            value={pkg.feature3}
                                            onChange={(e) => handleUpdatePackage(pkg.id, 'feature3', e.target.value)}
                                            placeholder="Ex: Créditos vitalícios"
                                            style={{
                                                width: '100%',
                                                padding: '8px 12px',
                                                background: '#0f1419',
                                                border: '1px solid #334155',
                                                borderRadius: '6px',
                                                color: '#fff',
                                                fontSize: '14px'
                                            }}
                                        />
                                    </div>
                                    <div>
                                        <label style={{
                                            display: 'block',
                                            fontSize: '12px',
                                            color: '#64748b',
                                            marginBottom: '4px'
                                        }}>
                                            Feature 4
                                        </label>
                                        <input
                                            type="text"
                                            value={pkg.feature4}
                                            onChange={(e) => handleUpdatePackage(pkg.id, 'feature4', e.target.value)}
                                            placeholder="Ex: 1 Crédito Bônus"
                                            style={{
                                                width: '100%',
                                                padding: '8px 12px',
                                                background: '#0f1419',
                                                border: '1px solid #334155',
                                                borderRadius: '6px',
                                                color: '#fff',
                                                fontSize: '14px'
                                            }}
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>

            {/* Feature Flags */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Feature Flags
                </h2>

                <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    padding: '16px',
                    background: '#0f1419',
                    borderRadius: '8px'
                }}>
                    <div>
                        <div style={{
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '4px'
                        }}>
                            Modo de Manutenção
                        </div>
                        <div style={{
                            fontSize: '12px',
                            color: '#64748b'
                        }}>
                            Desabilita o acesso de usuários ao sistema
                        </div>
                    </div>
                    <label style={{
                        position: 'relative',
                        display: 'inline-block',
                        width: '60px',
                        height: '34px'
                    }}>
                        <input
                            type="checkbox"
                            checked={settings.maintenanceMode}
                            onChange={(e) => setSettings({ ...settings, maintenanceMode: e.target.checked })}
                            style={{ opacity: 0, width: 0, height: 0 }}
                        />
                        <span style={{
                            position: 'absolute',
                            cursor: 'pointer',
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            background: settings.maintenanceMode ? '#ef4444' : '#334155',
                            borderRadius: '34px',
                            transition: '0.4s'
                        }}>
                            <span style={{
                                position: 'absolute',
                                content: '',
                                height: '26px',
                                width: '26px',
                                left: settings.maintenanceMode ? '30px' : '4px',
                                bottom: '4px',
                                background: '#fff',
                                borderRadius: '50%',
                                transition: '0.4s'
                            }} />
                        </span>
                    </label>
                </div>
            </div>
        </AdminLayout>
    );
};

export default Configuracoes;
