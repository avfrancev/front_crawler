var utils = require('./utils')
var config = require('../config')
var isProduction = process.env.NODE_ENV === 'production'

module.exports = {
	loaders: utils.cssLoaders({
		sourceMap: isProduction
			? config.build.productionSourceMap
			: config.dev.cssSourceMap,
		extract: isProduction
	}),
	transformToRequire: {
		video: 'src',
		source: 'src',
		img: 'src',
		image: 'xlink:href'
	},
	postcss: [
		require('postcss-css-reset')(),
		require('postcss-font-magician')(
			{
					variants: {
							'Roboto Condensed': {
									'300': [],
									'400': [],
									'700': []
							}
					},
					variants: {
							'PT+Sans+Caption': {
									// '300': [],
									'400': [],
									'700': []
							}
					},
					foundries: ['google']
			}
		)
	]
}
