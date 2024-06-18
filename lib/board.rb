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

  def fix_king_moves
    select_kings.each do |king|
      king.moves.each do |move|
        iterate_board do |piece|
          next unless piece.colour != king.colour && piece.moves.include?(move)

          king.remove_move(move)
          piece.remove_move(move) if piece.name == 'king'
        end
      end
    end
  end

  def select_kings(kings = [])
    iterate_board do |item|
      kings << item if item.name == 'king'
    end
    kings
  end

  def iterate_board
    board.flatten.each do |piece|
      next if piece == empty

      yield(piece)
    end
  end

  def move_piece(move)
    row, col = move[0]
    piece = @board[row][col]
    update_baord(move[1], piece)
    @board[row][col] = empty
    piece.update_position(move[1])
  end

  def check
    select_kings.each do |king|
      iterate_board do |piece|
        next if piece.colour == king.colour

        return king, piece if piece.moves.include?(king.pos)
      end
    end
    nil
  end

  def mate(array)
    king = array[0]
    return false if king.moves.any?

    iterate_board do |piece|
      next if piece.colour != king.colour
      return false if piece.moves.include?(array[1].pos)

      piece.moves.each do |move|
        return false unless method(move, array[1], king)
      end
    end
    true
  end

  def method(move, piece, king)
    return true if %w[knight pawn].include?(piece.name)

    !(same_line?(move, piece.pos, king.pos) && between?(move, piece.pos, king.pos))
  end

  def stalemate(colour)
    # colour has no moves and king is not in check
    iterate_board do |piece|
      next if piece.colour != colour

      return false if piece.moves.any?
    end
    true
  end
end