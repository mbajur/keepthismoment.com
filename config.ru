require "rack/jekyll"

config_file = ENV['JEKYLL_CONFIG_FILE'] || '_config.yml'

run Rack::Jekyll.new(
  config: config_file
)
