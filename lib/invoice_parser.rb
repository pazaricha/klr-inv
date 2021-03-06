require_relative "../helper_vars"
require_relative "invoice_number_builder"

class InvoiceParser

  attr_reader :output_invoice_numbers

  def initialize(input_file_path)
    @input_file = File.open(input_file_path)
    @output_invoice_numbers = []
    @current_disassembled_invoice_rows = []
    @current_invoice_number = ""
  end

  def parse
    @input_file.each_with_index do |line, index| 
      next if reached_separator_line?(index)

      collect_invoice_row_from_line(line)
      if finished_reading_single_invoice_rows?
        parse_and_collect_invoice_number
        reset_temp_vars!
      end
    end
  end

  def write_output_file(output_file_path)
    File.open(output_file_path, "w") do |file|
      file.write(@output_invoice_numbers.join)
      file.close
    end
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
    @current_invoice_number = InvoiceNumberBuilder.new(@current_disassembled_invoice_rows).build
  end

  def parse_and_collect_invoice_number
    build_invoice_number
    if @input_file.eof?
      @output_invoice_numbers << @current_invoice_number
    else
      @output_invoice_numbers << @current_invoice_number + "\n"
    end
  end

  def reset_temp_vars!
    @current_disassembled_invoice_rows = []
    @current_invoice_number = ""
  end

end