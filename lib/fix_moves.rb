# module to recieve board and adjust the moves of all board pieces
module FixMoves

  # iterate through each move being made and remove unwanted moves
  def fix_moves(piece, board)
    piece.add_moves do |move|
      piece_moves(piece, move, board)
    end
  end

  def piece_moves(piece, move, board)
    case piece.name.downcase
    when 'queen', 'rook', 'bishop', 'pawn'
      line_move(piece, move, board)
    when 'king', 'knight'
      single_move(piece, move, board)
    end
  end

  # checks if move of piece falls on allied or oppenents piece
  # returns true or false base on result
  def single_move(piece, move, board)
    return true if board[move[0]][move[1]] == empty

    board[move[0]][move[1]].colour != piece.colour
  end

  # takes each move and checks checks if move falls between its piece and another piece
  # returns result
  def line_move(piece, move, board)
    bool = true
    matches = find_match(piece, board)
    matches.each do |match|
      next unless same_line?(move, match, piece.pos)

      return false if between?(match, piece.pos, move)

      if match == move
        bool = piece.colour != board[match[0]][match[1]].colour
        return false if piece.name.downcase == 'pawn'
      end

    end
    bool
  end

  # check if move and match are on the line
  def same_line?(move, match, piece)
    (same_daigonal(move, match, piece) || same_straight(move, match, piece)) &&
      !between?(piece, match, move)
  end

  def same_daigonal(move, match, piece)
    (move[0] - match[0]).abs == (move[1] - match[1]).abs &&
      (move[0] - piece[0]).abs == (move[1] - piece[1]).abs
  end

  def same_straight(move, match, piece)
    move[0] == match[0] && move[0] == piece[0] ||
      move[1] == match[1] && move[1] == piece[1]
  end

  # check if move is between piece and match
  def between?(move, match, piece)
    move[0] == match[0] ? include?(move[1], match[1], piece[1]) : include?(move[0], match[0], piece[0])
  end

  def include?(num1, num2, num3)
    add = num2 < num3 ? -1 : 1
    num3 += add
    arr = [num2, num3].sort
    (arr[0]..arr[1]).include?(num1)
  end

  # find all possible psotion in which the moves of a piece passing over another piece
  def find_match(piece, board, match = [])
    piece.create_moves.each do |row, col|
      match << [row, col] if board[row][col] != empty
    end
    match
  end
end