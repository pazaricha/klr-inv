require_relative "../lib/invoice_digit_parser"

RSpec.describe InvoiceDigitParser do

  describe "#parse" do

    context "when the digit pattern is valid" do
      subject { InvoiceDigitParser.new(" _ | ||_|") }
      
      it "returns the parsed digit" do
        subject.parse.should == "0"
      end
    end

    context "when the digit pattern is invalid" do
      subject { InvoiceDigitParser.new("invalid pattern") }
      
      it "returns a question mark" do
        subject.parse.should == "?"
      end
    end
    
  end

end