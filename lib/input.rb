module Input

  def method1
    input = user_input
    types = input[4..].split('')
    move = convert_input(input)
    types.each { |type| return nil if method2(move, type) }

    move
  end

  def method2(move, type)
    case type
    in 'e' | 'E' then ep(move)
    in 'c'| 'C' then castle(moves, type)
    in 'P, Q, R, B' then promotion(moves)
    else false
    end
  end

  def ep(move)
    unless @gameboard.en_passant?(move[1])
      puts 'en passant is not possible at this moment, Please enter another move'
      method1
    end

    @gameboard.en_passant_move(move)
  end

  def castle(move, type)
    unless a_castle?(move, type) && @gameboard.check_castling(type, @colour)
      puts 'castling is not possible at this moment try another move'
      method1
    end

    @gameboard.castling_move(move, type)
  end

  def a_castle?(move, type)
    num = type == 'c' ? 2 : -2
    row = @colour == 'WHITE' ? 0 : 7
    move[0] == [row, 4] && move[1] == [row, 4 + num] 
  end


  def user_input
    input = player_input
    special_input(input) if %w[save help].include?(input)
    return input if check_input(input)

    puts 'Input error make sure your input follows smith\'s notation'
    user_input
  end

  def check_input(input)
    input.downcase.match?(/^[a-h][1-8][a-h][1-8][^\d]?[^\d]?$/)
  end

  def convert_input(input)
    input = input.split('')[0..3]
    input.map! do |i|
      i = i.ord - 96 unless i.match?(/\d/)
      i.to_i - 1
    end
    start = input.first(2).reverse
    move = input.last(2).reverse
    [start, move]
  end

  def special_input() end

  def player_input
    gets.chomp
  end
end