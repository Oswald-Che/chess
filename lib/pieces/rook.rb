require_relative 'piece'

# class for rook piece
class Rook < Piece
  def create_moves
    moves = []
    row, col = @pos
    8.times do |i|
      moves << [row + i - row, col]
      moves << [row, col + i - col]
    end
    moves - [@pos]
  end
end