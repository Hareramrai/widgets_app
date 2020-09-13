const { environment } = require("@rails/webpacker");

const webpack = require("webpack");

environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    JQuery: "jquery",
    Propper: ["proper.js", "default"],
  })
);

module.exports = environment;
