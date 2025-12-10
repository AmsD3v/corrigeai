import React, { useState } from 'react';

interface PasswordInputProps {
    id: string;
    value: string;
    onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    placeholder?: string;
    required?: boolean;
    label?: string;
}

const PasswordInput: React.FC<PasswordInputProps> = ({
    id,
    value,
    onChange,
    placeholder = '••••••••',
    required = false,
    label
}) => {
    const [showPassword, setShowPassword] = useState(false);

    const handleToggle = () => {
        setShowPassword(prev => !prev);
    };

    return (
        <div>
            {label && (
                <label
                    htmlFor={id}
                    style={{
                        display: 'block',
                        color: '#fff',
                        fontWeight: 600,
                        marginBottom: '8px'
                    }}
                >
                    {label}
                </label>
            )}
            <div style={{ position: 'relative' }}>
                <input
                    type={showPassword ? 'text' : 'password'}
                    id={id}
                    placeholder={placeholder}
                    value={value}
                    onChange={onChange}
                    required={required}
                    className="w-full px-4 py-2 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                    style={{ paddingRight: '50px' }}
                />
                <div
                    onClick={handleToggle}
                    role="button"
                    tabIndex={0}
                    onKeyDown={(e) => e.key === 'Enter' && handleToggle()}
                    aria-label={showPassword ? 'Esconder senha' : 'Mostrar senha'}
                    style={{
                        position: 'absolute',
                        top: '50%',
                        right: '12px',
                        transform: 'translateY(-50%)',
                        cursor: 'pointer',
                        color: showPassword ? '#fff' : '#64748B',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        width: '24px',
                        height: '24px'
                    }}
                >
                    {showPassword ? (
                        <svg
                            width="20"
                            height="20"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            strokeWidth="1.5"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                        >
                            <path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19m-6.72-1.07a3 3 0 11-4.24-4.24" />
                            <line x1="1" y1="1" x2="23" y2="23" />
                        </svg>
                    ) : (
                        <svg
                            width="20"
                            height="20"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            strokeWidth="1.5"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                        >
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                            <circle cx="12" cy="12" r="3" />
                        </svg>
                    )}
                </div>
            </div>
        </div>
    );
};

export default PasswordInput;
