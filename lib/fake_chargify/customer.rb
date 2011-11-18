module FakeChargify
  
  class Customer  
    def self.stub_requests!
      WebMock::API.stub_request(:post, "https://#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com/customers.xml").
        to_return(:body => lambda { |request| request.body })
    end
  end
  
end