require_relative "../helper_vars"
require "#{$PROJECT_ROOT}/lib/invoice_number_regulator"

RSpec.describe InvoiceNumberRegulator do

  describe "#regulate" do

    context "when invoice number is legal" do
      subject { InvoiceNumberRegulator.new("123456789") }
      
      it "returns the sent invoice number" do
        subject.regulate.should == "123456789"
      end
    end

    context "when invoice number is ilegal" do
      subject { InvoiceNumberRegulator.new("12?45?78?") }
      
      it "adds the string 'ILLEGAL' to the invoice number" do
        subject.regulate.should == "12?45?78? ILLEGAL"
      end
    end
    
  end

end