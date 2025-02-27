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
    'bg-green-800',
    'hover:bg-green-600',
    'text-white'
  ],
  plugins: [],
  // 使用する機能を明示的に有効化
  variants: {
    extend: {
      textColor: ['hover', 'focus'],
      backgroundColor: ['hover', 'focus']
    }
  }
}
