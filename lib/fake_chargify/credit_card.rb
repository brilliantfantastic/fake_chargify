require 'nokogiri'

module FakeChargify
  class CreditCard
    attr_accessor :expiration_month, :expiration_year
    
    def full_number=(value)
      @full_number = value
    end
    
    def masked_card_number
      "XXXX-XXXX-XXXX-#{@full_number.to_s.last(4)}"
    end
    
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.credit_card {
          xml.masked_card_number masked_card_number
          xml.expiration_month expiration_month
          xml.expiration_year expiration_year
        }
      end
      builder.to_xml
    end
  end
end