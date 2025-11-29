import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

type Theme = 'light' | 'dark';

interface ThemeContextType {
    theme: Theme;
    setTheme: (theme: Theme) => void;
    toggleTheme: () => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider = ({ children }: { children: ReactNode }) => {
    console.log('🎨 ThemeProvider montado!'); // <- DEBUG
    
    // Carrega tema do localStorage ou usa 'dark' como padrão
    const [theme, setThemeState] = useState<Theme>(() => {
        const saved = localStorage.getItem('corrigeai-theme');
        console.log('📦 Tema salvo no localStorage:', saved); // <- DEBUG
        return (saved as Theme) || 'dark';
    });

    // Salva no localStorage quando mudar
    useEffect(() => {
        console.log('💾 Salvando tema:', theme);
        localStorage.setItem('corrigeai-theme', theme);
        
        // Remove ambas as classes e adiciona apenas a correta
        document.documentElement.classList.remove('light', 'dark');
        document.documentElement.classList.add(theme);
        console.log('✅ Classe HTML:', document.documentElement.className);
    }, [theme]);

    const setTheme = (newTheme: Theme) => {
        console.log('🔄 Mudando tema para:', newTheme); // <- DEBUG
        setThemeState(newTheme);
    };

    const toggleTheme = () => {
        setThemeState(prev => prev === 'light' ? 'dark' : 'light');
    };

    return (
        <ThemeContext.Provider value={{ theme, setTheme, toggleTheme }}>
            {children}
        </ThemeContext.Provider>
    );
};

export const useTheme = () => {
    const context = useContext(ThemeContext);
    if (!context) {
        throw new Error('useTheme must be used within ThemeProvider');
    }
    return context;
};