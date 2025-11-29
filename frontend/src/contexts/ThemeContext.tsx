import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

type Theme = 'light' | 'dark';

interface ThemeContextType {
    theme: Theme;
    setTheme: (theme: Theme) => void;
    toggleTheme: () => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider = ({ children }: { children: ReactNode }) => {
    // Carrega tema do localStorage ou usa 'dark' como padrão
    const [theme, setThemeState] = useState<Theme>(() => {
        const saved = localStorage.getItem('corrigeai-theme');
        return (saved as Theme) || 'dark';
    });

    // Salva no localStorage quando mudar
    useEffect(() => {
        localStorage.setItem('corrigeai-theme', theme);
        
        // Atualiza classe no body para aplicar CSS global (opcional)
        document.body.className = theme;
    }, [theme]);

    const setTheme = (newTheme: Theme) => {
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