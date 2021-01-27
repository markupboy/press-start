var webpack = require("webpack");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
var Clean = require("clean-webpack-plugin");

module.exports = {
  mode: "production",

  entry: {
    pressstart: "./assets/javascript/bootstrap.js"
  },

  resolve: {
    modules: [
      __dirname + "/assets/javascript",
      __dirname + "/assets/stylesheets",
      __dirname + "/node_modules"
    ],
    extensions: [".js", ".css", ".scss"]
  },

  output: {
    path: __dirname + "/.tmp/dist",
    filename: "assets/javascript/[name].bundle.js"
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        }
      },
      {
        test: /\.css$/i,
        use: [MiniCssExtractPlugin.loader, 'css-loader'],
      },
    ]
  },

  plugins: [
    // Always expose NODE_ENV to webpack, in order to use `process.env.NODE_ENV`
    // inside your code for any environment checks; UglifyJS will automatically
    // drop any unreachable code.
    new webpack.DefinePlugin({
      "process.env": {
        NODE_ENV: JSON.stringify(process.env.NODE_ENV)
      }
    }),
    new Clean([".tmp"]),
    new MiniCssExtractPlugin({
      filename: "assets/stylesheets/[name].bundle.css"
    })
  ]
};
