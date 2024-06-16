require_relative 'gameboard'
require_relative 'input'
require_relative 'database'

# Start and play the Game
class Game
  include Input
  include Database

  def initialize(gameboard = GameBoard.new)
    @gameboard = gameboard
    @colour = nil
  end

  def introduction
    puts 'Welcome to command Line chess'
  end

  def start
    introduction
    load_game
    play unless game_end

  end

  def play
    swap_colour
    puts "#{@colour}'s turn"
    move = user_input
    board.move_piece(move) if possible_move(move)
  end

  def possible_move(move)
    @gameboard.possible_move(move)
  end

end