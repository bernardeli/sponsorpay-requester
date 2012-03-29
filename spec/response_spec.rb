# encoding: utf-8

require 'spec_helper'

describe Response do
  describe ".valid?" do
    context "when Signature is valid" do
      it "returns true" do
        response = mock(body: '{ "code" : "OK" }', header: mock(:[] => '1b055355dd9a96c1c95a1e6f6536ebebba3426b8'))
        Response.valid?(response).should be_true
      end
    end

    context "when Signature is different" do
      it "returns false" do
        response = mock(body: '{ "code" : "OK" }', header: mock(:[] => 'b4be8390c'))
        Response.valid?(response).should be_false
      end
    end
  end
end
