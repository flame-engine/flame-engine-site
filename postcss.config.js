const production = process.env.JEKYLL_ENV == 'production';

module.exports = {
    plugins: [
        require('@tailwindcss/postcss')({ base: __dirname, optimize: production }),
        ...(production
        ? [require('cssnano')({ preset: 'default' })]
        : [])
    ]
}
