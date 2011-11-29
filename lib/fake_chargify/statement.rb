require 'nokogiri'

module FakeChargify
  class Statement
    attr_accessor :id, :subscription_id, :opened_at, :closed_at, :settled_at, :text_view, :basic_html_view, :html_view, 
      :future_payments, :starting_balance_in_cents, :ending_balance_in_cents, :customer_first_name, :customer_last_name,
      :customer_organization, :customer_shipping_address, :customer_shipping_address_2, :customer_shipping_city, 
      :customer_shipping_state, :customer_shipping_country, :customer_shipping_zip, :customer_billing_address, 
      :customer_billing_address_2, :customer_billing_city, :customer_billing_state, :customer_billing_country, 
      :customer_billing_zip, :transactions, :events, :created_at, :updated_at
    
    def initialize(attributes = {})
      attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
    end
    
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.statement {
          xml.id_ id
          xml.subscription_id subscription_id
          xml.opened_at opened_at
          xml.closed_at closed_at
          xml.settled_at settled_at
          xml.text_view text_view
          xml.basic_html_view basic_html_view
          xml.html_view html_view
          xml.starting_balance_in_cents starting_balance_in_cents
          xml.ending_balance_in_cents ending_balance_in_cents
          xml.customer_first_name customer_first_name
          xml.customer_last_name customer_last_name
          xml.customer_organization customer_organization
          xml.customer_shipping_address customer_shipping_address
          xml.customer_shipping_address_2 customer_shipping_address_2
          xml.customer_shipping_city customer_shipping_city
          xml.customer_shipping_state customer_shipping_state
          xml.customer_shipping_country customer_shipping_country
          xml.customer_shipping_zip customer_shipping_zip
          xml.customer_billing_address customer_billing_address
          xml.customer_billing_address_2 customer_billing_address_2
          xml.customer_billing_city customer_billing_city
          xml.customer_billing_state customer_billing_state
          xml.customer_billing_country customer_billing_country
          xml.customer_billing_zip customer_billing_zip
          xml.created_at created_at
          xml.updated_at updated_at
        }
      end
      builder.to_xml
    end
  end
end