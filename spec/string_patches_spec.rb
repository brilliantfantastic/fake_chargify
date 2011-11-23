require 'spec_helper'

describe "String" do
  describe ".last" do
    it "returns last characters for a string with enough characters" do
      "123456".last(4).should == "3456"
    end
    
    it "returns last characters for a string with just enough characters" do
      "12".last(2).should == "12"
    end
    
    it "returns last characters for a string with not enough characters" do
      "123456".last(9).should == "123456"
    end
    
    it "returns empty string for an empty string" do
      "".last(123).should == ""
    end
  end
end