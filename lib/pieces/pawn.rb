require_relative 'piece'

# test for pawn piece
class Pawn < Piece
  def create_moves
    row, col = @data
    i = row > 1 ? -1 : 1
    return [[row + i, col], [row + (i + i), col]] if moved

    [[row + i, col]]
  end

  def capture_moves
    row, col = @data
    [[row + 1, col + 1], [row + 1, col - 1]]
  end
end
