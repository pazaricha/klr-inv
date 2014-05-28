class InvoiceParser

  attr_reader :input_file

  def initialize(input_txt_file_path)
    @input_file = File.open(input_txt_file_path)
  end

  def parse
    all_number = []
    final_number = []
    temp_invoice_number_array = []
    temp_digits = {
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

    input_file.each_with_index do |line, index|
      i = index + 1 
      if i % 4 == 0
        temp_invoice_number_array = []
      else
        temp_invoice_number_array << disassemble_line_to_groups_of_3_chars(line)

        if temp_invoice_number_array.length == 3
          
          temp_invoice_number_array.each do |disassembled_line|
            disassembled_line.each_with_index do |digit_part, index|
              temp_digits["#{index + 1}"] << digit_part
            end
          end

          temp_digits.each do |digit_number, digit_chars_array|
            final_number << recognize_digit(digit_chars_array)
          end
          all_numbers << final_number.join

        end
      end

    end
    all_numbers.join("\n")
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