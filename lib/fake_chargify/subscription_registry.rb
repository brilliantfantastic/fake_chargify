require 'fake_chargify/subscription'

module FakeChargify
  class SubscriptionRegistry
    def repository
      @subscriptions ||= []
    end
    
    def stub_requests!
      stub_create!
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
  end
end