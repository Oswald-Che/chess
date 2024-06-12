require './lib/pieces/king'

# test for king class

describe King do
  describe '#create_moves' do
    context 'when the king has a position of 3,3' do
      subject(:king_move) { described_class.new([3, 3], 'white') }

      it 'returns the correct moves' do
        moves = [[2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4]]
        result = king_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the king has a position of 0,0' do
      subject(:king_move) { described_class.new([0, 0], 'white') }

      it 'returns the correct moves' do
        moves = [[0, 1], [1, 0], [1, 1]]
        result = king_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the king has a position of 7,7' do
      subject(:king_move) { described_class.new([7, 7], 'white') }

      it 'returns the correct moves' do
        moves = [[6, 6], [6, 7], [7, 6]]
        result = king_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
  end
end