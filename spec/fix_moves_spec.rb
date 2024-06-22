require './lib/board'
Dir[File.join(__dir__, '../lib/pieces', '*.rb')].sort.each { |file| require file }

# test for fix_module

describe Board do
  describe '#find_match' do
    context 'when piece is a rook' do
      let(:piece) { double('piece') }
      subject(:board_match) { described_class.new }

      before do
        moves = [[0, 1], [0, 2], [0, 3], [0, 4], [1, 0], [2, 0]]
        allow(piece).to receive(:create_moves).and_return(moves)
        board_match.board[2][0] = piece
        board_match.board[0][3] = piece
      end

      it 'retrun the correct matches' do
        match = [[0, 3], [2, 0]]
        board = board_match.board
        result = board_match.find_match(piece, board).sort
        expect(result).to eql(match)
      end
    end

    context 'when piece is a bishop' do
      let(:piece) { double('piece') }
      subject(:board_match) { described_class.new }

      before do
        moves = [[1, 2], [1, 4], [2, 1], [2, 5], [3, 0]]
        allow(piece).to receive(:create_moves).and_return(moves)
        board_match.board[2][5] = piece
        board_match.board[3][0] = piece
      end

      it 'retrun the correct matches' do
        match = [[2, 5], [3, 0]]
        board = board_match.board
        result = board_match.find_match(piece, board).sort
        expect(result).to eql(match)
      end
    end
  end

  describe '#between' do
    context 'when move is between is between' do
      subject(:board_between) { described_class.new }

      it 'retrun true' do
        match = [2, 0]
        piece = [5, 3]
        result = board_between.between?([3, 1], match, piece)
        expect(result).to be true
      end
    end

    context 'when move is between is between' do
      subject(:board_between) { described_class.new }

      it 'retrun true' do
        match = [4, 6]
        piece = [4, 3]
        result = board_between.between?([4, 4], match, piece)
        expect(result).to be true
      end
    end

    context 'when move is not between' do
      subject(:board_between) { described_class.new }

      it 'retrun true' do
        match = [4, 6]
        piece = [4, 3]
        result = board_between.between?([4, 0], match, piece)
        expect(result).to be false
      end
    end
  end

  describe '#single_moves' do
    context 'when piece is not the same colour' do
      subject(:board_single) { described_class.new }
      let(:piece) { double('piece') }
      let(:other_piece) { double('piece') }

      before do
        allow(piece).to receive(:colour).and_return('white')
        allow(other_piece).to receive(:colour).and_return('black')
        board_single.board[1][2] = other_piece
      end

      it 'return true' do
        move = [1, 2]
        board = board_single.board
        result = board_single.single_move(piece, move, board)
        expect(result).to be true
      end
    end 
  end

  describe '#same_line' do
    context 'when move and a match are on different lines' do
      subject(:board_same) { described_class.new }
      it 'returns false' do
        move = [1, 2]
        match = [4, 4]
        piece = [3, 4]
        expect(board_same.same_line?(move, match, piece)).to be false
      end
    end
    context 'when move and a match are on the same diagonal line' do
      subject(:board_same) { described_class.new }
      it 'returns true' do
        move = [1, 2]
        match = [2, 3]
        piece = [3, 4]
        expect(board_same.same_line?(move, match, piece)).to be true
      end
    end
    context 'when move and a match are on the same horizontal line' do
      subject(:board_same) { described_class.new }
      it 'returns true' do
        move = [3, 1]
        match = [3, 3]
        piece = [3, 4]
        expect(board_same.same_line?(move, match, piece)).to be true
      end
    end
    context 'when move and a match are on the same vertical line' do
      subject(:board_same) { described_class.new }
      it 'returns true' do
        move = [3, 3]
        match = [4, 3]
        piece = [1, 3]
        expect(board_same.same_line?(move, match, piece)).to be true
      end
    end

    context 'when move and a match are on the same vertical line but oppsoite piece' do
      subject(:board_same) { described_class.new }
      it 'returns false' do
        move = [3, 3]
        match = [1, 3]
        piece = [2, 3]
        expect(board_same.same_line?(move, match, piece)).to be false
      end
    end
    context 'when move and a match are on the same diagonal line but oppsoite piece' do
      subject(:board_same) { described_class.new }
      it 'returns false' do
        move = [3, 4]
        match = [1, 2]
        piece = [2, 3]
        expect(board_same.same_line?(move, match, piece)).to be false
      end
    end
  end


  describe '#line_move' do
    context 'when a move is given with no matchers' do
      subject(:board_line) { described_class.new }
      let(:piece) { double('piece') }

      before do
        pos = [1, 2] 
        allow(board_line).to receive(:find_match).and_return([])
        allow(piece).to receive(:pos).and_return(pos)
      end

      it 'returns true' do
        move = [0, 1]
        board = board_line.board
        expect(board_line.line_move(piece, move, board)).to be true
      end
    end
    context 'when a move is between piece and matcher ' do
      subject(:board_line) { described_class.new }
      let(:piece) { double('piece') }
      let(:other_piece) { double('piece') }

      before do
        pos = [3, 2]
        match = [[1, 0]]
        allow(board_line).to receive(:find_match).and_return(match)
        allow(piece).to receive(:pos).and_return(pos)
        allow(piece).to receive(:colour).and_return('white')
        allow(other_piece).to receive(:colour).and_return('white')
        board_line.board[1][0] = other_piece
      end

      it 'returns true' do
        move = [2, 1]
        board = board_line.board
        expect(board_line.line_move(piece, move, board)).to be true
      end
    end

    context 'when a move is not between piece and matcher ' do
      subject(:board_line) { described_class.new }
      let(:piece) { double('piece') }
      let(:other_piece) { double('piece') }

      before do
        pos = [3, 2]
        match = [[2, 1]]
        allow(board_line).to receive(:find_match).and_return(match)
        allow(piece).to receive(:pos).and_return(pos)
        allow(piece).to receive(:colour).and_return('white')
        allow(other_piece).to receive(:colour).and_return('white')
        board_line.board[1][0] = other_piece
      end

      it 'returns false' do
        move = [1, 0]
        board = board_line.board
        expect(board_line.line_move(piece, move, board)).to be false
      end
    end
    context 'when a move is  between two matchers' do
      subject(:board_line) { described_class.new }
      let(:piece) { double('piece') }
      let(:other_piece) { double('piece') }

      before do
        pos = [4, 3]
        match = [[1, 0], [3, 2]]
        allow(board_line).to receive(:find_match).and_return(match)
        allow(piece).to receive(:pos).and_return(pos)
        allow(piece).to receive(:colour).and_return('white')
        allow(other_piece).to receive(:colour).and_return('white')
        board_line.board[1][0] = other_piece
        board_line.board[3][2] = other_piece
      end

      it 'returns false' do
        move = [2, 1]
        board = board_line.board
        expect(board_line.line_move(piece, move, board)).to be false
      end
    end

    context 'when a move is on a matcher and after a matcher' do
      subject(:board_line) { described_class.new }
      let(:piece) { double('piece') }
      let(:other_piece) { double('piece') }

      before do
        pos = [4, 3]
        match = [[1, 0], [3, 2]]
        allow(board_line).to receive(:find_match).and_return(match)
        allow(piece).to receive(:pos).and_return(pos)
        allow(piece).to receive(:colour).and_return('white')
        allow(piece).to receive(:name).and_return('')
        allow(other_piece).to receive(:colour).and_return('white')
        board_line.board[1][0] = other_piece
        board_line.board[3][2] = other_piece
      end

      it 'returns false' do
        move = [1, 0]
        board = board_line.board
        expect(board_line.line_move(piece, move, board)).to be false
      end
    end

    context 'when a move is on a matcher and before a matcher' do
      subject(:board_line) { described_class.new }
      let(:piece) { double('piece') }
      let(:other_piece) { double('piece') }

      before do
        pos = [4, 3]
        match = [[1, 0], [3, 2]]
        allow(board_line).to receive(:find_match).and_return(match)
        allow(piece).to receive(:pos).and_return(pos)
        allow(piece).to receive(:colour).and_return('white')
        allow(piece).to receive(:name).and_return('')
        allow(other_piece).to receive(:colour).and_return('black')
        board_line.board[1][0] = other_piece
        board_line.board[3][2] = other_piece
      end

      it 'returns true' do
        move = [3, 2]
        board = board_line.board
        expect(board_line.line_move(piece, move, board)).to be true
      end
    end
  end

  describe '#fix_moves' do
    context 'when a rook is given and board is empty' do
      subject(:board_fix) { described_class.new }
      let(:piece) { Rook.new([0, 0], 'white') }

      it 'return all moves' do
        moves = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
                 [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
        board = board_fix.board
        board_fix.fix_moves(piece, board)
        result = piece.moves.sort
        expect(result).to eq(moves)
      end
    end

    context 'when a rook is given and it is surrounded by allied pieces' do
      subject(:board_fix) { described_class.new }
      let(:piece) { Rook.new([0, 0], 'white') }
      let(:other_piece) { double('piece') }

      before do
        board_fix.board[0][1] = other_piece
        board_fix.board[1][0] = other_piece
        allow(other_piece).to receive(:colour).and_return('WHITE')
      end
      it 'returns no moves' do
        moves = []
        board = board_fix.board
        board_fix.fix_moves(piece, board)
        result = piece.moves.sort
        expect(result).to eq(moves)
      end
    end
  end
end