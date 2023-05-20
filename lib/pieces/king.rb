class King
  def initialize(colour, row, column)
    @colour = colour
    @row = row
    @column = column
    @symbol = symbol_checker(colour)
    @moves = []
    @original_postion = true
  end

  def symbol_checker(colour)
    colour == 'white' ? "\u2654" : "\u265A"
  end

  def change_moves
    x = @row
    y = @column
    arr = []
    [1, -1].each do |i|
      a.push([x + i, y], [x, y + i])
      a.push([x + i, y + i], [x + i, y - 1])
    end
    arr
  end
end