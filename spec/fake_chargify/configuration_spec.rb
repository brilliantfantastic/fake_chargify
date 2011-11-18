require 'spec_helper'

describe FakeChargify do
  describe ".configure" do
    it "should set the configuration by using a block" do
      FakeChargify.configure do |c|
        c.subdomain = 'test'
        c.api_key = 'api'
      end
      FakeChargify.configuration.subdomain.should == 'test'
      FakeChargify.configuration.api_key.should == 'api'
    end
  end
end