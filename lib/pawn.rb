class Pawn
  def initialize(colour)
    @colour = colour
    @symbol = symbol_checker(colour)
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2659" : "\u265F"
  end
end