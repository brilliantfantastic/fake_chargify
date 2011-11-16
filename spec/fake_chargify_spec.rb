require 'spec_helper'
require 'net/http'

describe FakeChargify do
  describe ".activate!" do
    it "activates fake web requests" do
      FakeChargify.activate!
      lambda { Net::HTTP.get('example.com', '/index.html') }.should raise_error FakeWeb::NetConnectNotAllowedError
    end
  end
  
  describe ".activate=" do
    it "deactivates fake web requests" do
      FakeChargify.activate = false
      lambda { Net::HTTP.get('example.com', '/index.html') }.should_not raise_error FakeWeb::NetConnectNotAllowedError
    end
  end
end