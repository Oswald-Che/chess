require_relative 'piece'

# class for rook piece
class Rook < Piece
  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2656" : "\u265C"
  end

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