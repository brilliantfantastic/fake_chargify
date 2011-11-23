require 'fake_chargify/product_family'

module FakeChargify
  class Product
    attr_accessor :accounting_code, :handle, :interval, :name, :price_in_cents, :family
    
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.product {
          xml.accounting_code accounting_code
          xml.handle handle
          xml.interval interval
          xml.name name
          xml.price_in_cents price_in_cents
          xml << Nokogiri.XML(family.to_xml).root.to_xml unless family.nil?
        }
      end
      builder.to_xml
    end
  end
end