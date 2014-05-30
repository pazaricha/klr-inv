require_relative "../helper_vars"
require_relative "number_builder"

class InvoiceParser

  attr_reader :input_file
  attr_accessor :output_invoice_numbers

  def initialize(input_file_path)
    @input_file = File.open(input_file_path)
    @current_disassembled_invoice_rows = []
    @output_invoice_numbers = []
  end

  def parse
    input_file.each_with_index do |line, index| 
      next if reached_separator_line?(index)

      collect_invoice_row_from_line(line)
      if finished_reading_single_invoice_rows?
        parse_and_collect_invoice_number
        reset_temp_vars!
      end
    end
    output_invoice_numbers.join
  end

  private

  def reached_separator_line?(index)
    (index + 1) % 4 == 0
  end

  def collect_invoice_row_from_line(line)
    @current_disassembled_invoice_rows << disassemble_line_to_groups_of_3_chars(line)
  end

  def disassemble_line_to_groups_of_3_chars(line)
    line.gsub("\n", "").scan(/./).each_slice(3)
  end

  def finished_reading_single_invoice_rows?
    @current_disassembled_invoice_rows.length == 3
  end

  def build_invoice_number
    NumberBuilder.new(@current_disassembled_invoice_rows).build
  end

  def parse_and_collect_invoice_number
    invoice_number = build_invoice_number
    if input_file.eof?
      @output_invoice_numbers << invoice_number
    else
      @output_invoice_numbers << invoice_number + "\n"
    end
  end

  def reset_temp_vars!
    @current_disassembled_invoice_rows = []
  end

end