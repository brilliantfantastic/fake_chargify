require 'spec_helper'
require 'net/http'

describe FakeChargify do
  describe ".activate!" do
    it "activates fake web requests" do
      FakeChargify.activate!
      lambda { Net::HTTP.get('example.com', '/index.html') }.should raise_error WebMock::NetConnectNotAllowedError
    end
  end
  
  describe ".activate=" do
    it "deactivates fake web requests" do
      FakeChargify.activate = false
      lambda { Net::HTTP.get('example.com', '/index.html') }.should_not raise_error WebMock::NetConnectNotAllowedError
    end
  end
  
  describe ".clear!" do
    it "clears the customers" do
      FakeChargify.customers << FakeChargify::Customer.new
      FakeChargify.customers.count.should == 1
      FakeChargify.clear!
      FakeChargify.customers.count.should == 0
    end
  end
end