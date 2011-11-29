require 'webmock'
require 'string_patches'
require 'fake_chargify/customer_registry'
require 'fake_chargify/subscription_registry'
require 'fake_chargify/statement_registry'
require 'fake_chargify/configuration'

module FakeChargify
  class << self
    attr_accessor :customers, :subscriptions, :statements
  end
  
  def self.clear!
    self.customers = CustomerRegistry.new
    self.subscriptions = SubscriptionRegistry.new
    self.statements = StatementRegistry.new
  end
  
  def self.activate!
    self.activate = true
  end
  
  def self.activate=(activate)
    if activate
      WebMock.disable_net_connect!(:allow_localhost => true)
      self.clear!
      
      self.customers.stub_requests!
      self.subscriptions.stub_requests!
      self.statements.stub_requests!
    else
      WebMock.allow_net_connect!
    end
  end
  
  def self.configuration
    @configuration ||= FakeChargify::Configuration.new
  end
  
  def self.configure
    yield configuration if block_given?
  end
end