require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
require './app.rb'

run Sinatra::Application
