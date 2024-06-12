require_relative 'piece'

# class for queen piece
class Queen < Piece

  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2655" : "\u265B"
  end

  def create_moves
    moves = []
    row, col = @pos
    8.times do |i|
      y = i - row
      moves << [row + y, col]
      moves << [row, col + i - col]
      [[row + y, col + y], [row + y, col - y]].each do |move|
        moves << move if move.all? { |i| i.between?(0, 7) }
      end
    end
    moves - [@pos]
  end
end