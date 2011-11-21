require 'fake_chargify/customer'

module FakeChargify
  class CustomerRegistry
    
    def repository
      @customers ||= []
    end
    
    def stub_requests!
      WebMock::API.stub_request(:post, "https://#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com/customers.xml").
        to_return(:body => lambda { |request| 
          customer = Customer.from_xml(request.body)
          repository << customer
          customer.to_xml
        })
    end
    
  end
end