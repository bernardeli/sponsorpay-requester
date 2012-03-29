require 'digest/sha1'

class Url
  DEFAULT_PARAMS = {
    appid: AppConfig.appid,
    ip: AppConfig.ip,
    locale: AppConfig.locale,
    device_id: AppConfig.device_id,
    offer_types: AppConfig.offer_types
  }

  def initialize(params)
    @default_query_string = generate_default_query_string(params.symbolize_keys.merge(timestamp: Time.new.to_i))
  end

  attr_reader :default_query_string

  def build
    "#{AppConfig.endpoint_url}.#{AppConfig.format}?#{default_query_string}&#{hash_key}"
  end

  private

  def hash_key
    sha1 = Digest::SHA1.hexdigest(default_query_string + "&#{AppConfig.api_key}")
    "hashkey=#{sha1}"
  end

  def generate_default_query_string(params)
    default_params = Hash[DEFAULT_PARAMS.merge(params).sort]
    default_params.inject([]) { |array, param| array << param.join("=") }.join("&")
  end
end
