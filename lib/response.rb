# encoding: utf-8
require 'digest/sha1'

class Response
  def self.valid?(resp)
    encode(resp.body) == resp.header['X-Sponsorpay-Response-Signature']
  end

  private

  def self.encode(body)
    Digest::SHA1.hexdigest(body + AppConfig.api_key)
  end
end
