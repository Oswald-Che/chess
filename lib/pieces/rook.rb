class Rook
  def initialize(colour, row, column)
    @colour = colour
    @symbol = symbol_checker(colour)
    @row = row
    @column = column
    @original_postion = true
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2656" : "\u265C"
  end

  def change_moves
    arr = []
    5.times do |i|
      x = i - @row
      y = i - @column
      arr << [@row + x, @column]
      arr << [@row, @column + y]
    end
    arr - [[@row, @column]]
  end
end