# class to store all game pieces
class Board
  attr_reader :empty, :board

  def initialize
    @empty = '_'
    @board = Array.new(8) { Array.new(8, @empty) }
  end

  def display_board
    board.reverse.each do |row|
      row.each do |piece|
        piece == empty ? print("#{empty} ") : print("#{piece.symbol} ")
      end
      print "\n"
    end
  end

  def fill(first_piece, second_piece = nil)
    pos = first_piece.pos
    update_board(pos, first_piece)
    fill(second_piece) unless second_piece.nil? # useless recursion to avoid repititon
  end

  def update_board(pos, piece)
    row, col = pos
    @board[row][col] = piece
  end
end