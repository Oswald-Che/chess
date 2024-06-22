require 'json'
# save and load game files
module Database

  def save_game
    Dir.mkdir 'save' unless Dir.exist? 'save'
    input_filename = gets.chomp
    filename = "#{input_filename}.json"
    File.open("save/#{filename}", 'w') do |file|
      file.puts JSON.dump(make_save)
    end
  end

  def make_save(save_hash = {}, save_array = [])
    save_hash[:history] = @gameboard.history
    save_hash[:colour] = @colour
    @gameboard.board.each do |piece|
      next(save_array << piece) if piece == @gameboard.empty

      save_array << convert_board(piece)
    end
    save_hash[:board] = save_array
  end

  def convert_board(piece)
    {
      name: piece.name,
      pos: piece.pos,
      colour: piece.colour,
      moved: piece.moved
    }
  end

  def load_save(filename, load_array = nil)
    File.open("save/#{filename}.json", 'r') do |file|
      load_array = JSON.load(file)
    end
    load_array
  end

  def input_save
    file_list = Dir.entries('save').select { |f| File.file? f }
    puts 'input name of save you want to load'
    puts "Available saves are \n#{file_list}"
    filename = gets.chomp
    return filename if file_list.include?(filename)

    puts 'Save file not found, Please input an available file'
    input_save
  end

  def load_game
    load_hash = load_save(input_save)
    history = load_hash(:history)
    board = load_hash[:board].map do |piece|
      next(piece) if piece == @gameboard.empty

      check_piece(piece[:name], piece[:pos], piece[:colour], piece[:moved])
    end
    board = board.each_slice(8).to_a
    @gameboard.update_baord(board, history)
    @colour = load_hash[:colour]
  end
end