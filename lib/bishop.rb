class Bishop
  def initialize(colour)
    @colour = colour
    @symbol = symbol_checker(colour)
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2657" : "\u265D"
  end
end