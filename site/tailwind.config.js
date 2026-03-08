/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        app: {
          900: '#1a1a2e',
          800: '#16213e',
          700: '#0f3460'
        }
      }
    },
  },
  plugins: [],
}
