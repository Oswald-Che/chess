# super class to store chess piece information
class Piece
  attr_reader :colour, :symbol, :data, :moved, :moves

  def initialize(pos, colour)
    @pos = pos
    @colour = colour
    @symbol = piece_symbol(colour)
    @moves = []
    @moved = false
  end

  def update_position(pos)
    @data = pos
  end

  def add_moves
    moves = create_moves
    moves.each do |move|
      @moves << move unless yield(move)
    end
  end

  def create_moves() end
end