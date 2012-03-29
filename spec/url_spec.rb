# encoding: utf-8

require 'spec_helper'

describe Url do
  let(:params) { { uid: 'uniqkey', pub0: 'tester', page: 2 } }

  before(:each) do
    Time.any_instance.stub(:to_i).and_return(1332990867)
  end

  describe "#default_query_string" do
    it "returns params as query string" do
      Url.new(params).default_query_string.should == "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=109.235.143.113&locale=de&offer_types=112&page=2&pub0=tester&timestamp=1332990867&uid=uniqkey"
    end
  end

  describe "#build" do
    it "returns a formed url with generated hashkey" do
      Url.new(params).build.should == "http://api.sponsorpay.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=109.235.143.113&locale=de&offer_types=112&page=2&pub0=tester&timestamp=1332990867&uid=uniqkey&hashkey=118b68ab511d961aab64e8160e24997c5c99222f"
    end
  end
end
