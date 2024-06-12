require './lib/pieces/bishop'

# test for bishop class

describe Bishop do
  describe '#create_moves' do
    context 'when the bishop has a position of 3,3' do
      subject(:bishop_move) { described_class.new([3, 3], 'white') }

      it 'returns the correct moves' do
        moves = [[0, 0], [0, 6], [1, 1], [1, 5], [2, 2], [2, 4], [4, 2],
                 [4, 4], [5, 1], [5, 5], [6, 0], [6, 6], [7, 7]]
        result = bishop_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the bishop has a position of 0,0' do
      subject(:bishop_move) { described_class.new([0, 0], 'white') }

      it 'returns the correct moves' do
        moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        result = bishop_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the bishop has a position of 0,7' do
      subject(:bishop_move) { described_class.new([0, 7], 'white') }

      it 'returns the correct moves' do
        moves = [[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1], [7, 0]]
        result = bishop_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
  end
end