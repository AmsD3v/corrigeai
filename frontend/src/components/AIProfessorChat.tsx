import { useState, useEffect, useRef } from 'react';
import api from '../services/api';

interface Message {
    role: 'user' | 'assistant';
    content: string;
    timestamp: string;
}

interface AIProfessorChatProps {
    submissionId: string;
}

const AIProfessorChat = ({ submissionId }: AIProfessorChatProps) => {
    const [isOpen, setIsOpen] = useState(false);
    const [messages, setMessages] = useState<Message[]>([]);
    const [inputMessage, setInputMessage] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [messagesRemaining, setMessagesRemaining] = useState(10);
    const [isMobile, setIsMobile] = useState(false);
    const [historyLoaded, setHistoryLoaded] = useState(false);
    const messagesEndRef = useRef<HTMLDivElement>(null);

    // Detectar mobile
    useEffect(() => {
        const checkMobile = () => setIsMobile(window.innerWidth <= 768);
        checkMobile();
        window.addEventListener('resize', checkMobile);
        return () => window.removeEventListener('resize', checkMobile);
    }, []);

    // Auto-scroll to bottom
    useEffect(() => {
        messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, [messages]);

    // Load chat history when opened
    useEffect(() => {
        if (isOpen && !historyLoaded) {
            loadChatHistory();
        }
    }, [isOpen]);

    const loadChatHistory = async () => {
        try {
            const response = await api.get(`/ai-tutor/history/${submissionId}`);
            setMessages(response.data.messages || []);
            setMessagesRemaining(response.data.messages_remaining || 10);
            setHistoryLoaded(true);
        } catch (error) {
            console.error('Erro ao carregar histórico:', error);
            setHistoryLoaded(true); // Mark as loaded even on error to prevent retry loop
        }
    };


    const sendMessage = async () => {
        if (!inputMessage.trim() || isLoading) return;

        const userMessage = inputMessage.trim();
        setInputMessage('');
        setIsLoading(true);

        try {
            const response = await api.post(`/ai-tutor/chat/${submissionId}`, {
                message: userMessage
            });

            setMessages(response.data.messages);
            setMessagesRemaining(response.data.messages_remaining);
        } catch (error: any) {
            alert(error.response?.data?.detail || 'Erro ao enviar mensagem');
        } finally {
            setIsLoading(false);
        }
    };

    if (!isOpen) {
        return (
            <button
                onClick={() => setIsOpen(true)}
                style={{
                    position: 'fixed',
                    bottom: isMobile ? '16px' : '24px',
                    right: isMobile ? '16px' : '24px',
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    color: 'white',
                    border: 'none',
                    borderRadius: isMobile ? '50%' : '50px',
                    padding: isMobile ? '14px' : '14px 24px',
                    width: isMobile ? '56px' : 'auto',
                    height: isMobile ? '56px' : 'auto',
                    fontSize: '14px',
                    fontWeight: '600',
                    cursor: 'pointer',
                    boxShadow: '0 8px 20px rgba(79, 70, 229, 0.4)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: isMobile ? '0' : '10px',
                    zIndex: 1000,
                    transition: 'all 0.3s ease'
                }}
                onMouseEnter={(e) => {
                    e.currentTarget.style.transform = 'scale(1.05)';
                    e.currentTarget.style.boxShadow = '0 12px 28px rgba(79, 70, 229, 0.5)';
                }}
                onMouseLeave={(e) => {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.boxShadow = '0 8px 20px rgba(79, 70, 229, 0.4)';
                }}
            >
                <span style={{ fontSize: isMobile ? '24px' : '20px' }}>🎓</span>
                {!isMobile && 'Professor IA precisa de ajuda?'}
            </button>
        );
    }

    return (
        <div style={{
            position: 'fixed',
            bottom: isMobile ? '0' : '24px',
            right: isMobile ? '0' : '24px',
            left: isMobile ? '0' : 'auto',
            top: isMobile ? '0' : 'auto',
            width: isMobile ? '100%' : '400px',
            height: isMobile ? '100%' : '600px',
            maxWidth: isMobile ? '100vw' : '400px',
            background: '#1a1f2e',
            border: isMobile ? 'none' : '1px solid #334155',
            borderRadius: isMobile ? '0' : '16px',
            boxShadow: isMobile ? 'none' : '0 20px 60px rgba(0, 0, 0, 0.5)',
            display: 'flex',
            flexDirection: 'column',
            zIndex: 1000,
            overflow: 'hidden'
        }}>
            {/* Header */}
            <div style={{
                background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                padding: '16px 20px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center'
            }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{
                        width: '40px',
                        height: '40px',
                        background: 'white',
                        borderRadius: '50%',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        fontSize: '20px'
                    }}>
                        🎓
                    </div>
                    <div>
                        <div style={{ fontWeight: '700', color: 'white', fontSize: '16px' }}>
                            Prof. Redi
                        </div>
                        <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.8)' }}>
                            Assistente de redação
                        </div>
                    </div>
                </div>
                <button
                    onClick={() => setIsOpen(false)}
                    style={{
                        background: 'rgba(255,255,255,0.2)',
                        border: 'none',
                        borderRadius: '8px',
                        color: 'white',
                        cursor: 'pointer',
                        padding: '8px 12px',
                        fontSize: '18px',
                        fontWeight: '700'
                    }}
                >
                    ×
                </button>
            </div>

            {/* Messages */}
            <div style={{
                flex: 1,
                overflowY: 'auto',
                padding: '20px',
                display: 'flex',
                flexDirection: 'column',
                gap: '16px'
            }}>
                {/* Welcome message - always shown first */}
                <div style={{
                    display: 'flex',
                    justifyContent: 'flex-start'
                }}>
                    <div style={{
                        maxWidth: '80%',
                        padding: '12px 16px',
                        borderRadius: '12px',
                        background: '#334155',
                        color: 'white',
                        fontSize: '14px',
                        lineHeight: '1.6'
                    }}>
                        Olá! 🙋‍♂️ Seja bem-vindo! Estou aqui para ajudá-lo a entender melhor sua correção de redação.
                        Qual é o seu objetivo? Quer saber como melhorar sua nota ou entender melhor os critérios de avaliação? 📝 Vamos começar!
                    </div>
                </div>

                {/* User and AI messages */}
                {messages.map((msg, idx) => (
                    <div
                        key={idx}
                        style={{
                            display: 'flex',
                            justifyContent: msg.role === 'user' ? 'flex-end' : 'flex-start'
                        }}
                    >
                        <div style={{
                            maxWidth: '80%',
                            padding: '12px 16px',
                            borderRadius: '12px',
                            background: msg.role === 'user'
                                ? 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)'
                                : '#334155',
                            color: 'white',
                            fontSize: '14px',
                            lineHeight: '1.6',
                            whiteSpace: 'pre-wrap'
                        }}>
                            {msg.content}
                        </div>
                    </div>
                ))}
                {isLoading && (
                    <div style={{
                        display: 'flex',
                        justifyContent: 'flex-start'
                    }}>
                        <div style={{
                            padding: '12px 16px',
                            borderRadius: '12px',
                            background: '#334155',
                            color: '#94a3b8',
                            fontSize: '14px'
                        }}>
                            Digitando...
                        </div>
                    </div>
                )}
                <div ref={messagesEndRef} />
            </div>

            {/* Input */}
            <div style={{
                padding: '16px 20px',
                borderTop: '1px solid #334155',
                background: '#0f1419'
            }}>
                <div style={{
                    fontSize: '11px',
                    color: '#64748b',
                    marginBottom: '8px',
                    textAlign: 'center'
                }}>
                    Mensagens restantes: {messagesRemaining} de 10
                </div>
                <div style={{ display: 'flex', gap: '8px' }}>
                    <input
                        type="text"
                        value={inputMessage}
                        onChange={(e) => setInputMessage(e.target.value)}
                        onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
                        placeholder="Digite sua mensagem..."
                        disabled={isLoading || messagesRemaining === 0}
                        style={{
                            flex: 1,
                            padding: '12px',
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: 'white',
                            fontSize: '14px',
                            outline: 'none'
                        }}
                    />
                    <button
                        onClick={sendMessage}
                        disabled={!inputMessage.trim() || isLoading || messagesRemaining === 0}
                        style={{
                            padding: '12px 20px',
                            background: inputMessage.trim() && !isLoading && messagesRemaining > 0
                                ? 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)'
                                : '#334155',
                            border: 'none',
                            borderRadius: '8px',
                            color: 'white',
                            cursor: inputMessage.trim() && !isLoading && messagesRemaining > 0 ? 'pointer' : 'not-allowed',
                            fontSize: '16px'
                        }}
                    >
                        ➤
                    </button>
                </div>
            </div>
        </div>
    );
};

export default AIProfessorChat;
