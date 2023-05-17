class Rook
  def initialize(colour)
    @colour = colour
    @symbol = symbol_checker(colour)
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2656" : "\u265C"
  end
end