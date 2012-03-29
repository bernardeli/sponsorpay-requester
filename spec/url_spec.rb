# encoding: utf-8

require 'spec_helper'

describe Url do
  let(:params) { { uid: 'uniqkey', pub0: 'tester', page: 2 } }

  describe "#default_query_string" do
    it "returns params as query string" do
      Url.new(params).default_query_string.should == "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=109.235.143.113&locale=de&offer_types=112&page=2&pub0=tester&uid=uniqkey"
    end
  end

  describe "#build" do
    it "returns a formed url with generated hashkey" do
      Url.new(params).build.should == "http://api.sponsorpay.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=109.235.143.113&locale=de&offer_types=112&page=2&pub0=tester&uid=uniqkey&hashkey=b5c109eeb3a2a785a9415c784c300dcbabc979b3"
    end
  end
end
