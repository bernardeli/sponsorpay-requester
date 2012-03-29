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
    params.merge!(timestamp: Time.new.to_i).symbolize_keys!
    @default_query_string = build_default_query_string(params)
  end

  attr_reader :default_query_string

  def build
    "#{AppConfig.endpoint_url}.#{AppConfig.format}?#{default_query_string}&hashkey=#{hash_key}"
  end

  private

  def hash_key
    Digest::SHA1.hexdigest(default_query_string + "&#{AppConfig.api_key}")
  end

  def build_default_query_string(params)
    default_params = Hash[DEFAULT_PARAMS.merge(params).sort]
    default_params.inject([]) { |array, param| array << param.join("=") }.join("&")
  end
end
