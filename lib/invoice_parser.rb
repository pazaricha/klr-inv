require_relative "../helper_vars"
require_relative "number_builder"

class InvoiceParser

  attr_reader :input_file
  attr_accessor :output_file

  def initialize(input_file_name, output_file_name)
    @input_file = File.open("#{$PROJECT_ROOT}#{input_file_name}")
    @output_file = File.open("#{$PROJECT_ROOT}#{output_file_name}", "w")
    @current_disassembled_invoice_rows = []
  end

  def parse
    input_file.each_with_index do |line, index| 
      next if reached_separator_line?(index)

      collect_invoice_row_from_line(line)
      if finished_reading_single_invoice_rows?
        write_invoice_number_to_output_file
        reset_temp_vars!
      end
    end
    output_file.close
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

  def write_invoice_number_to_output_file
    invoice_number = build_invoice_number

    if input_file.eof?
      output_file.write(invoice_number)
    else
      output_file.write(invoice_number + "\n")
    end
  end

  def reset_temp_vars!
    @current_disassembled_invoice_rows = []
  end

end