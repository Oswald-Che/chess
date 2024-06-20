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
    load_saved_game
    play unless game_end

  end

  def play
    swap_colour
    puts "#{@colour}'s turn"
    move = user_input
    board.move_piece(move) if possible_move(move)
    @gameboard.board.display_board
  end

  def possible_move(move)
    loop do
      return move if @gameboard.possible_move(move)

      puts 'Move is not possible please Try again'
      move = user_input
    end
  end

  def save_a_game
    puts 'You are about to save your game, do you want to continue'
    puts '1. yes 2. No'
    return unless gets.chomp.to_i == 1

    puts 'input the name of your save'
  end

  def load_saved_game
    puts 'Do you want to load a saved game'
    puts '1. yes 2. No'
    return unless gets.chomp.to_i == 1

    load_game
  end

end