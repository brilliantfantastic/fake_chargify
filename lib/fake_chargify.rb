require 'fakeweb'
require 'fake_chargify/customer'

module FakeChargify
  class << self
    attr_accessor :customers
  end
  
  def self.clear!
    self.customers = []
  end
  
  def self.activate!
    self.activate = true
  end
  
  def self.activate=(activate)
    FakeWeb.allow_net_connect = !activate
    self.clear! if activate
  end
end