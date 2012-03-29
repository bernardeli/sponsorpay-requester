# encoding: utf-8

require 'spec_helper'

describe Hash do
  describe "#symbolize_keys!" do
    context "when keys are string" do
      it "symbolize keys from hash" do
        { "key1" => 1, "key2" => 2 }.symbolize_keys!.should == { key1: 1, key2: 2 }
      end
    end

    context "when keys are symbols" do
      it "keeps keys as symbols" do
        { key1: 1, key2: 2 }.symbolize_keys!.should == { key1: 1, key2: 2 }
      end
    end
  end
end
