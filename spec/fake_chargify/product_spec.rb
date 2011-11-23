require 'spec_helper'

describe "FakeChargify::Product" do
  describe ".to_xml" do
    it "returns xml from object properties" do
      product = FakeChargify::Product.new
      product.accounting_code = '1234'
      product.handle = 'Starter'
      product.interval = 4
      product.name = 'Subscription'
      product.price_in_cents = 897
      product.family = FakeChargify::ProductFamily.new
      product.family.accounting_code = '1234'
      product.family.handle = 'Starter'
      product.family.name = 'Subscription'
      product.to_xml.gsub(/\s/,'').should == 
      """
      <?xml version=\"1.0\"?>
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
      """.gsub(/\s/,'')
    end
  end
end