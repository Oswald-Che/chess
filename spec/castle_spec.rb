require './lib/gameboard.rb'

# test for castling module

describe GameBoard do
  describe '#rook_castle_move' do
    context 'when a king\'s castling move is given plus the type' do
      subject(:gameboard_rook_castle) { described_class.new }
      it 'returns the corresponiding rook\'s move' do
        move = [0, 4]
        type = 'C'
        result = gameboard_rook_castle.rook_castle_move(move, type)
        expect(result).to eq([[0, 0], [0, 3]])
      end

      it 'returns the corresponiding rook\'s move' do
        move = [7, 4]
        type = 'c'
        result = gameboard_rook_castle.rook_castle_move(move, type)
        expect(result).to eq([[7, 7], [7, 5]])
      end
    end
  end

  describe '#generate_position' do 
    context 'when a square and a file are given' do
      subject(:castle_generate) { described_class.new }

      it 'returns the squares between them on the same rank' do
        square1 = [0, 4]
        file = 0
        result = castle_generate.generate_position(square1, file).sort
        expect(result).to eq([[0, 0], [0, 1], [0, 2], [0, 3]])
      end

      it 'returns the squares between them on the same rank' do
        square1 = [7, 4]
        file = 6
        result = castle_generate.generate_position(square1, file).sort
        expect(result).to eq([[7, 5], [7, 6]])
      end
    end
  end

  describe '#row_empty?' do
    context 'when the rook and king are given with no piece between them' do
      subject(:castle_row_any) { described_class.new }
      let(:king) { instance_double(King, pos: [0, 4]) }
      let(:rook) { instance_double(Rook, pos: [0, 0]) }

      it 'returns false' do
        expect(castle_row_any.row_any?(king, rook)).to be false
      end
    end

    context 'when the rook and king are given with a piece between them' do
      subject(:castle_row_any) { described_class.new }
      let(:king) { instance_double(King, pos: [0, 4]) }
      let(:rook) { instance_double(Rook, pos: [0, 0]) }
      let(:piece) { double('piece')}

      before do
        castle_row_any.board.board[0][2] = piece
      end

      it 'returns false' do
        expect(castle_row_any.row_any?(king, rook)).to be true
      end
    end
  end

  describe '#escape_check' do
    context 'when a king is not escaping check by castling' do
      subject(:castle_escape) { described_class.new }
      let(:king) { instance_double(King, pos: [0, 4], colour: 'white') }
      let(:rook) { instance_double(Rook, pos: [0, 0]) }

      it 'returns false' do
        expect(castle_escape.escape_check?(king, rook)).to be false
      end
    end

    context 'when a king is not escaping check from a rook by castling' do
      subject(:castle_escape) { described_class.new }
      let(:king) { instance_double(King, pos: [0, 4], colour: 'white') }
      let(:ally_rook) { instance_double(Rook, pos: [0, 0]) }
      let(:enemy_rook) { instance_double(Rook, pos: [2, 2], colour: 'black', name: 'rook') }

      before do
        moves = [[0, 2], [1, 2]]
        allow(enemy_rook).to receive(:moves).and_return(moves)
        castle_escape.board.board[2][2] = enemy_rook
      end

      it 'returns true' do
        expect(castle_escape.escape_check?(king, ally_rook)).to be true
      end
    end

    context 'when a king is not escaping check from a rook by castling' do
      subject(:castle_escape) { described_class.new }
      let(:king) { instance_double(King, pos: [0, 4], colour: 'white') }
      let(:ally_rook) { instance_double(Rook, pos: [0, 0]) }
      let(:enemy_pawn) { instance_double(Pawn, pos: [2, 2], colour: 'black', name: 'pawn') }

      before do
        moves = [[0, 1], [0, 3]]
        allow(enemy_pawn).to receive(:capture_moves).and_return(moves)
        castle_escape.board.board[1][2] = enemy_pawn
      end

      it 'returns true' do
        expect(castle_escape.escape_check?(king, ally_rook)).to be true
      end
    end
  end
end