require './lib/pieces/knight'

# test for knight class

describe Knight do
  describe '#create_moves' do
    context 'when the knight has a position of 4,4' do
      subject(:knight_move) { described_class.new([3, 3], 'white') }

      it 'returns the correct moves' do
        moves = [[1, 2], [1, 4], [2, 1], [2, 5], [4, 1], [4, 5], [5, 2], [5, 4]]
        result = knight_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the knight has a position of 0,0' do
      subject(:knight_move) { described_class.new([0, 0], 'white') }

      it 'returns the correct moves' do
        moves = [[1, 2], [2, 1]]
        result = knight_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end

    context 'when the knight has a position of 7,7' do
      subject(:knight_move) { described_class.new([7, 7], 'white') }

      it 'returns the correct moves' do
        moves = [[5, 6], [6, 5]]
        result = knight_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
  end
end