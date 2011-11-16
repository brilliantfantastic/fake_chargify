require 'fakeweb'

module FakeChargify
  def self.activate!
    self.activate = true
  end
  
  def self.activate=(activate)
    FakeWeb.allow_net_connect = !activate
  end
end