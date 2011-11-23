require 'spec_helper'

describe "FakeChargify::ProductFamily" do
  describe ".to_xml" do
    it "returns xml from object properties" do
      family = FakeChargify::ProductFamily.new
      family.accounting_code = '1234'
      family.handle = 'Starter'
      family.name = 'Subscription'
      family.to_xml.gsub(/\s/,'').should == 
      """
      <?xml version=\"1.0\"?>
      <product_family>
        <accounting_code>1234</accounting_code>
        <handle>Starter</handle>
        <name>Subscription</name>
      </product_family>
      """.gsub(/\s/,'')
    end
  end
end