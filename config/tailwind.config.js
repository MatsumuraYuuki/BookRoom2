const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/views/**/*.erb', // 明示的に.erbファイルを指定
    './app/**/*.erb', // すべての.erbファイル
    './app/**/*.rb', // すべてのRubyファイル
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  safelist: [
    // 特定のクラスを明示的に追加
    'bg-green-500',
    'bg-green-600',
    'bg-green-800',
    'bg-blue-500',
    'bg-blue-600',
    'hover:bg-green-600',
    'hover:bg-blue-600',
    'text-white',
    'mr-2',
    'px-2',
    'py-1',
    'rounded',
    'w-2',
    // パターンマッチ
    {
      pattern: /^bg-(green|blue)-(500|600|800)$/,
      variants: ['hover']
    },
    {
      pattern: /^m[rtlb]?-[0-9]+$/
    }
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
