module Input
  def user_input
    input = player_input
    special_input if %w[castle ep].include?(input)
    return convert(input) if check_input(input)

    puts 'Input error make sure your input follows smith'
    user_input
  end

  def check_input(input)
    input = input[0..4]
    input.match?(/[a-h][1-8][a-h][1-8]/)
  end

  def convert_input(input)
    input = input.split('')[0..3]
    input.map! do |i|
      i = i.ord - 65 unless i.match?(/\d/)
      i.to_i - 1
    end
    start = input.first(2)
    move = input.last(2)
    [start, move]
  end

  def special_input() end

  def player_input
    gets.chomp
  end
end