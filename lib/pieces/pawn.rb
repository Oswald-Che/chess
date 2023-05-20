class Pawn
  def initialize(colour, row, column)
    @colour = colour
    @symbol = symbol_checker(colour)
    @row = row
    @column = column
    @original_postion = true
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2659" : "\u265F"
  end

  def change_moves
    if @original_postion == true
      [[@row + 1, @column], [@row + 2, @column]]
    else
      [[@row + 1, column]]
    end
  end
end