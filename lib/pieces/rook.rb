require_relative 'piece'

# class for rook piece
class Rook
  def create_moves
    moves = []
    row, col = @pos
    8.times do |i|
      moves << [row + i, col]
      moves << [row, col + i]
    end
    moves - [@data]
  end
end