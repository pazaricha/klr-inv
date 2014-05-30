require_relative "../helper_vars"
require "#{$PROJECT_ROOT}/lib/invoice_parser"

RSpec.describe InvoiceParser do


  describe "#parse" do

    context "when input file has only legal invoice numbers" do
      let(:user_story_1_input) { "#{$PROJECT_ROOT}/spec/fixtures/input_user_story_1.txt" }
      let(:user_story_1_output) { File.open("#{$PROJECT_ROOT}/spec/fixtures/output_user_story_1.txt").read }
      subject { InvoiceParser.new(user_story_1_input) }

      it "returns a string of parsed invoices numbers" do
        subject.parse.should == user_story_1_output
      end
    end

    context "when input file has both legal and ilegal invoice numbers" do
      let(:user_story_2_input) { "#{$PROJECT_ROOT}/spec/fixtures/input_user_story_2.txt" }
      let(:user_story_2_output) { File.open("#{$PROJECT_ROOT}/spec/fixtures/output_user_story_2.txt").read }
      subject { InvoiceParser.new(user_story_2_input) }

      it "returns a string of parsed invoices numbers" do
        subject.parse.should == user_story_2_output
      end
    end

  end

end