require 'nokogiri'
require 'fake_chargify/subscription'
require 'fake_chargify/url_parser'

module FakeChargify
  class SubscriptionRegistry
    include UrlParser
    
    def repository
      @subscriptions ||= []
    end
    
    def stub_requests!
      stub_create!
      stub_list!
      stub_show!
      stub_update!
      stub_delete!
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
    
    def stub_show!
      WebMock::API.stub_request(:get, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/subscriptions\/#{/\d/}.xml/).
        to_return(:status => 200, :body => lambda { |request| 
          id = get_id_from_uri request.uri
          subscriptions = repository.select { |subscription| subscription.id == id }
          subscriptions.first.to_xml
        })
    end
    
    def stub_update!
      WebMock::API.stub_request(:put, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/subscriptions\/#{/\d/}.xml/).
        to_return(:status => 200, :body => lambda { |request| 
          id = get_id_from_uri request.uri
          subscription = Subscription.from_xml(request.body)
          repository.map! do |s|
            if s.id == id
              subscription
            else
              s
            end
          end
          subscription.to_xml
        })
    end
    
    def stub_delete!
      WebMock::API.stub_request(:delete, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/subscriptions\/#{/\d/}.xml/).
        to_return(:status => 200, :body => lambda { |request| 
          id = get_id_from_uri request.uri
          repository.delete_if { |subscription| subscription.id == id }
        })
    end
  end
end