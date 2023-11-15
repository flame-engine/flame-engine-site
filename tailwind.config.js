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
      sans: ['"IBM Plex Mono"', 'sans-serif'],
      serif: ['Firealistic', 'sans-serif'],
      accent: ['PT sans', 'sans-serif'],
    },
    extend: {
      maxWidth: {
        'testimonial-sm': '320px',
        'noice': '300px',
        'testimonial': '410px',
      },
      colors: {
        'accent': '#FF8835',
        'bg': '#140003',
        'footer': '#431C01',
      },
    },
  },

  plugins: []
}
