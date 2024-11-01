const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  safelist: [
    {
      pattern: /border-[^/]+$/,
      variants: [
        'dark',
        'hover',
        'focus',
        'dark:hover',
        'dark:focus',
        ,],
    },
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    function({ addVariant }) {
      addVariant('admin', 'div[data-admin] &')
    }
  ],
  darkMode: 'class',
}
