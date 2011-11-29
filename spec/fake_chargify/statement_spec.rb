require 'spec_helper'

describe "chargify_api_ares gem" do
  before(:each) do
    FakeChargify.activate!
  end

  describe "Chargify::Subscription.statements" do
    it "finds all the statements for a given subscription" do
      Chargify::Subscription.create(
        :id => 1,
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
      subscription = FakeChargify.subscriptions.repository.select { |s| s.id == 1 }.first
      statement = FakeChargify::Statement.new(
        :id => 1,
        :subscription_id => subscription.id
      )
      FakeChargify.statements.repository << statement
      
      subscription = Chargify::Subscription.find 1
      statements = subscription.statements
      statements.count.should == 1
      statements[0].id.should == '1'
    end
  end
end

describe "FakeChargify::Statement" do
  describe ".to_xml" do
    it "returns xml from object properties" do
      statement = FakeChargify::Statement.new(
        :id => 1,
        :subscription_id => 1
      )
      statement.to_xml.gsub(/\s/,'').should == 
      """
      <?xml version=\"1.0\"?>
      <statement>
        <id>1</id>
        <subscription_id>1</subscription_id>
        <opened_at></opened_at>
        <closed_at></closed_at>
        <settled_at></settled_at>
        <text_view></text_view>
        <basic_html_view></basic_html_view>
        <html_view></html_view>
        <starting_balance_in_cents></starting_balance_in_cents>
        <ending_balance_in_cents></ending_balance_in_cents>
        <customer_first_name></customer_first_name>
        <customer_last_name></customer_last_name>
        <customer_organization></customer_organization>
        <customer_shipping_address></customer_shipping_address>
        <customer_shipping_address_2></customer_shipping_address_2>
        <customer_shipping_city></customer_shipping_city>
        <customer_shipping_state></customer_shipping_state>
        <customer_shipping_country></customer_shipping_country>
        <customer_shipping_zip></customer_shipping_zip>
        <customer_billing_address></customer_billing_address>
        <customer_billing_address_2></customer_billing_address_2>
        <customer_billing_city></customer_billing_city>
        <customer_billing_state></customer_billing_state>
        <customer_billing_country></customer_billing_country>
        <customer_billing_zip></customer_billing_zip>
        <created_at></created_at>
        <updated_at></updated_at>
      </statement>
      """.gsub(/\s/,'')
    end
  end
end