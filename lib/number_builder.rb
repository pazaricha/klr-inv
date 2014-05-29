require_relative "digit_parser"
require_relative "number_regulator"

class NumberBuilder

  attr_reader :invoice_number_rows
  attr_accessor :invoice_number_digits

  def initialize(invoice_number_rows)
    @invoice_number_rows = invoice_number_rows
    @invoice_number_digits = {
      "digit_1" => [],
      "digit_2" => [],
      "digit_3" => [],
      "digit_4" => [],
      "digit_5" => [],
      "digit_6" => [],
      "digit_7" => [],
      "digit_8" => [],
      "digit_9" => []
    }
  end

  def build
    populate_digit_hash
    build_invoice_number
  end

  private 

  def populate_digit_hash
    invoice_number_rows.each do |line|
      line.each_with_index do |digit_part, index|
        invoice_number_digits["digit_#{index + 1}"] << digit_part
      end
    end
  end

  def build_invoice_number
    invoice_number_array = invoice_number_digits.inject([]) do |invoice_number, digit|
      invoice_number << DigitParser.new(digit.last.join).parse
    end

    NumberRegulator.new(invoice_number_array.join).regulate
  end
  
end