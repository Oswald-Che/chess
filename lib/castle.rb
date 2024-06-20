# module to chechk if castling is possible
module Castling
  def check_castling(move, type, colour)
    return false unless check_castle_move(move)

    row = colour == 'WHITE' ? 0 : 7 
    col = type == 'c' ? 0 : 7
    rook = @board.board[row][col]
    king = @board.board[row][4]
    !castling?(king, rook)
  end

  # check if all conditions for castling are met
  def castling?(king, rook)
    king == empty || rook == empty || piece_moved? || 
      @board.check.nil? || escape_check? || row_empty?
  end

  # check if either rook or king has moved within the game
  def piece_moved?(king, rook)
    king.moved || rook.moved
  end

  # check if a king is escaping a check by castling
  def escape_check?(king, rook)
    num = king.pos[1] > rook.pos[1] ? 2 : 6
    pos = generate_position(king.pos, num)
    pos.each do |position|
      iterate_board do |piece|
        next if piece.colour == king.colour

        true if piece.moves.include?(position)
        true if piece.name == 'pawn' && piece.capture_moves.include?(position)
      end
    end
    false
  end

  # check if space between king and rook is empty
  def row_empty?(king, rook)
    pos = generate_position(king.pos, rook.pos[1]) - [rook.pos]
    pos.each do |row, col|
      true if @board.board[row][col] != empty
    end
    false
  end
  
  # generate a set of position between two points on the same row
  def generate_position(pos, num)
    num1 = num > pos[1] ? 1 : -1
    var = (pos[1] - num).abs
    arr = []
    var.times do |i|
      i += 1
      arr << [pos[0], pos[1] + (i * num1)]
    end
    arr
  end

  # return the corresponding rooks moves during castling
  def rook_castle_move(move, type)
    rook_col = type == 'c' ? [7, 1] : [0, -2]
    row = [move[0], rook_col[0]]
    col = [move[0], move[1] + rook_col[1]]
    [row, col]
  end
end