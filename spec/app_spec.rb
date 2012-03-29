# encoding: utf-8

require 'spec_helper'

describe "SponsorPay Requester" do
  describe "/" do
    it "returns status code 200" do
      get '/'
      last_response.status.should == 200
    end
  end
end

