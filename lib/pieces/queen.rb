require_relative 'piece'

# class for queen piece
class Queen < Piece
  def create_moves
    moves = []
    row, col = @pos
    8.times do |i|
      y = i - a
      moves << [row + i, col]
      moves << [row, col + i]
      [[row + y, col + y], [row + y, col - y]].each do |move|
        moves << move if move.all? { |i| i.between?(0, 7) }
      end
    end
    moves - [@pos]
  end
end