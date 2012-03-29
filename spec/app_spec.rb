# encoding: utf-8

require 'spec_helper'

describe "SponsorPay Requester" do
  describe "/" do
    it "returns status code 200" do
      get '/'
      last_response.status.should == 200
    end
  end

  describe "POST fetch" do
    let(:url) { 'http://sponsorpay.com/api' }

    before(:each) do
      Url.any_instance.stub(:build).and_return(url)
    end

    context "when response is other than 200" do
      before(:each) do
        FakeWeb.register_uri :get, url, code: [400, 'Bad Request']
      end

      it "renders error's page" do
        post :fetch, uid: 'player', pub0: 'campaign2', page: 1
        last_response.body.should include "Something went wrong"
      end
    end

    context "when response code is 200" do
      before(:each) do
        FakeWeb.register_uri :get, url, status: [200, 'OK'], body: File.open('./spec/support/success.json').read
      end

      context "when message is No Content" do
        before(:each) do
          FakeWeb.register_uri :get, url, status: [200, 'No Content']
          Response.stub(:valid?).and_return(true)
        end

        it "renders no offer partial" do
          post :fetch, uid: 'player', pub0: 'campaign2', page: 1
          last_response.body.should include "<div class='no_offers'>"
          last_response.body.should include "No offers"
        end

      end

      context "when response is not valid" do
        before(:each) { Response.stub(:valid?).and_return(false) }

        it "renders error" do
          post :fetch, uid: 'player', pub0: 'campaign2', page: 1
          last_response.status.should == 200
          last_response.body.should include "Something went wrong"
        end
      end

      context "when response is valid" do
        before(:each) { Response.stub(:valid?).and_return(true) }

        it "renders offers" do
          post :fetch, uid: 'player', pub0: 'campaign2', page: 1
          last_response.status.should == 200
          last_response.body.should include "<div class='offer'>"
          last_response.body.should include "<div class='title'>Solitaire - Das klassische Spiel</div>"
          last_response.body.should include "<div class='payout'>20240</div>"
          last_response.body.should include "<div class='thumbnail'>http://acp-production.s3.amazonaws.com/app_icons/248/big_icon.png</div>"
        end
      end
    end
  end
end

