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
    @gameboard.fill_board
    load_saved_game
    loop do
      @gameboard.board.iterate_board(&:delete_moves)
      @gameboard.board.make_moves
      play
      break if game_end
    end
  end

  def play
    swap_colour
    puts "#{@colour}'s turn"
    make_a_move
    @gameboard.board.display_board
  end

  def make_a_move
    move = method1
    return if move.nil?

    if move && @gameboard.possible_move(move, @colour)
      return @gameboard.move_piece(move)
    end

    puts 'move not possible'
    make_a_move
  end

  def possible_move(move)
    loop do
      return move if @gameboard.possible_move(move, @colour)

      puts 'Move is not possible please try again'
      move = user_input
    end
  end
  
  def swap_colour
    @colour = @colour != 'WHITE' ? 'WHITE' : 'BLACK'
  end

  def save_a_game
    puts 'You are about to save your game, do you want to continue'
    puts '1. yes 2. No'
    return unless gets.chomp.to_i == 1

    puts 'input the name of your save file'
    save_game
  end

  def load_saved_game
    puts 'Do you want to load a saved game'
    puts '1. yes 2. No'
    return unless gets.chomp.to_i == 1

    swap_colour
    load_game
    puts 'game has been loaded'
    @gameboard.board.display_board
  end

  def game_end
    check = @gameboard.board.check
    if check
      @gameboard.board.mate(check) ? true : check
    elsif @gameboard.board.stalemate(@colour)
      return true
    end
    false
  end

end

game = Game.new
game.start