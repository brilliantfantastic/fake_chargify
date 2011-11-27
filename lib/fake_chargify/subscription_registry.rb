require 'nokogiri'
require 'fake_chargify/subscription'

module FakeChargify
  class SubscriptionRegistry
    def repository
      @subscriptions ||= []
    end
    
    def stub_requests!
      stub_create!
      stub_list!
    end
    
    private
    
    def stub_create!
      WebMock::API.stub_request(:post, "https://#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com/subscriptions.xml").
        to_return(:status => 201, :body => lambda { |request| 
          subscription = Subscription.from_xml(request.body)
          repository << subscription
          subscription.to_xml
        })
    end
    
    def stub_list!
      WebMock::API.stub_request(:get, "https://#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com/subscriptions.xml").
        to_return(:status => 200, :body => lambda { |request| 
          builder = Nokogiri::XML::Builder.new do |xml|
            xml.subscriptions(:type => 'array') {
              repository.each { |subscription| xml << Nokogiri.XML(subscription.to_xml).root.to_xml }
            }
          end
          builder.to_xml
        })
    end
  end
end