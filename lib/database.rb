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

  def make_save
    save_array = []
    @gameboard.board.each do |piece|
      next(save_array << piece) if piece == @gameboard.empty

      save_array << {
        name: piece.name,
        pos: piece.pos,
        colour: piece.colour
      }
    end
    save_array
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
    load_array = load_save(input_save)
    @gameboard.board = []
    load_array.each do |piece|
      gameboard.board << piece if piece == gameboard.empty

      @gameboard.update(piece[:name], piece[:pos], piece[:colour])
    end
  end
end