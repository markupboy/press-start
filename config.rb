# encoding: utf-8

require "./lib/custom_helpers"
helpers CustomHelpers

require 'html-proofer'

#
# Use webpack for assets
#
activate :external_pipeline,
         name: :webpack,
         command: build? ?  "npm run build" : "npm run start",
         source: ".tmp/dist",
         latency: 1

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascript'
set :images_dir, 'images'

activate :directory_indexes

# Build-specific configuration
configure :build do
  # Enable cache buster (except for images)
  activate :asset_hash, ignore: [/\.jpg\Z/, /\.png\Z/]
end

after_build do |builder|
  # begin
  #   HTMLProofer.check_directory(config[:build_dir], { :assume_extension => true }).run
  # rescue RuntimeError => e
  #   puts e
  #   exit(1)
  # end
end
