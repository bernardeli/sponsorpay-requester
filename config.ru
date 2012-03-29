require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require './app.rb'

run Sinatra::Application
