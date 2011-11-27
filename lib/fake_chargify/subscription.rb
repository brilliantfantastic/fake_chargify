require 'nokogiri'
require 'fake_chargify/product'
require 'fake_chargify/credit_card'

module FakeChargify
  class Subscription
    attr_accessor :id, :state, :balance_in_cents, :current_period_started_at, :current_period_ends_at,
                  :trial_started_at, :trial_ended_at, :activated_at, :expires_at,
                  :product, :credit_card, :customer, :created_at, :updated_at
    
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.subscription {
          xml.id_ id
          xml.state state
          xml.balance_in_cents balance_in_cents
          xml.current_period_started_at current_period_started_at
          xml.current_period_ends_at current_period_ends_at
          xml.trial_started_at trial_started_at
          xml.trial_ended_at trial_ended_at
          xml.activated_at activated_at
          xml.expires_at expires_at
          xml.created_at created_at
          xml.updated_at updated_at
          xml << Nokogiri.XML(customer.to_xml).root.to_xml unless customer.nil?
          xml << Nokogiri.XML(product.to_xml).root.to_xml unless product.nil?
          xml << Nokogiri.XML(credit_card.to_xml).root.to_xml unless credit_card.nil?
        }
      end
      builder.to_xml
    end
    
    def self.from_xml(xml)
      subscription = Subscription.new
      doc = Nokogiri::XML.parse(xml)
      doc.xpath('//subscription').map do |e|
        unless e.xpath('product_handle').nil?
          subscription.product = Product.new
          subscription.product.handle = e.xpath('product_handle').text
        end
        e.xpath('customer_attributes').map do |c|
          subscription.customer = Customer.new
          subscription.customer.first_name = c.xpath('first_name').text
          subscription.customer.last_name = c.xpath('last_name').text
          subscription.customer.email = c.xpath('email').text
        end
        e.xpath('credit_card_attributes').map do |cc|
          subscription.credit_card = CreditCard.new
          subscription.credit_card.full_number = cc.xpath('full_number').text
          subscription.credit_card.expiration_month = cc.xpath('expiration_month').text.to_i
          subscription.credit_card.expiration_year = cc.xpath('expiration_year').text.to_i
        end
      end
      subscription
    end
  end
end