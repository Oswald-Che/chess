require_relative 'piece'

# class for knight piece
class Knight
  def create_moves
    moves = []
    kinght_deltas.each do |delta|
      move = [@pos, delta].transpose.map(&:sum)
      moves << move if move.all? { |i| i.between?(0, 7) }
    end
    moves
  end

  def kinght_deltas
    [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [2, -1], [-1, 2], [-2, 1]].sort
  end
end