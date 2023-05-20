class Bishop
  def initialize(colour, row, column)
    @colour = colour
    @symbol = symbol_checker(colour)
    @row = row
    @column = column
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2657" : "\u265D"
  end

  def change_moves
    arr = []
    8.times do |i|
      x = i - @row
      arr << [@row + x, @column + x] if (@column + x).between?(0, 7)
      arr << [@row + x, @column - x] if (@column - x).between?(0, 7) 
    end
    arr -= [[@row, @column]]
  end
end