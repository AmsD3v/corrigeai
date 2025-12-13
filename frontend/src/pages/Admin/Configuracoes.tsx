import { useState, useEffect } from 'react';
import api from '../../services/api';
import AdminLayout from '../../components/AdminLayout';
import ToggleSwitch from '../../components/ToggleSwitch';

interface Settings {
    siteName: string;
    contactEmail: string;
    supportEmail: string;
    // Provedores por função
    correctionProvider: string;
    imageProvider: string;
    tutorProvider: string;
    themeProvider: string;
    // Chaves API por função (separadas)
    correctionApiKey: string;
    imageApiKey: string;
    tutorApiKey: string;
    themeApiKey: string;
    premiumGeminiApiKey: string;  // Chave Gemini extra para Premium
    premiumProvider: string;  // Provedor para segunda correção Premium
    fallbackProvider: string;  // Fallback quando provedor principal falhar
    fallbackApiKey: string;
    // Outros
    maintenanceMode: boolean;
    creditValue: number;
    lessonCooldownHours: number;
    lessonRepeatXpPercent: number;
    packages: {
        id: string;
        name: string;
        credits: number;
        price: number;
        discount_percentage: number;
        discount_text: string | null;
        bonus: number;
        is_active: boolean;
        is_popular: boolean;
        feature1: string;
        feature2: string;
        feature3: string;
        feature4: string;
    }[];
}

interface ApiKeyErrors {
    correction?: string;
    image?: string;
    tutor?: string;
    theme?: string;
    premium?: string;
    fallback?: string;
}

