require 'fake_chargify/customer'

module FakeChargify
  class CustomerRegistry
    
    def repository
      @customers ||= []
    end
    
    def stub_requests!
      stub_create!
      stub_update!
      stub_show!
      stub_lookup!
    end
    
    private
    
    def stub_create!
      WebMock::API.stub_request(:post, "https://#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com/customers.xml").
        to_return(:status => 201, :body => lambda { |request| 
          customer = Customer.from_xml(request.body)
          repository << customer
          customer.to_xml
        })
    end
    
    def stub_update!
      WebMock::API.stub_request(:put, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/customers\/#{/\d/}.xml/).
        to_return(:status => 200, :body => lambda { |request| 
          id = get_id_from_uri request.uri
          customer = Customer.from_xml(request.body)
          repository.map! do |c|
            if c.id == id
              customer
            else
              c
            end
          end
          customer.to_xml
        })
    end
    
    def stub_show!
      WebMock::API.stub_request(:get, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/customers\/#{/\d/}.xml/).
        to_return(:status => 200, :body => lambda { |request| 
          id = get_id_from_uri request.uri
          customers = repository.select { |customer| customer.id == id }
          customers.first.to_xml
        })
    end
    
    def stub_lookup!
      WebMock::API.stub_request(:get, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/customers\/lookup.xml\?reference=#{/\w/}/).
        to_return(:status => 200, :body => lambda { |request| 
          reference = request.uri.query_values['reference']
          customers = repository.select { |customer| customer.reference == reference }
          customers.first.to_xml
        })
    end
    
    def get_id_from_uri(uri)
      match = uri.path.match(/(\/\d.(xml|json)\z)/)
      if !match.nil? && match.size > 0
        match = match[0].match(/\d/)
        return id = match[0].to_i if !match.nil? && match.size > 0
      end
    end
    
  end
end