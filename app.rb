# encoding: utf-8
require 'json'

helpers Helpers

get '/' do
  erb :index
end

post '/fetch' do
  url = Url.new(params).build

  uri = URI.parse(url)
  @resp = Net::HTTP.get_response(uri)

  if @resp.code == '200' && Response.valid?(@resp)
    if @resp.message == "OK"
      @offers = JSON.parse(@resp.body)['offers']
      partial :offer, collection: @offers, layout: true
    else
      partial :no_offer, layout: true
    end
  else
    erb :error
  end
end
