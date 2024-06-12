require_relative 'piece'
# class to store king chess piece information
class King < Piece
  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2654" : "\u265A"
  end

  def create_moves
    moves = []
    [-1, 1].each do |i|
      row, col = @pos
      [[row + i, col], [row, col + i], [row + i, col + i], [row + i, col - i]].each do |move|
        moves << move if move.all? { |i| i.between?(0, 7) }
      end
    end
    moves - [@data]
  end
end