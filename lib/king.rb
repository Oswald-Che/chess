class King
  def initialize(colour)
    @colour = colour
    @symbol = symbol_checker(colour)
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2654" : "\u265A"
  end
end