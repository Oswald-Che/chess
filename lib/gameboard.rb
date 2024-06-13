Dir[File.join(__dir__, 'pieces', '*.rb')].sort.each { |file| require file }
require_relative 'board'

# class to organise all game pieces and the board
class GameBoard
  attr_reader :empty

  def initialize()
    empty = '_'
    @board = Board.new(empty)
  end

  def fill_board
    add_pieces(0, 'WHITE')
    add_pieces(7, 'BLACK')
  end

  # adds all pieces to board in the correct order
  def add_pieces(num, colour)
    @board.fill(King.new([num, 4], colour))
    @board.fill(Queen.new([num, 3], colour))
    @board.fill(Rook.new([num, 0], colour), Rook.new([num, 7], colour))
    @board.fill(Bishop.new([num, 2], colour), Bishop.new([num, 5], colour))
    @board.fill(Knight.new([num, 1], colour), Knight.new([num, 6], colour))
    8.times do |i|
      @board.fill(Pawn.new([num + ((-1)**num), i], colour)) # changes starting row depending on the colour of piece
    end
  end

  def make_move
    @board.each do |row|
      row.each do |piece|
        next if piece == empty

        check_moves(piece)
      end
    end
  end

  def check_moves(piece)
    case piece.name.downcase
    when 'bishop', 'rook', 'queen' then diag_move
    when 'knight', 'king'
      normal(piece)
    else starting
    end
  end

  # checks if any piece is blocking the piece moves
  def normal(piece)
    piece.add_moves do |move|
      row, col = move
      item = @board[row][col]
      next(true) if item == empty || item.colour != piece.colour

      false
    end
  end

  def starting(pawn)
    pawn.add_moves do |move|
      row, col = move
      item = @board[row][col]
      next(true) if item == empty

      false
    end
  end

end