const Configuracoes = () => {
    const [settings, setSettings] = useState<Settings>({
        siteName: 'CorrigeAI',
        contactEmail: 'contato@corrigeai.com',
        supportEmail: 'suporte@corrigeai.com',
        // Provedores por função
        correctionProvider: 'groq',
        imageProvider: 'huggingface',
        tutorProvider: 'groq',
        themeProvider: 'groq',
        // Chaves API por função
        correctionApiKey: '',
        imageApiKey: '',
        tutorApiKey: '',
        themeApiKey: '',
        premiumGeminiApiKey: '',
        premiumProvider: 'gemini',
        fallbackProvider: 'groq',
        fallbackApiKey: '',
        // Outros
        maintenanceMode: false,
        creditValue: 2.20,
        lessonCooldownHours: 168,
        lessonRepeatXpPercent: 50,
        packages: []
    });

    const [saved, setSaved] = useState(false);
    const [showApiKeys, setShowApiKeys] = useState<{ [key: string]: boolean }>({});
    const [apiKeyErrors, setApiKeyErrors] = useState<ApiKeyErrors>({});

    useEffect(() => {
        fetchSettings();
        fetchPackages();
    }, []);

    const fetchSettings = async () => {
        try {
            const response = await api.get('/api/settings');
            setSettings(prev => ({
                ...prev,
                correctionProvider: response.data.correction_provider || 'groq',
                imageProvider: response.data.image_provider || 'huggingface',
                tutorProvider: response.data.tutor_provider || 'groq',
                themeProvider: response.data.theme_provider || 'groq',
                correctionApiKey: response.data.correction_api_key || '',
                imageApiKey: response.data.image_api_key || '',
                tutorApiKey: response.data.tutor_api_key || '',
                themeApiKey: response.data.theme_api_key || '',
                premiumGeminiApiKey: response.data.premium_gemini_api_key || '',
                premiumProvider: response.data.premium_provider || 'gemini',
                fallbackProvider: response.data.fallback_provider || 'groq',
                fallbackApiKey: response.data.fallback_api_key || '',
                lessonCooldownHours: response.data.lesson_cooldown_hours ?? prev.lessonCooldownHours,
                lessonRepeatXpPercent: response.data.lesson_repeat_xp_percent ?? prev.lessonRepeatXpPercent
            }));
        } catch (error) {
            console.error('Error loading settings:', error);
        }
    };

    const fetchPackages = async () => {
        try {
            const response = await api.get('/api/packages/all');
            const apiPackages = response.data.map((pkg: any) => ({
                id: pkg.id,
                name: pkg.name,
                credits: pkg.credits,
                price: pkg.price / 100,
                discount_percentage: pkg.discount_percentage || 0,
                discount_text: pkg.discount_text || null,
                bonus: pkg.bonus,
                is_active: pkg.is_active !== undefined ? pkg.is_active : true,
                is_popular: pkg.is_popular || false,
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

    // Valida se a chave API corresponde ao provedor selecionado
    const validateApiKey = (provider: string, key: string): { valid: boolean; message: string } => {
        if (!key || key.trim() === '') {
            return { valid: false, message: 'Chave API não configurada' };
        }

        const keyLower = key.trim().toLowerCase();
        const keyOriginal = key.trim();

        switch (provider) {
            case 'gemini':
                if (!keyOriginal.startsWith('AIza')) {
                    return { valid: false, message: 'Chave Gemini deve começar com "AIza"' };
                }
                break;
            case 'groq':
                if (!keyLower.startsWith('gsk_')) {
                    return { valid: false, message: 'Chave Groq deve começar com "gsk_"' };
                }
                break;
            case 'huggingface':
                if (!keyLower.startsWith('hf_')) {
                    return { valid: false, message: 'Chave HuggingFace deve começar com "hf_"' };
                }
                break;
            case 'together':
                if (keyOriginal.startsWith('AIza') || keyLower.startsWith('gsk_') || keyLower.startsWith('hf_') || keyLower.startsWith('csk-')) {
                    return { valid: false, message: 'A chave parece ser de outro provedor' };
                }
                break;
            case 'cerebras':
                if (!keyLower.startsWith('csk-')) {
                    return { valid: false, message: 'Chave Cerebras deve começar com "csk-"' };
                }
                break;
        }

        return { valid: true, message: '' };
    };

    // Validação em tempo real para uma função específica
    const handleApiKeyChange = (functionName: 'correction' | 'image' | 'tutor' | 'theme' | 'premium' | 'fallback', value: string) => {
        const providerMap = {
            correction: settings.correctionProvider,
            image: settings.imageProvider,
            tutor: settings.tutorProvider,
            theme: settings.themeProvider,
            premium: settings.premiumProvider,
            fallback: settings.fallbackProvider
        };

        const keyMap = {
            correction: 'correctionApiKey' as const,
            image: 'imageApiKey' as const,
            tutor: 'tutorApiKey' as const,
            theme: 'themeApiKey' as const,
            premium: 'premiumGeminiApiKey' as const,
            fallback: 'fallbackApiKey' as const
        };

        setSettings(prev => ({ ...prev, [keyMap[functionName]]: value }));

        if (value && value.trim() !== '') {
            const validation = validateApiKey(providerMap[functionName], value);
            setApiKeyErrors(prev => ({ ...prev, [functionName]: validation.valid ? undefined : validation.message }));
        } else {
            setApiKeyErrors(prev => ({ ...prev, [functionName]: undefined }));
        }
    };

    const handleSaveSettings = async () => {
        try {
            // Validar chaves para cada função
            const validations = [
                { name: 'Correção', provider: settings.correctionProvider, key: settings.correctionApiKey, field: 'correction' },
                { name: 'Imagens', provider: settings.imageProvider, key: settings.imageApiKey, field: 'image' },
                { name: 'Tutor', provider: settings.tutorProvider, key: settings.tutorApiKey, field: 'tutor' },
                { name: 'Tema', provider: settings.themeProvider, key: settings.themeApiKey, field: 'theme' },
                { name: 'Premium', provider: settings.premiumProvider, key: settings.premiumGeminiApiKey, field: 'premium' },
                { name: 'Fallback', provider: settings.fallbackProvider, key: settings.fallbackApiKey, field: 'fallback' },
            ];

            const newErrors: ApiKeyErrors = {};
            for (const { name, provider, key, field } of validations) {
                const validation = validateApiKey(provider, key);
                if (!validation.valid) {
                    newErrors[field as keyof ApiKeyErrors] = validation.message;
                }
            }

            if (Object.keys(newErrors).length > 0) {
                setApiKeyErrors(newErrors);
                alert('⚠️ Corrija os erros de validação antes de salvar');
                return;
            }

            // Save AI providers and keys to API
            await api.post('/api/settings', {
                correction_provider: settings.correctionProvider,
                image_provider: settings.imageProvider,
                tutor_provider: settings.tutorProvider,
                theme_provider: settings.themeProvider,
                correction_api_key: settings.correctionApiKey,
                image_api_key: settings.imageApiKey,
                tutor_api_key: settings.tutorApiKey,
                theme_api_key: settings.themeApiKey,
                premium_gemini_api_key: settings.premiumGeminiApiKey,
                premium_provider: settings.premiumProvider,
                fallback_provider: settings.fallbackProvider,
                fallback_api_key: settings.fallbackApiKey,
                lesson_cooldown_hours: settings.lessonCooldownHours,
                lesson_repeat_xp_percent: settings.lessonRepeatXpPercent
            });

            // Save packages to API
            await Promise.all(settings.packages.map(pkg =>
                api.put(`/api/packages/${pkg.id}`, {
                    name: pkg.name,
                    credits: pkg.credits,
                    price: Math.round(pkg.price * 100),
                    discount_percentage: pkg.discount_percentage,
                    discount_text: pkg.discount_text,
                    bonus: pkg.bonus,
                    is_active: pkg.is_active,
                    is_popular: pkg.is_popular,
                    feature1: pkg.feature1,
                    feature2: pkg.feature2,
                    feature3: pkg.feature3,
                    feature4: pkg.feature4
                })
            ));

            setSaved(true);
            setTimeout(() => setSaved(false), 3000);
        } catch (error: any) {
            console.error('Error saving settings:', error);
            console.error('Error response:', error.response?.data);
            alert(`Erro ao salvar configurações: ${error.response?.data?.detail || error.message}`);
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

            {/* AI Settings - Provedores por Função */}
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
                    🤖 Configurações de IA
                </h2>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                    {/* Correção de Redações */}
                    <div style={{ background: '#0f1419', borderRadius: '10px', padding: '16px', border: `1px solid ${apiKeyErrors.correction ? '#ef4444' : '#334155'}` }}>
                        <label style={{ display: 'block', fontSize: '14px', color: '#fff', marginBottom: '10px', fontWeight: '600' }}>
                            📝 Correção de Redações
                        </label>
                        <select
                            value={settings.correctionProvider}
                            onChange={(e) => {
                                setSettings({ ...settings, correctionProvider: e.target.value });
                                // Revalidar quando trocar provedor
                                if (settings.correctionApiKey) {
                                    const validation = validateApiKey(e.target.value, settings.correctionApiKey);
                                    setApiKeyErrors(prev => ({ ...prev, correction: validation.valid ? undefined : validation.message }));
                                }
                            }}
                            style={{ width: '100%', padding: '10px 14px', background: '#1a1f2e', border: '1px solid #334155', borderRadius: '6px', color: '#fff', fontSize: '13px', cursor: 'pointer', marginBottom: '10px' }}
                        >
                            <option value="gemini">🟢 Google Gemini</option>
                            <option value="groq">⚡ Groq (Recomendado)</option>
                            <option value="cerebras">🧠 Cerebras</option>
                            <option value="huggingface">🤗 HuggingFace</option>
                            <option value="together">🔷 Together AI</option>
                        </select>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showApiKeys['correction'] ? 'text' : 'password'}
                                value={settings.correctionApiKey}
                                onChange={(e) => handleApiKeyChange('correction', e.target.value)}
                                placeholder="Chave API..."
                                style={{ width: '100%', padding: '10px 36px 10px 10px', background: apiKeyErrors.correction ? '#1a0f0f' : '#1a1f2e', border: `1px solid ${apiKeyErrors.correction ? '#ef4444' : '#334155'}`, borderRadius: '6px', color: apiKeyErrors.correction ? '#ef4444' : '#94a3b8', fontSize: '12px', fontFamily: 'monospace' }}
                            />
                            <button
                                type="button"
                                onClick={() => setShowApiKeys(prev => ({ ...prev, correction: !prev.correction }))}
                                style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'transparent', border: 'none', cursor: 'pointer', fontSize: '14px', color: '#64748b' }}
                            >
                                {showApiKeys['correction'] ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {apiKeyErrors.correction && <p style={{ fontSize: '11px', color: '#ef4444', marginTop: '6px' }}>⚠️ {apiKeyErrors.correction}</p>}
                    </div>

                    {/* Segunda Correção Premium */}
                    <div style={{ background: '#0f1419', borderRadius: '10px', padding: '16px', border: '1px solid #a855f7' }}>
                        <label style={{ display: 'block', fontSize: '14px', color: '#fff', marginBottom: '10px', fontWeight: '600' }}>
                            💎 Segunda Correção (Premium)
                        </label>
                        <p style={{ fontSize: '11px', color: '#64748b', marginBottom: '10px' }}>
                            Configure o segundo corretor para o modo Premium (dupla correção).
                        </p>
                        <select
                            value={settings.premiumProvider || 'gemini'}
                            onChange={(e) => {
                                setSettings({ ...settings, premiumProvider: e.target.value });
                                // Revalidar quando trocar provedor
                                if (settings.premiumGeminiApiKey) {
                                    const validation = validateApiKey(e.target.value, settings.premiumGeminiApiKey);
                                    setApiKeyErrors(prev => ({ ...prev, premium: validation.valid ? undefined : validation.message }));
                                }
                            }}
                            style={{ width: '100%', padding: '10px 14px', background: '#1a1f2e', border: '1px solid #a855f7', borderRadius: '6px', color: '#fff', fontSize: '13px', cursor: 'pointer', marginBottom: '10px' }}
                        >
                            <option value="gemini">🟢 Google Gemini</option>
                            <option value="groq">⚡ Groq</option>
                            <option value="cerebras">🧠 Cerebras</option>
                            <option value="huggingface">🤗 HuggingFace</option>
                            <option value="together">🔷 Together AI</option>
                        </select>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showApiKeys['premiumGemini'] ? 'text' : 'password'}
                                value={settings.premiumGeminiApiKey}
                                onChange={(e) => handleApiKeyChange('premium', e.target.value)}
                                placeholder="Chave API..."
                                style={{ width: '100%', padding: '10px 36px 10px 10px', background: apiKeyErrors.premium ? '#1a0f0f' : '#1a1f2e', border: `1px solid ${apiKeyErrors.premium ? '#ef4444' : '#a855f7'}`, borderRadius: '6px', color: apiKeyErrors.premium ? '#ef4444' : '#94a3b8', fontSize: '12px', fontFamily: 'monospace' }}
                            />
                            <button
                                type="button"
                                onClick={() => setShowApiKeys(prev => ({ ...prev, premiumGemini: !prev.premiumGemini }))}
                                style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'transparent', border: 'none', cursor: 'pointer', fontSize: '14px', color: '#64748b' }}
                            >
                                {showApiKeys['premiumGemini'] ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {apiKeyErrors.premium && <p style={{ fontSize: '11px', color: '#ef4444', marginTop: '6px' }}>⚠️ {apiKeyErrors.premium}</p>}
                    </div>

                    {/* Fallback Provider */}
                    <div style={{ background: '#0f1419', borderRadius: '10px', padding: '16px', border: '1px solid #f59e0b' }}>
                        <label style={{ display: 'block', fontSize: '14px', color: '#fff', marginBottom: '10px', fontWeight: '600' }}>
                            🔄 Fallback (Quando o provedor falhar)
                        </label>
                        <p style={{ fontSize: '11px', color: '#64748b', marginBottom: '10px' }}>
                            Provedor usado quando o principal ou Premium falhar.
                        </p>
                        <select
                            value={settings.fallbackProvider || 'groq'}
                            onChange={(e) => {
                                setSettings({ ...settings, fallbackProvider: e.target.value });
                                // Revalidar quando trocar provedor
                                if (settings.fallbackApiKey) {
                                    const validation = validateApiKey(e.target.value, settings.fallbackApiKey);
                                    setApiKeyErrors(prev => ({ ...prev, fallback: validation.valid ? undefined : validation.message }));
                                }
                            }}
                            style={{ width: '100%', padding: '10px 14px', background: '#1a1f2e', border: '1px solid #f59e0b', borderRadius: '6px', color: '#fff', fontSize: '13px', cursor: 'pointer', marginBottom: '10px' }}
                        >
                            <option value="gemini">🟢 Google Gemini</option>
                            <option value="groq">⚡ Groq (Recomendado)</option>
                            <option value="cerebras">🧠 Cerebras</option>
                            <option value="huggingface">🤗 HuggingFace</option>
                            <option value="together">🔷 Together AI</option>
                        </select>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showApiKeys['fallback'] ? 'text' : 'password'}
                                value={settings.fallbackApiKey}
                                onChange={(e) => handleApiKeyChange('fallback', e.target.value)}
                                placeholder="Chave API de fallback..."
                                style={{ width: '100%', padding: '10px 36px 10px 10px', background: apiKeyErrors.fallback ? '#1a0f0f' : '#1a1f2e', border: `1px solid ${apiKeyErrors.fallback ? '#ef4444' : '#f59e0b'}`, borderRadius: '6px', color: apiKeyErrors.fallback ? '#ef4444' : '#94a3b8', fontSize: '12px', fontFamily: 'monospace' }}
                            />
                            <button
                                type="button"
                                onClick={() => setShowApiKeys(prev => ({ ...prev, fallback: !prev.fallback }))}
                                style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'transparent', border: 'none', cursor: 'pointer', fontSize: '14px', color: '#64748b' }}
                            >
                                {showApiKeys['fallback'] ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {apiKeyErrors.fallback && <p style={{ fontSize: '11px', color: '#ef4444', marginTop: '6px' }}>⚠️ {apiKeyErrors.fallback}</p>}
                    </div>

                    {/* Geração de Imagens */}
                    <div style={{ background: '#0f1419', borderRadius: '10px', padding: '16px', border: `1px solid ${apiKeyErrors.image ? '#ef4444' : '#334155'}` }}>
                        <label style={{ display: 'block', fontSize: '14px', color: '#fff', marginBottom: '10px', fontWeight: '600' }}>
                            🖼️ Geração de Imagens (Blog)
                        </label>
                        <select
                            value={settings.imageProvider}
                            onChange={(e) => setSettings({ ...settings, imageProvider: e.target.value })}
                            style={{ width: '100%', padding: '10px 14px', background: '#1a1f2e', border: '1px solid #334155', borderRadius: '6px', color: '#fff', fontSize: '13px', cursor: 'pointer', marginBottom: '10px' }}
                        >
                            <option value="huggingface">🤗 HuggingFace (Stable Diffusion)</option>
                        </select>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showApiKeys['image'] ? 'text' : 'password'}
                                value={settings.imageApiKey}
                                onChange={(e) => handleApiKeyChange('image', e.target.value)}
                                placeholder="Chave API..."
                                style={{ width: '100%', padding: '10px 36px 10px 10px', background: apiKeyErrors.image ? '#1a0f0f' : '#1a1f2e', border: `1px solid ${apiKeyErrors.image ? '#ef4444' : '#334155'}`, borderRadius: '6px', color: apiKeyErrors.image ? '#ef4444' : '#94a3b8', fontSize: '12px', fontFamily: 'monospace' }}
                            />
                            <button
                                type="button"
                                onClick={() => setShowApiKeys(prev => ({ ...prev, image: !prev.image }))}
                                style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'transparent', border: 'none', cursor: 'pointer', fontSize: '14px', color: '#64748b' }}
                            >
                                {showApiKeys['image'] ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {apiKeyErrors.image && <p style={{ fontSize: '11px', color: '#ef4444', marginTop: '6px' }}>⚠️ {apiKeyErrors.image}</p>}
                    </div>

                    {/* Tutor IA */}
                    <div style={{ background: '#0f1419', borderRadius: '10px', padding: '16px', border: `1px solid ${apiKeyErrors.tutor ? '#ef4444' : '#334155'}` }}>
                        <label style={{ display: 'block', fontSize: '14px', color: '#fff', marginBottom: '10px', fontWeight: '600' }}>
                            👨‍🏫 Tutor IA (Chat)
                        </label>
                        <select
                            value={settings.tutorProvider}
                            onChange={(e) => {
                                setSettings({ ...settings, tutorProvider: e.target.value });
                                if (settings.tutorApiKey) {
                                    const validation = validateApiKey(e.target.value, settings.tutorApiKey);
                                    setApiKeyErrors(prev => ({ ...prev, tutor: validation.valid ? undefined : validation.message }));
                                }
                            }}
                            style={{ width: '100%', padding: '10px 14px', background: '#1a1f2e', border: '1px solid #334155', borderRadius: '6px', color: '#fff', fontSize: '13px', cursor: 'pointer', marginBottom: '10px' }}
                        >
                            <option value="gemini">🟢 Google Gemini</option>
                            <option value="groq">⚡ Groq (Recomendado)</option>
                            <option value="huggingface">🤗 HuggingFace</option>
                            <option value="together">🔷 Together AI</option>
                        </select>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showApiKeys['tutor'] ? 'text' : 'password'}
                                value={settings.tutorApiKey}
                                onChange={(e) => handleApiKeyChange('tutor', e.target.value)}
                                placeholder="Chave API..."
                                style={{ width: '100%', padding: '10px 36px 10px 10px', background: apiKeyErrors.tutor ? '#1a0f0f' : '#1a1f2e', border: `1px solid ${apiKeyErrors.tutor ? '#ef4444' : '#334155'}`, borderRadius: '6px', color: apiKeyErrors.tutor ? '#ef4444' : '#94a3b8', fontSize: '12px', fontFamily: 'monospace' }}
                            />
                            <button
                                type="button"
                                onClick={() => setShowApiKeys(prev => ({ ...prev, tutor: !prev.tutor }))}
                                style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'transparent', border: 'none', cursor: 'pointer', fontSize: '14px', color: '#64748b' }}
                            >
                                {showApiKeys['tutor'] ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {apiKeyErrors.tutor && <p style={{ fontSize: '11px', color: '#ef4444', marginTop: '6px' }}>⚠️ {apiKeyErrors.tutor}</p>}
                    </div>

                    {/* Geração de Tema */}
                    <div style={{ background: '#0f1419', borderRadius: '10px', padding: '16px', border: `1px solid ${apiKeyErrors.theme ? '#ef4444' : '#334155'}` }}>
                        <label style={{ display: 'block', fontSize: '14px', color: '#fff', marginBottom: '10px', fontWeight: '600' }}>
                            💡 Geração de Tema
                        </label>
                        <select
                            value={settings.themeProvider}
                            onChange={(e) => {
                                setSettings({ ...settings, themeProvider: e.target.value });
                                if (settings.themeApiKey) {
                                    const validation = validateApiKey(e.target.value, settings.themeApiKey);
                                    setApiKeyErrors(prev => ({ ...prev, theme: validation.valid ? undefined : validation.message }));
                                }
                            }}
                            style={{ width: '100%', padding: '10px 14px', background: '#1a1f2e', border: '1px solid #334155', borderRadius: '6px', color: '#fff', fontSize: '13px', cursor: 'pointer', marginBottom: '10px' }}
                        >
                            <option value="gemini">🟢 Google Gemini</option>
                            <option value="groq">⚡ Groq (Recomendado)</option>
                            <option value="huggingface">🤗 HuggingFace</option>
                            <option value="together">🔷 Together AI</option>
                        </select>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showApiKeys['theme'] ? 'text' : 'password'}
                                value={settings.themeApiKey}
                                onChange={(e) => handleApiKeyChange('theme', e.target.value)}
                                placeholder="Chave API..."
                                style={{ width: '100%', padding: '10px 36px 10px 10px', background: apiKeyErrors.theme ? '#1a0f0f' : '#1a1f2e', border: `1px solid ${apiKeyErrors.theme ? '#ef4444' : '#334155'}`, borderRadius: '6px', color: apiKeyErrors.theme ? '#ef4444' : '#94a3b8', fontSize: '12px', fontFamily: 'monospace' }}
                            />
                            <button
                                type="button"
                                onClick={() => setShowApiKeys(prev => ({ ...prev, theme: !prev.theme }))}
                                style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'transparent', border: 'none', cursor: 'pointer', fontSize: '14px', color: '#64748b' }}
                            >
                                {showApiKeys['theme'] ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {apiKeyErrors.theme && <p style={{ fontSize: '11px', color: '#ef4444', marginTop: '6px' }}>⚠️ {apiKeyErrors.theme}</p>}
                    </div>
                </div>
            </div>

            {/* Gamification Settings */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #a78bfa40',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px'
                }}>
                    🎮 Configurações de Gamificação
                </h2>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                    {/* Lesson Cooldown */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            ⏰ Tempo de Renovação das Lições (horas)
                        </label>
                        <input
                            type="number"
                            min="1"
                            value={settings.lessonCooldownHours}
                            onChange={(e) => {
                                const value = Math.max(1, parseInt(e.target.value) || 1);
                                setSettings(prev => ({ ...prev, lessonCooldownHours: value }));
                            }}
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
                        <p style={{
                            fontSize: '12px',
                            color: '#64748b',
                            marginTop: '8px'
                        }}>
                            Mínimo: 1 hora. Tempo até a lição estar disponível novamente após conclusão.
                            <br />
                            <span style={{ color: '#a78bfa' }}>
                                Atual: {settings.lessonCooldownHours}h = {Math.floor(settings.lessonCooldownHours / 24)} dias e {settings.lessonCooldownHours % 24}h
                            </span>
                        </p>
                    </div>

                    {/* Repeat XP Percent */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            ✨ XP ao Refazer Lição (%)
                        </label>
                        <input
                            type="number"
                            min="0"
                            max="100"
                            value={settings.lessonRepeatXpPercent}
                            onChange={(e) => {
                                const value = Math.max(0, Math.min(100, parseInt(e.target.value) || 0));
                                setSettings(prev => ({ ...prev, lessonRepeatXpPercent: value }));
                            }}
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
                        <p style={{
                            fontSize: '12px',
                            color: '#64748b',
                            marginTop: '8px'
                        }}>
                            Percentual do XP original ao refazer uma lição já concluída.
                            <br />
                            <span style={{ color: '#10b981' }}>
                                Ex: Lição de 100 XP → Repetição dá {settings.lessonRepeatXpPercent} XP
                            </span>
                        </p>
                    </div>
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
                                border: `1px solid ${pkg.is_active ? '#4ade80' : '#334155'}`,
                                borderRadius: '8px',
                                padding: '16px',
                                opacity: pkg.is_active ? 1 : 0.6
                            }}
                        >
                            {/* Toggle Header */}
                            <div style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                marginBottom: '16px',
                                paddingBottom: '12px',
                                borderBottom: '1px solid #334155'
                            }}>
                                <div style={{
                                    fontSize: '16px',
                                    fontWeight: '700',
                                    color: '#fff',
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '8px'
                                }}>
                                    {pkg.name}
                                    {pkg.is_popular && (
                                        <span style={{
                                            padding: '4px 8px',
                                            background: '#ef4444',
                                            borderRadius: '4px',
                                            fontSize: '11px',
                                            fontWeight: '700',
                                            color: '#fff'
                                        }}>
                                            POPULAR
                                        </span>
                                    )}
                                </div>
                                <ToggleSwitch
                                    enabled={pkg.is_active}
                                    onChange={(enabled) => handleUpdatePackage(pkg.id, 'is_active', enabled)}
                                    label={pkg.is_active ? 'Ativo' : 'Inativo'}
                                />
                            </div>

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
