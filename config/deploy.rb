# Add bundler gems to load path
ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'

# Load zappos-deploy
require 'zappos-deploy/recipes/all'