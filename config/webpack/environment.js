const { environment } = require('@rails/webpacker')
const webpack = require('webpack');
const path = require('path');
const merge = require('webpack-merge');

environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default'],
  })
);

environment.loaders.append('graphql', {
  test: /\.(graphql|gql)$/,
  exclude: /node_modules/,
  use: 'graphql-tag/loader',
});

const config = {
  resolve: {
    modules: [
      path.resolve(__dirname, 'app/javascript'),
      path.resolve('node_modules')
    ]
  }
};

module.exports = merge(environment.toWebpackConfig(), config);
