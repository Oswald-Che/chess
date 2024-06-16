require_relative 'gameboard'
require_relative 'input'
require_relative 'database'

# Start and play the Game
class Game
  include Input
  include Database

  def initialize(gameboard = GameBoard.new)
    @game_board = gameboard
    @colour = nil
  end

  def introduction
    puts 'Welcome to command Line chess'
  end

  def play
    swap_colour
    puts "#{@colour}'s turn"
    input = user_input
    check_input
  end
end