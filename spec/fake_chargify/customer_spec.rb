require 'spec_helper'

describe "Chargify::Customer.create" do
  before(:each) do
    FakeChargify.activate!
  end
      
  it "is added to the FakeChargify customers collection" do
    customer = Chargify::Customer.create(:id => 5, :reference => 'dogs')
  end
end