# class to store all game pieces
class Board
  attr_reader :empty, :board

  def initialize
    @empty = '_'
    @board = Array.new(8) { Array.new(8, @empty) }
  end

  def display
    board.reverse.each do |row|
      puts row.join('')
    end
  end

  def update_board(pos, piece)
    row, col = pos
    @board[row][col] = piece
    piece.update_position(pos)
  end
end