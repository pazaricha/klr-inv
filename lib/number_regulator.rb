class NumberRegulator

  attr_reader :invoice_number

  def initialize(invoice_number)
    @invoice_number = invoice_number
  end

  def regulate
    if ilegal_invoice_number?(invoice_number)
      invoice_number + " ILLEGAL"
    else
      invoice_number
    end
  end

  private

  def ilegal_invoice_number?(invoice_number)
    invoice_number.include? "?"
  end
  
end