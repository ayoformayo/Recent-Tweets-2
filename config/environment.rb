# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'twitter'

Twitter.configure do |config|
  config.consumer_key = 'CJmmCGT6B3pCDV46rC1YQ'
  config.consumer_secret = 'Yo54cT6UhUeCQGoNhrqpqtvlhCK1SSZ0pRkBmiA'
  config.oauth_token = '432781604-MMxsBN4FfLXiwa67nyoREWyaRPH4yAsQHjhDbCCQ'
  config.oauth_token_secret = 'tQGtUJROHvJgv3t2WMO3vYLt7FxUdLEhYZT2YXHGbM'
end

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')
