const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.{erb,rb}'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
  darkMode: 'class',
}
