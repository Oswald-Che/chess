a = Dir.pwd
Dir["#{a}/lib/pieces/*.rb"].sort.each { |file| require file }
class Board
  def initialize
    @board_array = Array.new(8) { Array.new(8, ' ')}
  end

  def fill_board
    @board_array[0][0] = Rook.new('White', 0, 0)
    @board_array[0][7] = Rook.new('White', 0, 0)
    @board_array[0][1] = Knight.new('white', 0, 1)
    @board_array[0][6] = Knight.new('white', 0, 6)
    @board_array[0][2] = Bishop.new('white', 0, 2)
    @board_array[0][5] = Bishop.new('white', 0, 5)
    @board_array[0][3] = Queen.new('white', 0, 3)
    @board_array[0][4] = Queen.new('white', 0, 3)
    @board_array[1].map!.with_index do |_item, i|
      Pawn.new('white', 1, i)
    end
  end
end

board = Board.new
board.fill_board
b =5