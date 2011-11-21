require 'nokogiri'

module FakeChargify
  
  #customers class -> stubs out request, handles callbacks, has collection of customer objects (clear, etc)
  #customer class -> has properties from request
  
  class Customer
    attr_accessor :id, :first_name, :last_name, :email, :organization, :reference, :created_at, :updated_at
    
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.customer {
          xml.id_ id
          xml.first_name first_name
          xml.last_name last_name
          xml.email email
          xml.organization organization
          xml.reference reference
          xml.created_at created_at
          xml.updated_at updated_at
        }
      end
      builder.to_xml
    end
    
    def self.from_xml(xml)
      customer = Customer.new
      doc = Nokogiri::XML.parse(xml)
      doc.xpath('//customer').map do |e| 
        customer.id = e.xpath('id').text.to_i
        customer.first_name = e.xpath('first_name').text
        customer.last_name = e.xpath('last_name').text
        customer.email = e.xpath('email').text
        customer.organization = e.xpath('organization').text
        customer.reference = e.xpath('reference').text
        customer.created_at = Time.parse(e.xpath('created_at').text)
        customer.updated_at = Time.parse(e.xpath('updated_at').text)
      end
      customer
    end
  end
  
end