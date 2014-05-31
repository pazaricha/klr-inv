require_relative "helper_vars"
require "#{$PROJECT_ROOT}/lib/invoice_parser"


raise "Please provide the an input file name.\ni.e. \"my_input_file.txt\" " if ARGV.empty?

begin 
  
  input_file_name = ARGV[0].strip
  output_file_name = "#{input_file_name.gsub(".txt", "")}_parsed.txt"

  puts "Parsing file #{input_file_name} ..."
  invoice_parser = InvoiceParser.new("#{$PROJECT_ROOT}/input_files/#{input_file_name}")
  invoice_parser.parse

  puts "Writing output file to /output_files/#{output_file_name}"
  invoice_parser.write_output_file("#{$PROJECT_ROOT}/output_files/#{output_file_name}")

  puts "Done!"

rescue => e
  raise "Parsing failed. Error: #{e}"
end