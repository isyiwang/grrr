const environment = require('./environment')
const merge = require('webpack-merge');

const config = {
  devtool: 'nosources-source-map', // cf. https://webpack.js.org/configuration/devtool/
};

module.exports = merge(environment, config);
