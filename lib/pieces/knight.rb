class Knight
  def initialize(colour, row, column)
    @colour = colour
    @symbol = symbol_checker(colour)
    @row = row
    @column = column
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2658" : "\u265E"
  end

  def change_moves
    x = @row
    y = @column
    arr = []
    [[2, 1], [-2, -1]].each do |i, j|
      arr.push([x + i, y + j], [x + j, y + i])
      arr.push([x + i, y - j], [x + j, y - i])
    end
    arr
  end
end