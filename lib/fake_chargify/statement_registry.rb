require 'nokogiri'
require 'fake_chargify/statement'

module FakeChargify
  class StatementRegistry
    include UrlParser
    
    def repository
      @statements ||= []
    end
    
    def stub_requests!
      stub_list!
    end
    
    private
    
    def stub_list!
      WebMock::API.stub_request(:get, /https:\/\/#{FakeChargify.configuration.api_key}:X@#{FakeChargify.configuration.subdomain}.chargify.com\/subscriptions\/#{/\d/}\/statements.xml/).
        to_return(:status => 200, :body => lambda { |request| 
          subscription_id = request.uri.path.match(/(\/\d.statements.(xml|json)\z)/)[0].match(/\d/)[0].to_i
          statements = FakeChargify.statements.repository.select { |s| s.subscription_id == subscription_id }
          builder = Nokogiri::XML::Builder.new do |xml|
            xml.statements(:type => 'array') {
              statements.each { |statement| xml << Nokogiri.XML(statement.to_xml).root.to_xml }
            }
          end
          builder.to_xml
        })
    end
  end
end