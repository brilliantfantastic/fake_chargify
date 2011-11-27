require 'spec_helper'

describe "FakeChargify::CreditCard" do
  describe ".to_xml" do
    it "returns xml from object properties" do
      card = FakeChargify::CreditCard.new
      card.full_number = "1"
      card.expiration_month = 12
      card.expiration_year = 2011
      card.to_xml.gsub(/\s/,'').should == 
      """
      <?xml version=\"1.0\"?>
      <credit_card>
        <masked_card_number>XXXX-XXXX-XXXX-1</masked_card_number>
        <expiration_month>12</expiration_month>
        <expiration_year>2011</expiration_year>
      </credit_card>
      """.gsub(/\s/,'')
    end
  end
end