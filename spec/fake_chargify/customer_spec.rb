require 'spec_helper'

describe "Chargify::Customer.create" do
  before(:each) do
    FakeChargify.activate!
  end
      
  it "returns the correct values" do
    customer = Chargify::Customer.create(:id => 5, :reference => 'dogs')
    customer.id.should == '5'
    customer.reference.should == 'dogs'
  end
end

describe "Chargify::Customer.find" do
  before(:each) do
    FakeChargify.activate!
  end
      
  it "returns the correct customer by id" do
    Chargify::Customer.create(:id => 5, :reference => 'dogs')
    customer = Chargify::Customer.find 5
    customer.id.should == '5'
    customer.reference.should == 'dogs'
  end
end

describe "Chargify::Customer.find_by_reference" do
  before(:each) do
    FakeChargify.activate!
  end
      
  it "returns the correct customer by reference" do
    Chargify::Customer.create(:id => 5, :reference => 'dogs', :first_name => 'Joe', :last_name => 'Blow', :email => 'joe@example.com')
    customer = Chargify::Customer.find_by_reference 'dogs'
    customer.id.should == '5'
    customer.reference.should == 'dogs'
    customer.first_name == 'Joe'
    customer.last_name == 'Blow'
    customer.email == 'joe@example.com'
  end
end

describe "FakeChargify::Customer" do
  describe ".to_xml" do
    it "returns xml from object properties" do
      customer = FakeChargify::Customer.new
      customer.id = 5
      customer.first_name = "Joe"
      customer.last_name = "Blow"
      customer.email = "joe@example.com"
      customer.organization = "Chargify"
      customer.reference = "jblow"
      customer.to_xml.gsub(/\s/,'').should == 
      """
      <?xml version=\"1.0\"?>
      <customer>
        <id>5</id>
        <first_name>Joe</first_name>
        <last_name>Blow</last_name>
        <email>joe@example.com</email>
        <organization>Chargify</organization>
        <reference>jblow</reference>
        <created_at></created_at>
        <updated_at></updated_at>
      </customer>
      """.gsub(/\s/,'')
    end
  end
    
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