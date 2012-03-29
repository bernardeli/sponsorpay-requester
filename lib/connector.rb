require 'net/http'

class Connector
  def initialize(url)
    @url = url
  end

  attr_reader :url

  def request!
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
  end
end
