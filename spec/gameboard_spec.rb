require './lib/gameboard'

# test for gameboard class

describe GameBoard do
  describe '#update_history' do
    context 'when a pawn moves' do
      subject(:gameboard_history) { described_class.new }
      let(:pawn) { instance_double(Pawn, name: 'pawn', colour: 'white') }

      before do
        gameboard_history.board.board[2][0] = pawn
      end

      it 'update history correctly' do
        move = [[2, 0], [4, 0]]
        result = gameboard_history.update_history(move).last
        expect(result[:name]).to eq('pawn')
      end
    end
  end

  describe '#en_passant?' do
    context 'when pawn moves but its not en passant' do
      subject(:gameboard_enpassant) { described_class.new }
      let(:pawn) { { name: 'pawn', pos: [4, 0], prev_pos: [3, 0] } }

      before do
        allow(gameboard_enpassant).to receive(:history).and_return([pawn])
      end

      it 'return true' do
        move = [5, 0]
        expect(gameboard_enpassant).not_to be_en_passant(move)
      end
    end

    context 'when pawn moves and it is enpassant' do
      subject(:gameboard_enpassant) { described_class.new }
      let(:pawn) { { name: 'pawn', pos: [4, 0], prev_pos: [2, 0] } }

      before do
        allow(gameboard_enpassant).to receive(:history).and_return([pawn])
      end

      it 'return true' do
        move = [5, 0]
        expect(gameboard_enpassant).not_to be_en_passant(move)
      end
    end
  end
end