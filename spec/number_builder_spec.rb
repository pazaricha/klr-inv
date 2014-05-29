require_relative "../lib/number_builder"

RSpec.describe NumberBuilder do

  describe "#build" do

    context "when invoice number is legal" do
      subject { NumberBuilder.new(
        [
          [
            [" ", "_", " "], 
            [" ", "_", " "], 
            [" ", "_", " "], 
            [" ", " ", " "], 
            [" ", " ", " "], 
            [" ", "_", " "], 
            [" ", " ", " "], 
            [" ", "_", " "], 
            [" ", "_", " "]
          ], 
          [
            ["|", "_", " "], 
            ["|", " ", "|"], 
            ["|", " ", "|"], 
            [" ", " ", "|"], 
            ["|", "_", "|"], 
            [" ", "_", "|"], 
            [" ", " ", "|"], 
            ["|", "_", " "], 
            ["|", "_", " "]
          ], 
          [
            ["|", "_", "|"], 
            ["|", "_", "|"], 
            ["|", "_", "|"], 
            [" ", " ", "|"], 
            [" ", " ", "|"], 
            [" ", "_", "|"], 
            [" ", " ", "|"], 
            [" ", "_", "|"], 
            [" ", "_", "|"]
          ]
        ]) }
    
      it "builds the invoice number" do
        subject.build.should == "600143155"
      end
    end

    context "when invoice number is ilegal" do
      subject { NumberBuilder.new(
        [
          [
            [" ", "_", " "], 
            [" ", " ", " "], 
            [" ", "_", " "], 
            [" ", "_", " "], 
            [" ", "_", " "], 
            [" ", "_", " "], 
            [" ", "_", " "], 
            [" ", " ", " "], 
            [" ", "_", " "]
          ], 
          [
            ["|", " ", "|"], 
            [" ", " ", "|"], 
            ["|", " ", "|"], 
            [" ", "_", "|"], 
            [" ", "_", "|"], 
            ["|", " ", "|"], 
            [" ", "_", "|"], 
            [" ", " ", "|"], 
            [" ", "_", "|"]
          ], 
          [
            ["|", "_", "|"], 
            [" ", " ", "|"], 
            ["|", "_", "|"], 
            ["|", "_", " "], 
            ["|", "_", " "], 
            ["|", "_", "|"], 
            [" ", "_", " "], 
            [" ", " ", "|"], 
            [" ", "_", "|"]
          ]
        ]) }
    
      it "builds the invoice number with the word 'ILLEGAL' at the end" do
        subject.build.should == "010220?13 ILLEGAL"
      end
    end

  end

end