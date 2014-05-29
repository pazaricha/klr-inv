require_relative "helper_vars"

class InvoiceParser

  attr_reader :input_file
  attr_accessor :output_file

  def initialize(input_file_name, output_file_name)
    @input_file = File.open("#{$PROJECT_ROOT}#{input_file_name}")
    @output_file = File.open("#{$PROJECT_ROOT}#{output_file_name}", "w")
    @temp_final_invoice_number = []
    @temp_disassembled_invoice_number_lines = []
    @temp_invoice_digits_hash = {
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

  def parse
    input_file.each_with_index do |line, index| 
      next if reached_clearing_line?(index)

      collect_invoice_row_from_line(line)
      if finished_reading_single_invoice_number?
        write_invoice_number_to_output_file
      end
    end
    output_file.close
  end

  def reached_clearing_line?(index)
    (index + 1) % 4 == 0
  end

  def collect_invoice_row_from_line(line)
    @temp_disassembled_invoice_number_lines << disassemble_line_to_groups_of_3_chars(line)
  end

  def disassemble_line_to_groups_of_3_chars(line)
    line.gsub("\n", "").scan(/./).each_slice(3).to_a
  end

  def finished_reading_single_invoice_number?
    @temp_disassembled_invoice_number_lines.length == 3
  end

  def build_invoice_digits_hash
    @temp_disassembled_invoice_number_lines.each do |disassembled_line|
      disassembled_line.each_with_index do |digit_part, index|
        @temp_invoice_digits_hash["digit_#{index + 1}"] << digit_part
      end
    end
  end

  def generate_invoice_number
    @temp_invoice_digits_hash.each do |digit_key, digit_value|
      @temp_final_invoice_number << recognize_digit(digit_value)
    end
    get_final_invoice_number(@temp_final_invoice_number.join)
  end

  def get_final_invoice_number(invoice_number)
    if ilegal_invoice_number?(invoice_number)
      invoice_number + " ILLEGAL"
    else
      invoice_number
    end
  end

  def ilegal_invoice_number?(invoice_number)
    invoice_number.include? "?"
  end

  def write_invoice_number_to_output_file
    build_invoice_digits_hash
    invoice_number = generate_invoice_number

    if input_file.eof?
      output_file.write(invoice_number)
    else
      output_file.write(invoice_number + "\n")
    end

    reset_temp_vars!
  end

  def recognize_digit(digit_array)
    case digit_array.join
    when /^ _ \| \|\|_\|$/ 
      "0"
    when /^     \|  \|$/ 
      "1"
    when /^ _  _\|\|_ $/ 
      "2"
    when /^ _  _\| _\|$/ 
      "3"
    when /^   \|_\|  \|$/ 
      "4"
    when /^ _ \|_  _\|$/ 
      "5"
    when /^ _ \|_ \|_\|$/ 
      "6"
    when /^ _   \|  \|$/ 
      "7"
    when /^ _ \|_\|\|_\|$/ 
      "8"
    when /^ _ \|_\| _\|$/ 
      "9"
    else
      "?"
    end
      
  end

  def reset_temp_vars!
    @temp_disassembled_invoice_number_lines = []
    @temp_final_invoice_number = []
    @temp_invoice_digits_hash = {
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

end