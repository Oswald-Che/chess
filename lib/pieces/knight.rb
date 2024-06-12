require_relative 'piece'

# class for knight piece
class Knight < Piece
  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2658" : "\u265E"
  end

  def create_moves
    moves = []
    knight_deltas.each do |delta|
      move = [@pos, delta].transpose.map(&:sum)
      moves << move if move.all? { |i| i.between?(0, 7) }
    end
    moves
  end

  def knight_deltas
    [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [2, -1], [-1, 2], [-2, 1]].sort
  end
end