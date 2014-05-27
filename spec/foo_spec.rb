require_relative "../helper_vars"
require "#{$PROJECT_ROOT}/foo"

RSpec.describe InvoiceParser do

  let(:sample_input_txt_file_path) { "#{$PROJECT_ROOT}/spec/support/1test.txt" }
  subject { InvoiceParser.new(sample_input_txt_file_path) }

  describe "#bar" do
    it "returns 'yo'" do
      subject.bar.should == "yo"
    end
  end

end