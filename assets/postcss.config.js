module.exports = {
    plugins: [
        require('postcss-import'),
        require('postcss-simple-vars'),
        require('postcss-nested'),
        require('postcss-font-awesome'),
        require("stylelint"),
        require("tailwindcss"),
        process.env.NODE_ENV === 'production' ? require('autoprefixer') : null,
        require('cssnano')({ preset: 'default' })
    ]
}
