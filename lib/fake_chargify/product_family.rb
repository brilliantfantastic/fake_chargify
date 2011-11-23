require 'nokogiri'

module FakeChargify
  class ProductFamily
    attr_accessor :accounting_code, :handle, :name
    
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.product_family {
          xml.accounting_code accounting_code
          xml.handle handle
          xml.name name
        }
      end
      builder.to_xml
    end
  end
end