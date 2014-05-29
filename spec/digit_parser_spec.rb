require_relative "../lib/digit_parser"

RSpec.describe DigitParser do

  describe "#parse" do

    context "when the digit pattern is valid" do
      subject { DigitParser.new(" _ | ||_|") }
      
      it "returns the parsed digit" do
        subject.parse.should == "0"
      end
    end

    context "when the digit pattern is invalid" do
      subject { DigitParser.new("invalid pattern") }
      
      it "returns a question mark" do
        subject.parse.should == "?"
      end
    end
    
  end

end