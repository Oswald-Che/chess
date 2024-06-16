require_relative 'fix_moves'
# class to store all game pieces
class Board
  include FixMoves
  attr_reader :empty, :board

  def initialize(empty = '_')
    @empty = empty
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

  def make_moves
    @board.each do |row|
      row.each do |piece|
        next if piece == empty

        fix_moves(piece, @board)
        pawn_capture(piece) if piece.name == 'pawn'
      end
    end
  end

  def pawn_capture(pawn)
    pawn.capture_moves do |row, col|
      board[row][col].nil? || board[row][col] == empty
    end
  end

  def move_piece(move)
    row, col = move[0]
    piece = @board[row][col]
    update_baord(move[1], piece)
    @board[row][col] = empty
    piece.update_position(move[1])
  end
end