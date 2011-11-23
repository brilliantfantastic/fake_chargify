require 'spec_helper'

describe "chargify_api_ares gem" do
  before(:each) do
    FakeChargify.activate!
  end
  
  describe "Chargify::Subscription.create" do
    it "returns the correct values" do
      subscription = Chargify::Subscription.create(
        :customer_reference => 'jblow',
        :product_handle => 'Starter',
        :credit_card_attributes => {
          :first_name => "Lester",
          :last_name => "Tester",
          :expiration_month => 1,
          :expiration_year => 2020,
          :full_number => "1"
        }
      )
      subscription.customer_reference.should == 'jblow'
      subscription.product_handle.should == 'Starter'
    end
  end
end

describe "FakeChargify::Subscription" do
  describe ".to_xml" do
    it "returns xml from object properties" do
      subscription = FakeChargify::Subscription.new
      subscription.id = 5
      subscription.state = 'active'
      subscription.balance_in_cents = 39
      subscription.customer = FakeChargify::Customer.new
      subscription.customer.id = 6
      subscription.customer.first_name = 'Joe'
      subscription.customer.last_name = 'Blow'
      subscription.customer.email = 'joe@example.com'
      subscription.product = FakeChargify::Product.new
      subscription.product.accounting_code = '1234'
      subscription.product.handle = 'Starter'
      subscription.product.interval = 4
      subscription.product.name = 'Subscription'
      subscription.product.price_in_cents = 897
      subscription.product.family = FakeChargify::ProductFamily.new
      subscription.product.family.accounting_code = '1234'
      subscription.product.family.handle = 'Starter'
      subscription.product.family.name = 'Subscription'
      subscription.to_xml.gsub(/\s/,'').should == 
      """
      <?xml version=\"1.0\"?>
      <subscription>
        <id>5</id>
        <state>active</state>
        <balance_in_cents>39</balance_in_cents>
        <current_period_started_at></current_period_started_at>
        <current_period_ends_at></current_period_ends_at>
        <trial_started_at></trial_started_at>
        <trial_ended_at></trial_ended_at>
        <activated_at></activated_at>
        <expires_at></expires_at>
        <created_at></created_at>
        <updated_at></updated_at>
        <customer>
          <id>6</id>
          <first_name>Joe</first_name>
          <last_name>Blow</last_name>
          <email>joe@example.com</email>
          <organization />
          <reference />
          <created_at />
          <updated_at />
        </customer>
        <product>
          <accounting_code>1234</accounting_code>
          <handle>Starter</handle>
          <interval>4</interval>
          <name>Subscription</name>
          <price_in_cents>897</price_in_cents>
          <product_family>
            <accounting_code>1234</accounting_code>
            <handle>Starter</handle>
            <name>Subscription</name>
          </product_family>
        </product>
      </subscription>
      """.gsub(/\s/,'')
    end
  end
  
  describe ".from_xml" do
    it "parses valid xml and sets properties" do
      subscription = FakeChargify::Subscription.from_xml """
        <?xml version='1.0' encoding='UTF-8'?>
        <subscription>
          <product_handle>Starter</product_handle>
          <customer_attributes>
            <first_name>Joe</first_name>
            <last_name>Blow</last_name>
            <email>joe@example.com</email>
          </customer_attributes>
          <credit_card_attributes>
            <full_number>1</full_number>
            <expiration_month>10</expiration_month>
            <expiration_year>2020</expiration_year>
          </credit_card_attributes>
        </subscription>
        """
      subscription.product.handle.should == 'Starter'
      subscription.customer.first_name.should == 'Joe'
      subscription.customer.last_name.should == 'Blow'
      subscription.customer.email.should == 'joe@example.com'
      subscription.credit_card.masked_card_number.should == 'XXXX-XXXX-XXXX-1'
      subscription.credit_card.expiration_month.should == 10
      subscription.credit_card.expiration_year.should == 2020
    end
  end
end