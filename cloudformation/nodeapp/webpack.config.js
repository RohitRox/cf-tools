const path = require('path'),
  webpack = require('webpack'),
  HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
      app: ['./src/app/App.tsx', 'webpack-hot-middleware/client'],
      vendor: ['react', 'react-dom']
  },
  output: {
      path: path.resolve(__dirname, 'dist'),
      publicPath: '/',
      filename: 'js/[name].bundle.js'
  },
  devtool: 'source-map',
  resolve: {
      extensions: ['.js', '.jsx', '.json', '.ts', '.tsx']
  },
  module: {
      rules: [
          {
              test: /\.(ts|tsx)$/,
              loader: 'babel-loader'
          },
          { enforce: "pre", test: /\.js$/, loader: "source-map-loader" },
          {
              test: /\.scss$/,
              use: [{
                  loader: "style-loader"
              }, {
                  loader: "css-loader"
              }, {
                  loader: "sass-loader"
              }]
          },
          {
              test: /\.(png|jpg|gif)$/,
              use: [
                  {
                      loader: 'url-loader',
                  },
              ],
          },
      ]
  },
  plugins: [
      new HtmlWebpackPlugin({ template: path.resolve(__dirname, 'src', 'app', 'index.html') }),
      new webpack.HotModuleReplacementPlugin()
  ]
}
