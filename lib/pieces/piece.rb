# class to store chess piece information
class Piece
  attr_reader :colour, :symbol, :data, :moved, :moves

  def initialize(data, colour)
    @data = data
    @colour = colour
    @symbol = piece_symbol(colour)
    @moves = []
    @moved = false
  end
end