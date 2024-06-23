require_relative 'piece'

# class to hold pawn information
class Pawn < Piece

  def piece_symbol(colour)
    colour == 'WHITE' ? "\u2659" : "\u265F"
  end

  def create_moves
    row, col = @pos
    i = colour != 'WHITE' ? -1 : 1
    return [[row + i, col], [row + (i + i), col]] unless moved

    [[row + i, col]]
  end

  def capture_moves
    row, col = @pos
    i = colour != 'WHITE' ? -1 : 1
    [[row + i, col + i], [row + i, col - i]].each do |move|
      @moves << move unless yield(move)
    end
  end

  def promotion?(move)
    pos[0] == 7 || pos[0] == 0
  end

  def ask_promotion
    pieces = piece_hash
    puts 'pawn is about to be promoted please select a piece to promote to'
    puts "1. #{pieces['1']} 2. #{pieces['2']} 3. #{pieces['3']} 4. #{pieces['4']}" 
    piece = get_piece
    pieces[piece]
  end

  def piece_hash
    {
      '1' => 'queen',
      '2' => 'rook',
      '3' => 'bishop',
      '4' => 'knight'
    }
  end

  def get_piece
    input = gets.chomp
    return input if input.match?(/^[1-4]$/)

    puts 'input a number from 1 to 4'
    get_piece
  end
end
