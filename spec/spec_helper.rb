ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
require './app.rb'

set :views, 'views'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
