# class to store all game pieces
class Board
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

  def make_move
    @board.each do |row|
      row.each do |piece|
        next if piece == empty

        fix_moves(piece)
      end
    end
  end

  # iterate through each move being made and remove unwanted moves
  def fix_moves(piece)
    piece.add_moves do |row, col|
      return piece_moves(piece, row, col) if board[row][col] != empty

      false
    end
  end

  def piece_moves(piece, row, col)
    case piece.name.downcase
    when 'queen', 'rook', 'bishop'
      line_move(piece, row, col)
    when 'king', 'knight'
      single_move(piece, row, col)
    end
  end

  # checks if move of piece falls on allied or oppenents piece
  # returns true or false base on result
  def single_move(piece, row, col)
    board[row][col].colour != piece.colour
  end
  
  # takes each move and checks checks if move falls between its piece and another piece
  # returns result
  def line_move(piece, row, col)
    matches = find_match(piece)
    matches.each do |match|
      next unless same_line?(row, col, match) && between?(row, col, match, piece)

      return piece.colour == board[match[0]][match[1]].colour if match == [row, col]

      return true
    end
    false
  end

  # check if move and match are on the same diagonal
  def same_line?(row, col, match)
    (row - match[0]).abs == (col - match[1]) || row == match[0] || col == match[1]
  end

  # check if move is between piece and match
  def between?(row, col, match, piece)
    row.between?(match[0], piece.pos[0]) || col.between?[match[1], piece.pos[2]]
  end

  # find all possible psotion in which the moves of a piece passing over another piece
  def find_match(piece, match = [])
    piece.create_moves.each do |row, col|
      match << [row, col] if board[row][col] != empty
    end
    match
  end
end