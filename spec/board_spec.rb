require './lib/board'
Dir[File.join(__dir__, '../lib/pieces', '*.rb')].sort.each { |file| require file }

# test for board class

describe Board do
  
end