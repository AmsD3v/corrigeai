// tailwind.config.js
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
        display: ['Poppins', 'sans-serif'], // Fonte para Títulos
      },
      colors: {
        brand: {
          600: '#4f46e5', // Indigo (Principal)
          700: '#3730a3',
        },
        accent: {
          400: '#14b8a6', // Teal (Secundária)
          500: '#0d9488',
        }
      }
    },
  },
  plugins: [],
}