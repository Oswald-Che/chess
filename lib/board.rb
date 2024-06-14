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
      piece_moves(piece, row, col) if board[row][col] != empty
    end
  end

  def piece_moves(piece, row, col)
    case piece.name.downcase
    when 'queen', 'rook', 'bishop', 'pawn'
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
  def line_move(piece, move)
    bool = true
    matches = find_match(piece)
    matches.each do |match|
      return false unless same_line?(move, match, piece.pos) && between?(move, match, piece.pos)

      if match == move
        bool = piece.colour != board[match[0]][match[1]].colour
        return false if piece.name.downcase == 'pawn'
      end

    end
    bool
  end

  # check if move and match are on the line
  def same_line?(move, match, piece)
    ((move[0] - match[0]).abs == (move[1] - match[1]).abs || move[0] == match[0] || move[1] == match[1]) &&
      !between?(piece, match, move)
  end

  # check if move is between piece and match
  def between?(move, match, piece)
    move[0] == match[0] ? include?(move[1], match[1], piece[1]) : include?(move[0], match[0], piece[0])
  end

  def include?(num1, num2, num3)
    arr = [num2, num3].sort
    (arr[0]...arr[1]).include?(num1)
  end

  # find all possible psotion in which the moves of a piece passing over another piece
  def find_match(piece, match = [])
    piece.create_moves.each do |row, col|
      match << [row, col] if board[row][col] != empty
    end
    match
  end
end