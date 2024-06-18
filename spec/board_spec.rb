require './lib/board'
Dir[File.join(__dir__, '../lib/pieces', '*.rb')].sort.each { |file| require file }

# test for board class

describe Board do
  describe '#select_king' do
    subject(:board_select) { described_class.new }
    let(:king) { double('king') }

    before do
      allow(king).to receive(:name).and_return('king')
      board_select.board[0][1] = king
      board_select.board[4][1] = king
    end
  
    it 'returns kings' do
      answer = [king, king]
      expect(board_select.select_kings).to eq(answer)
    end
  end

  describe '#fix_king_moves' do
    context 'when king is same colour as selected piece' do
      subject(:board_fix_king) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', moves: [[0, 2], [1, 2]])}
      let(:other_piece) { double('piece') }

      before do
        board_fix_king.board[0][0] = other_piece
        allow(board_fix_king).to receive(:select_kings).and_return([king])
        allow(other_piece).to receive(:colour).and_return('white')
      end

      it 'doesn\' remove any move' do
        expect(king).not_to receive(:remove_move)
        board_fix_king.fix_king_moves
      end
    end

    context 'when king\' moves and opposing piece move intersect' do
      subject(:board_fix_king) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', moves: [[0, 2], [1, 2]])}
      let(:other_piece) { double('piece') }

      before do
        moves = [[0, 2], [1, 2], [2, 2]]
        board_fix_king.board[3][2] = other_piece
        allow(board_fix_king).to receive(:select_kings).and_return([king])
        allow(other_piece).to receive(:colour).and_return('black')
        allow(other_piece).to receive(:moves).and_return(moves)
        allow(other_piece).to receive(:name).and_return('not king')
      end

      it 'removes intersecting moves' do
        expect(king).to receive(:remove_move).with([1, 2])
        expect(king).to receive(:remove_move).with([0, 2])
        board_fix_king.fix_king_moves
      end
    end


    context 'when king\' moves and opposing king move intersect' do
      subject(:board_fix_king) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', moves: [[0, 2], [1, 2]])}
      let(:other_king) { double('king') }

      before do
        moves = [[1, 2], [2, 2]]
        board_fix_king.board[2][1] = other_king
        allow(board_fix_king).to receive(:select_kings).and_return([king])
        allow(other_king).to receive(:colour).and_return('black')
        allow(other_king).to receive(:moves).and_return(moves)
        allow(other_king).to receive(:name).and_return('king')
      end

      it 'removes intersecting moves' do
        expect(king).to receive(:remove_move).with([1, 2])
        expect(other_king).to receive(:remove_move).with([1, 2])
        board_fix_king.fix_king_moves
      end
    end
  end

  describe '#check' do
    context 'when king is same colour as selected piece' do
      subject(:board_check) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2])}
      let(:other_piece) { double('piece') }

      before do
        board_check.board[0][0] = other_piece
        allow(board_check).to receive(:select_kings).and_return([king])
        allow(other_piece).to receive(:colour).and_return('white')
      end

      it 'is not in check' do
        expect(board_check.check).to be_falsey
      end
    end

    context 'when king\'s position intersect with opposing piece move\'s intersect' do
      subject(:board_check) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2]) }
      let(:other_piece) { double('piece') }

      before do
        board_check.board[0][0] = other_piece
        moves = [[0, 1], [0, 2]]
        allow(board_check).to receive(:select_kings).and_return([king])
        allow(other_piece).to receive(:colour).and_return('black')
        allow(other_piece).to receive(:moves).and_return(moves)
      end

      it 'is a check' do
        expect(board_check.check).to be_truthy
      end
    end
  end

  describe '#mate' do
    context 'when king can move' do
      subject(:board_mate) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2], moves: [[0, 3]]) }
      let(:enemy_piece) { double('piece') }
      let(:ally_piece) { double('piece') }

      it 'is not mate' do
        expect(board_mate.mate([king, enemy_piece])).to be false
      end
    end

    context 'when ally piece can capture enemy piece' do
      subject(:board_mate) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2], moves: []) }
      let(:enemy_piece) { double('piece') }
      let(:ally_piece) { double('piece') }

      before do
        board_mate.board[0][0] = ally_piece
        moves = [[0, 0], [1, 1], [2, 2]]
        allow(enemy_piece).to receive(:pos).and_return([2, 2])
        allow(ally_piece).to receive(:colour).and_return('white')
        allow(ally_piece).to receive(:moves).and_return(moves)
      end

      it 'is not mate' do
        expect(board_mate.mate([king, enemy_piece])).to be false
      end
    end

    context 'when ally piece can move between enemy piece and king' do
      subject(:board_mate) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2], moves: []) }
      let(:enemy_piece) { double('piece') }
      let(:ally_piece) { double('piece') }

      before do
        board_mate.board[0][0] = ally_piece
        moves = [[1, 0], [1, 1], [1, 2]]
        allow(enemy_piece).to receive(:pos).and_return([2, 2])
        allow(enemy_piece).to receive(:name).and_return('rook')
        allow(ally_piece).to receive(:colour).and_return('white')
        allow(ally_piece).to receive(:moves).and_return(moves)
      end

      it 'is not mate' do
        expect(board_mate.mate([king, enemy_piece])).to be false
      end
      it 'is not mate' do
        expect(board_mate).to receive(:between?).at_least(:once)
        board_mate.mate([king, enemy_piece])
      end
    end
    context 'when ally piece can move between enemy piece and king but enemy piece is knight' do
      subject(:board_mate) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2], moves: []) }
      let(:enemy_piece) { double('piece') }
      let(:ally_piece) { double('piece') }

      before do
        board_mate.board[0][0] = ally_piece
        moves = [[1, 0], [1, 1], [1, 2]]
        allow(enemy_piece).to receive(:pos).and_return([2, 2])
        allow(enemy_piece).to receive(:name).and_return('knight')
        allow(ally_piece).to receive(:colour).and_return('white')
        allow(ally_piece).to receive(:moves).and_return(moves)
      end

      it 'is mate' do
        expect(board_mate.mate([king, enemy_piece])).to be true
      end
    end
    context 'when king cannot move and allied piece cannot help' do
      subject(:board_mate) { described_class.new }
      let(:king) { instance_double(King, colour: 'white', pos: [0, 2], moves: []) }
      let(:enemy_piece) { double('piece') }
      let(:ally_piece) { double('piece') }

      before do
        board_mate.board[1][0] = ally_piece
        moves = [[1, 0], [0, 0]]
        allow(enemy_piece).to receive(:pos).and_return([2, 2])
        allow(enemy_piece).to receive(:name).and_return('queen')
        allow(ally_piece).to receive(:colour).and_return('white')
        allow(ally_piece).to receive(:moves).and_return(moves)
      end

      it 'is mate' do
        expect(board_mate.mate([king, enemy_piece])).to be true
      end
    end
  end
end