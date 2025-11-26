import { useState, useEffect } from 'react';
import PanelLayout from '../../components/PanelLayout';
import api from '../../services/api';

const ComprarCreditos = () => {
    const [purchasingId, setPurchasingId] = useState<string | null>(null);
    const [packages, setPackages] = useState<any[]>([]);
    const [isFetching, setIsFetching] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        fetchPackages();
    }, []);

    const fetchPackages = async () => {
        try {
            setIsFetching(true);
            const response = await api.get('/api/packages');

            if (!Array.isArray(response.data)) {
                console.error('Invalid response format:', response.data);
                setError('Erro ao carregar pacotes. Formato de resposta inválido.');
                return;
            }

            const mappedPackages = response.data.map((pkg: any) => {
                // Build features array from individual feature fields
                const features = [];
                if (pkg.feature1) features.push(pkg.feature1);
                if (pkg.feature2) features.push(pkg.feature2);
                if (pkg.feature3) features.push(pkg.feature3);
                if (pkg.feature4) features.push(pkg.feature4);

                // Calculate original price from discount percentage
                const finalPrice = pkg.price / 100; // Convert cents to reais
                const discountPercent = pkg.discount_percentage || 0;
                const originalPrice = discountPercent > 0
                    ? finalPrice / (1 - discountPercent / 100)
                    : finalPrice * 1.2; // Fallback to 20% markup if no discount

                return {
                    id: pkg.id,
                    name: `Pacote de ${pkg.credits} Créditos`, // Dynamic name based on credits
                    credits: pkg.credits,
                    originalPrice: originalPrice,
                    price: finalPrice,
                    discount: pkg.discount_text || (discountPercent > 0 ? `${discountPercent}% OFF!` : null),
                    discountPercentage: discountPercent,
                    pricePerCredit: finalPrice / pkg.credits,
                    popular: pkg.is_popular,
                    bonus: pkg.bonus || 0,
                    features: features
                };
            });
            setPackages(mappedPackages);
        } catch (error) {
            console.error('Error fetching packages:', error);
            setError('Não foi possível carregar os pacotes. Tente novamente mais tarde.');
        } finally {
            setIsFetching(false);
        }
    };

    const handlePurchase = async (pkg: any) => {
        try {
            console.log('🛒 Iniciando compra:', pkg);
            setPurchasingId(pkg.id);

            // Create payment preference
            console.log('📡 Enviando requisição para:', '/api/payment/create-preference');
            const response = await api.post('/api/payment/create-preference', {
                package_id: pkg.id
            });

            console.log('✅ Resposta recebida:', response.data);

            if (response.data.success && response.data.init_point) {
                // Redirect to Mercado Pago checkout
                window.location.href = response.data.init_point;
            } else {
                alert('Erro ao criar pagamento. Tente novamente.');
                setPurchasingId(null);
            }
        } catch (error: any) {
            console.error('Error creating payment:', error);

            // Handle authentication errors
            if (error.response?.status === 401) {
                alert('Sua sessão expirou. Por favor, faça login novamente.');
                // Clear token and redirect to login
                localStorage.removeItem('token');
                window.location.href = '/login';
                return;
            }

            alert(error.response?.data?.detail || 'Erro ao processar pagamento. Tente novamente.');
            setPurchasingId(null);
        }
    };

    return (
        <PanelLayout activePage="/painel/comprar-creditos">
            {/* Header */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                marginBottom: '32px',
                textAlign: 'center'
            }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '12px'
                }}>
                    Comprar Créditos 🪙
                </h1>
                <p style={{
                    fontSize: '16px',
                    color: '#94a3b8',
                    maxWidth: '900px',
                    margin: '0 auto'
                }}>
                    Escolha o pacote ideal para você e continue corrigindo suas redações com nossa IA avançada!
                </p>
            </div>

            {/* Loading State */}
            {isFetching && (
                <div style={{ textAlign: 'center', padding: '40px', color: '#94a3b8' }}>
                    <p>Carregando pacotes...</p>
                </div>
            )}

            {/* Error State */}
            {error && (
                <div style={{
                    textAlign: 'center',
                    padding: '20px',
                    color: '#ef4444',
                    background: 'rgba(239, 68, 68, 0.1)',
                    borderRadius: '8px',
                    marginBottom: '20px'
                }}>
                    <p>{error}</p>
                    <button
                        onClick={fetchPackages}
                        style={{
                            marginTop: '10px',
                            background: 'transparent',
                            border: '1px solid #ef4444',
                            color: '#ef4444',
                            padding: '8px 16px',
                            borderRadius: '4px',
                            cursor: 'pointer'
                        }}
                    >
                        Tentar Novamente
                    </button>
                </div>
            )}

            {/* Packages Grid */}
            {!isFetching && !error && (
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                    gap: '24px',
                    marginBottom: '32px',
                    maxWidth: '1000px',
                    margin: '0 auto'
                }}>
                    {packages.map((pkg) => (
                        <div
                            key={pkg.id}
                            style={{
                                background: '#2d3748',
                                border: pkg.popular ? '2px solid #4299e1' : '1px solid #4a5568',
                                borderRadius: '12px',
                                padding: '24px',
                                position: 'relative',
                                transition: 'all 0.3s'
                            }}
                        >
                            {/* Discount Badge */}
                            {pkg.discount && (
                                <div style={{
                                    position: 'absolute',
                                    top: '12px',
                                    right: '12px',
                                    background: '#4299e1',
                                    padding: '4px 12px',
                                    borderRadius: '6px',
                                    fontSize: '12px',
                                    fontWeight: '700',
                                    color: '#fff'
                                }}>
                                    {pkg.discount}
                                </div>
                            )}

                            {/* Package Name */}
                            <div style={{
                                fontSize: '18px',
                                fontWeight: '600',
                                color: '#fff',
                                marginBottom: '16px',
                                marginTop: pkg.discount ? '20px' : '0'
                            }}>
                                {pkg.name}
                            </div>

                            {/* Original Price (strikethrough) */}
                            <div style={{
                                fontSize: '14px',
                                color: '#718096',
                                textDecoration: 'line-through',
                                marginBottom: '4px'
                            }}>
                                R$ {pkg.originalPrice.toFixed(2).replace('.', ',')}
                            </div>

                            {/* Current Price */}
                            <div style={{
                                fontSize: '36px',
                                fontWeight: '800',
                                color: '#4299e1',
                                marginBottom: '16px'
                            }}>
                                R$ {pkg.price.toFixed(2).replace('.', ',')}
                            </div>

                            {/* Features */}
                            <div style={{
                                marginBottom: '20px'
                            }}>
                                {pkg.features.map((feature: string, index: number) => (
                                    <div
                                        key={index}
                                        style={{
                                            display: 'flex',
                                            alignItems: 'center',
                                            gap: '8px',
                                            marginBottom: '8px',
                                            fontSize: '14px',
                                            color: '#cbd5e0'
                                        }}
                                    >
                                        <span style={{ color: '#48bb78' }}>✓</span>
                                        <span>{feature}</span>
                                    </div>
                                ))}
                            </div>

                            {/* Price per credit */}
                            <div style={{
                                fontSize: '13px',
                                color: '#a0aec0',
                                marginBottom: '16px',
                                textAlign: 'center'
                            }}>
                                ({pkg.credits} RedaCoins - R$ {pkg.pricePerCredit.toFixed(2)}/crédito)
                            </div>

                            {/* Buy Button */}
                            <button
                                onClick={() => handlePurchase(pkg)}
                                disabled={purchasingId === pkg.id}
                                style={{
                                    width: '100%',
                                    padding: '12px',
                                    background: '#4299e1',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '15px',
                                    fontWeight: '600',
                                    cursor: purchasingId === pkg.id ? 'not-allowed' : 'pointer',
                                    transition: 'all 0.2s',
                                    opacity: purchasingId === pkg.id ? 0.7 : 1
                                }}
                                onMouseEnter={(e) => {
                                    if (purchasingId !== pkg.id) {
                                        e.currentTarget.style.background = '#3182ce';
                                    }
                                }}
                                onMouseLeave={(e) => {
                                    e.currentTarget.style.background = '#4299e1';
                                }}
                            >
                                {purchasingId === pkg.id ? 'Processando...' : 'Comprar Agora'}
                            </button>
                        </div>
                    ))}
                </div>
            )}

            {/* Info Section */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                maxWidth: '800px',
                margin: '0 auto',
                marginTop: '20px'
            }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                    <div>
                        <div style={{
                            fontSize: '16px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            💳 Formas de Pagamento
                        </div>
                        <div style={{
                            fontSize: '14px',
                            color: '#94a3b8',
                            lineHeight: '1.6'
                        }}>
                            Aceitamos PIX, Cartão de Crédito, Cartão de Débito e Boleto através do Mercado Pago.
                        </div>
                    </div>

                    <div>
                        <div style={{
                            fontSize: '16px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            ⏱️ Processamento
                        </div>
                        <div style={{
                            fontSize: '14px',
                            color: '#94a3b8',
                            lineHeight: '1.6'
                        }}>
                            PIX: Instantâneo | Cartão: Até 2 minutos | Boleto: Até 2 dias úteis
                        </div>
                    </div>

                    <div>
                        <div style={{
                            fontSize: '16px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            ♾️ Créditos Vitalícios
                        </div>
                        <div style={{
                            fontSize: '14px',
                            color: '#94a3b8',
                            lineHeight: '1.6'
                        }}>
                            Seus créditos nunca expiram! Use quando quiser, sem prazo de validade.
                        </div>
                    </div>

                    <div>
                        <div style={{
                            fontSize: '16px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            🔒 Segurança
                        </div>
                        <div style={{
                            fontSize: '14px',
                            color: '#94a3b8',
                            lineHeight: '1.6'
                        }}>
                            Pagamento 100% seguro processado pelo Mercado Pago.
                        </div>
                    </div>
                </div>
            </div>
        </PanelLayout>
    );
};

import ErrorBoundary from '../../components/ErrorBoundary';

export default function ComprarCreditosWrapper() {
    return (
        <ErrorBoundary>
            <ComprarCreditos />
        </ErrorBoundary>
    );
}
