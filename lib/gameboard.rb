Dir[File.join(__dir__, 'pieces', '*.rb')].sort.each { |file| require file }
require_relative 'board'
require_relative 'castle'

# class to organise all game pieces and the board
class GameBoard
  include Castling
  attr_reader :empty, :board, :history

  def initialize
    @empty = '_'
    @board = Board.new(empty)
    @history = []
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

  def update_gamebaord(board, history)
    @board.board = board
    @history = history
  end

  def check_piece(name, pos, colour, moved)
    case name
    when 'king' then King.new(pos, colour, moved)
    when 'queen' then Queen.new(pos, colour, moved)
    when 'rook' then Rook.new(pos, colour, moved)
    when 'bishop' then Bishop.new(pos, colour, moved)
    when 'knight' then Queen.new(pos, colour, moved)
    when 'pawn' then Pawn.new(pos, colour, moved)
    end
  end

  def possible_move(move, colour)
    row, col = move[0]
    piece = @board.board[row][col]
    return false if piece == empty || piece.colour != colour

    piece.moves.include?(move[1])
  end

  def move_piece(move)
    update_history(move)
    @board.move_piece(move)
  end

  def update_history(move)
    piece = @board.board[move[0][0]][move[0][1]]
    @history << {
      name: piece.name,
      colour: piece.colour,
      prev_pos: move[0],
      pos: move[1]
    }
  end

  def en_passant?(move)
    return false if @history == []

    piece = history.last
    piece[:name] == 'pawn' &&
      (piece[:prev_pos][0] - piece[:pos][0]).abs == 2 &&
      (move[1] - piece[:pos][1]).abs == 1
  end

  def en_passant_move(move)
    piece = @history.last[:pos]
    move_piece(move)
    board.board[piece[0]][piece[1]] = empty
  end

  def castling_move(king_move, type)
    rook_move = rook_castle_move(king_move[0], type)
    move_piece(king_move)
    move_piece(rook_move)
  end
end
