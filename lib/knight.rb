class Knight
  def initialize(colour)
    @colour = colour
    @symbol = symbol_checker(colour)
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2658" : "\u265E"
  end
end