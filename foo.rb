class InvoiceParser

  def initialize(input_txt_file_path)
    @file_to_parse = File.open(input_txt_file_path)
  end

  def bar
    "yo"
  end
end