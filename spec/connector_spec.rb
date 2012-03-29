# encoding: utf-8

require 'spec_helper'

describe Connector do
  let(:params) { { uid: 'uniqkey', pub0: 'tester', page: 2 } }
  let(:url) { 'http://api.sponsorpay.com' }

  describe "#url" do
    it "returns url according to params" do
      Connector.new(url).url.should == 'http://api.sponsorpay.com'
    end
  end

  describe "#request!" do
    context "when url is properly formed" do
      it "returns status 200 OK" do
        FakeWeb.register_uri :get, url, :status => [200, 'OK']
        response = Connector.new(url).request!
        response.code.should == '200'
        response.message.should == 'OK'
      end
    end

    context "when url is missing parameters" do
      it "returns status 400 Bad Request" do
        FakeWeb.register_uri :get, url, :status => [400, 'Bad Request']
        response = Connector.new(url).request!
        response.code.should == '400'
        response.message.should == 'Bad Request'
      end
    end
  end
end
