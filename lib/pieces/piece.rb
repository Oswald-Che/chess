# super class to store chess piece information
class Piece
  attr_reader :pos, :colour, :symbol, :moved, :moves

  def initialize(pos, colour, moved = false)
    @pos = pos
    @colour = colour.upcase
    @symbol = piece_symbol(colour)
    @moves = []
    @moved = moved
  end

  def update_position(pos)
    @pos = pos
    @moved = true
  end

  def name
    self.class.name.downcase
  end

  def add_moves
    moves = create_moves
    moves.each do |move|
      @moves << move if yield(move)
    end
  end

  def delete_moves
    @moves = []
  end

  def piece_symbol(colour) end

  def create_moves() end
end
