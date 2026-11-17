/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // The Workbench brand accent, from the @calliopelabs/ui tokens (calliope/tokens.css).
        primary: {
          DEFAULT: 'var(--primary)',
          foreground: 'var(--primary-foreground)',
        },
        // Brand-owned, pending the brand schema expansion: the registry's own
        // page, surface, text and line colours (styles/globals.css).
        kasm: {
          page: 'rgb(var(--kasm-page) / <alpha-value>)',
          text: 'rgb(var(--kasm-text) / <alpha-value>)',
          surface: 'rgb(var(--kasm-surface) / <alpha-value>)',
          line: 'rgb(var(--kasm-line) / <alpha-value>)',
          band: 'rgb(var(--kasm-band) / <alpha-value>)',
          hover: 'rgb(var(--kasm-hover) / <alpha-value>)',
        },
      },
      fontFamily: {
        sans: ['var(--kasm-font-sans)'],
      },
    },
  },
  plugins: [],
}
