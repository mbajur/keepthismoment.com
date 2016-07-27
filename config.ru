require "rack/jekyll"

run Rack::Jekyll.new(
  config: '_config_deploy.yml'
)
