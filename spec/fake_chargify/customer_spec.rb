require 'spec_helper'

describe "Chargify::Customer.create" do
  before(:each) do
    FakeChargify.activate!
  end
      
  it "is added to the FakeChargify customers collection" do
    customer = Chargify::Customer.create(:id => 5, :reference => 'dogs')
  end
end

describe "FakeChargify::Customer" do
  describe ".from_xml" do
    it "parses valid xml and sets properties" do
      customer = FakeChargify::Customer.from_xml """
        <?xml version='1.0' encoding='UTF-8'?>
        <customer>
          <id type='integer'>5</id>
          <first_name>Joe</first_name>
          <last_name>Blow</last_name>
          <email>joe@example.com</email>
          <organization>Chargify</organization>
          <reference>jblow</reference>
          <created_at type='datetime'>2011-11-20T18:34:07-05:00</created_at>
          <updated_at type='datetime'>2011-11-20T18:34:07-05:00</updated_at>
        </customer>
        """
      customer.id.should == 5
      customer.first_name.should == "Joe"
      customer.last_name.should == "Blow"
      customer.email.should == "joe@example.com"
      customer.organization.should == "Chargify"
      customer.reference.should == "jblow"
      customer.created_at.should == Time.parse('2011-11-20T18:34:07-05:00')
      customer.updated_at.should == Time.parse('2011-11-20T18:34:07-05:00')
    end
  end
end