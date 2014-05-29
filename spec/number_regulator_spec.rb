require_relative "../helper_vars"
require "#{$PROJECT_ROOT}/lib/number_regulator"

RSpec.describe NumberRegulator do

  describe "#regulate" do

    context "when invoice number is legal is legal" do
      subject { NumberRegulator.new("123456789") }
      
      it "returns the sent invoice number" do
        subject.regulate.should == "123456789"
      end
    end

    context "when invoice number is legal is ilegal" do
      subject { NumberRegulator.new("12?45?78?") }
      
      it "adds the string 'ILLEGAL' to the invoice number" do
        subject.regulate.should == "12?45?78? ILLEGAL"
      end
    end
    
  end

end