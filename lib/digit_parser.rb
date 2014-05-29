class DigitParser
  
  attr_reader :digit_pattern

  def initialize(digit_pattern)
    @digit_pattern = digit_pattern  
  end
  
  def parse
    case digit_pattern
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