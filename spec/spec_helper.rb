ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require(:default, :test)

require './app.rb'

set :views, 'views'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
