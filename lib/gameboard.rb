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
end

