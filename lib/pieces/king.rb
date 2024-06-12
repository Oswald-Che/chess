require_relative 'piece'
# class to store king chess piece information
class King < Piece
  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2654" : "\u265A"
  end

  def create_moves
    move = []
    [-1, 1].each do |i|
      row, col = @data
      move << [row + i, col]
      move << [row, col + i]
      move << [row + i, col + i]
      move << [row + i, col - i]
    end
    move - [@data]
  end
end