class Queen
  attr_reader :colour, :moves
  
  def initialize(colour, row, column)
    @colour = colour
    @row = row
    @column = column
    @symbol = symbol_checker(colour)
    @moves = []
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2655" : "\u265B"
  end

  def change_moves
    arr = []
    8.times do |i|
      x = i - @row 
      y = i - @column
      arr << [@row + x, @column]
      arr << [@row, @column + y]
      arr << [@row + x, @column + x] if (@column + x).between?(0, 7)
      arr << [@row + x, @column - x] if (@column - x).between?(0, 7)
    end
    arr -= [[@row, @column]]
  end
end