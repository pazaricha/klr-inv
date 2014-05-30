require_relative "helper_vars"
require "#{$PROJECT_ROOT}/lib/invoice_parser"


raise "Please provide the an input file name.\ni.e. \"my_input_file.txt\" " if ARGV.empty?

begin 
  input_file_name = ARGV[0].strip
  output_file_name = "#{input_file_name.gsub(".txt", "")}_parsed.txt"

  puts "Parsing file #{input_file_name} ..."
  parsed_invoices_numbers = InvoiceParser.new("#{$PROJECT_ROOT}/input_files/#{input_file_name}").parse
  puts "File #{input_file_name} parsed successfully!"

  puts "Writing output file to /output_files/#{output_file_name}"
  File.open("#{$PROJECT_ROOT}/output_files/#{input_file_name.gsub(".txt", "")}_parsed.txt", "w") do |file|
    file.write(parsed_invoices_numbers)
    file.close
  end
  puts "Done!"
rescue => e
  raise "Parsing failed. Error: #{e}"
end