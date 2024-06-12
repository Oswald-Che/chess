require './lib/pieces/queen'

# test for queen class

describe Queen do
  describe '#create_moves' do
    context 'when the queen has a position of 3,3' do
      subject(:queen_move) { described_class.new([3, 3], 'white') }

      it 'returns the correct moves' do
        moves = [[0, 3], [1, 3], [2, 3], [3, 0], [3, 1], [3, 2], [3, 4],
                 [3, 5], [3, 6], [3, 7], [4, 3], [5, 3], [6, 3], [7, 3],
                 [0, 0], [0, 6], [1, 1], [1, 5], [2, 2], [2, 4], [4, 2],
                 [4, 4], [5, 1], [5, 5], [6, 0], [6, 6], [7, 7]].sort
        result = queen_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
  end
end
