module.exports = {
  content: [
    './_drafts/**/*.html',
    './_includes/**/*.html',
    './_layouts/**/*.html',
    './_posts/*.md',
    './*.md',
    './*.html',
  ],

  theme: {
    container: {
      padding: {
        DEFAULT: '1rem',
        sm: '1rem,',
        lg: '1rem',
        xl: '2rem',
        '2xl': '2rem',
      },
      screens: {
        sm: '100%',
        md: '100%',
        lg: '984px',
        xl: '1200px',
        '2xl': '1200px',
      },

    },
    fontFamily: {
      sans: ['"Exo 2"', 'sans-serif'],
      serif: ['Firealistic', 'sans-serif'],
    },
    extend: {
      colors: {
        'footer-gray': '#272727',
      },
    },
  },

  plugins: []
}
