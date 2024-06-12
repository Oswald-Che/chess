require_relative 'piece'

# test for pawn piece
class Pawn < Piece

  def piece_symbol(colour)
  end

  def create_moves
    row, col = @pos
    i = colour != 'WHITE' ? -1 : 1
    return [[row + i, col], [row + (i + i), col]] unless moved

    [[row + i, col]]
  end

  def capture_moves
    row, col = @pos
    i = colour != 'WHITE' ? -1 : 1
    [[row + i, col + i], [row + i, col - i]]
  end
end
