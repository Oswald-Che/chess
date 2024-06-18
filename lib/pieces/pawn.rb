require_relative 'piece'

# class to hold pawn information
class Pawn < Piece

  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2659" : "\u265F"
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
    [[row + i, col + i], [row + i, col - i]].each do |move|
      @moves << move unless yield(move)
    end
  end
end
