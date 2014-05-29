require_relative "../helper_vars"
require "#{$PROJECT_ROOT}/invoice_parser"

RSpec.describe InvoiceParser do

  let(:user_story_1_input) { "/spec/support/input_user_story_1.txt" }
  let(:user_story_1_output) { "/spec/support/parsed_tests/user_story_1_parsed.txt" }
  let(:expected_parsed_file_content) {
    File.open("#{$PROJECT_ROOT}/spec/support/output_user_story_1.txt").read
  }

  subject { InvoiceParser.new(user_story_1_input, user_story_1_output) }

  describe "#parse" do
    it "returns the parsed invoices numbers" do
      subject.parse
      File.open("#{$PROJECT_ROOT}#{user_story_1_output}").read.should == expected_parsed_file_content
    end
  end

  describe "#disassemble_line_to_groups_of_3_chars" do
    let(:sample_line) do 
      file = File.open(user_story_1_input)
      line = file.readline.gsub("\n", "")
      file.rewind
      line
    end
    it "returns an array of groups of 3 chars" do
      subject.disassemble_line_to_groups_of_3_chars(sample_line).should == [[" ", "_", " "], [" ", "_", " "], [" ", "_", " "], [" ", " ", " "], [" ", "_", " "], [" ", "_", " "], [" ", " ", " "], [" ", "_", " "], [" ", " ", " "]]
    end
  end

end