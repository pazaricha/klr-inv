require_relative "helper_vars"

class InvoiceParser

  attr_reader :input_file
  attr_accessor :output_file

  def initialize(input_file_name, output_file_name)
    @input_file = File.open("#{$PROJECT_ROOT}#{input_file_name}")
    @output_file = File.open("#{$PROJECT_ROOT}#{output_file_name}", "w")
    @temp_final_number_array = []
    @temp_invoice_number_array = []
    @temp_digits_hash = {
      "1" => [],
      "2" => [],
      "3" => [],
      "4" => [],
      "5" => [],
      "6" => [],
      "7" => [],
      "8" => [],
      "9" => []
    }
  end

  def parse
    input_file.each_with_index do |line, index|
      i = index + 1 
      if i % 4 == 0
        @temp_invoice_number_array = []
        @temp_final_number_array = []
        @temp_digits_hash = {
          "1" => [],
          "2" => [],
          "3" => [],
          "4" => [],
          "5" => [],
          "6" => [],
          "7" => [],
          "8" => [],
          "9" => []
        }
      else
        @temp_invoice_number_array << disassemble_line_to_groups_of_3_chars(line)

        if @temp_invoice_number_array.length == 3
          @temp_invoice_number_array.each do |disassembled_line|
            disassembled_line.each_with_index do |digit_part, index|
              @temp_digits_hash["#{index + 1}"] << digit_part
            end
          end

          @temp_digits_hash.each do |digit_number, digit_chars_array|
            @temp_final_number_array << recognize_digit(digit_chars_array)
          end
          if input_file.eof?
            output_file.write(@temp_final_number_array.join)
          else
            output_file.write(@temp_final_number_array.join + "\n")
          end

        end
      end

    end
    output_file.close
  end

  def disassemble_line_to_groups_of_3_chars(line)
    line.gsub("\n", "").scan(/./).each_slice(3).to_a
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


end