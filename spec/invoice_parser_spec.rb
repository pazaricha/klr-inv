require_relative "../helper_vars"
require "#{$PROJECT_ROOT}/invoice_parser"

RSpec.describe InvoiceParser do

  let(:sample_input_txt_file_path) { "#{$PROJECT_ROOT}/spec/support/1test.txt" }
  subject { InvoiceParser.new(sample_input_txt_file_path) }

  describe "#parse" do
    it "returns the parsed invoices numbers" do
      subject.parse.should == "650408454"
    end
  end

  describe "#disassemble_line_to_groups_of_3_chars" do
    let(:sample_line) do 
      file = File.open(sample_input_txt_file_path)
      line = file.readline.gsub("\n", "")
      file.rewind
      line
    end
    it "returns an array of groups of 3 chars" do
      subject.disassemble_line_to_groups_of_3_chars(sample_line).should == [[" ", "_", " "], [" ", "_", " "], [" ", "_", " "], [" ", " ", " "], [" ", "_", " "], [" ", "_", " "], [" ", " ", " "], [" ", "_", " "], [" ", " ", " "]]
    end
  end

end