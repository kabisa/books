const {environment} = require('@rails/webpacker');

const webpack = require('webpack');

// Make $ available on the window object
// for SJR views and jQuery plugins
// that may expect `$` to be globally available.
environment.loaders.append('expose', {
  test: require.resolve('jquery'),
  use: [
    {
      loader: 'expose-loader',
      options: 'jQuery',
    },
    {
      loader: 'expose-loader',
      options: '$',
    },
  ],
});

// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader',
  options: {
    attempts: 1,
  },
});

module.exports = environment;
