require './lib/pieces/rook'

# test for rook class

describe Rook do
  describe '#create_moves' do
    context 'when the rook has a position of 3,3' do
      subject(:rook_move) { described_class.new([3, 3], 'white') }

      it 'returns the correct moves' do
        moves = [[0, 3], [1, 3], [2, 3], [3, 0], [3, 1], [3, 2], [3, 4],
                 [3, 5], [3, 6], [3, 7], [4, 3], [5, 3], [6, 3], [7, 3]]
        result = rook_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the rook has a position of 0,0' do
      subject(:rook_move) { described_class.new([0, 0], 'white') }

      it 'returns the correct moves' do
        moves = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
                 [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
        result = rook_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the rook has a position of 7,7' do
      subject(:rook_move) { described_class.new([7, 7], 'white') }

      it 'returns the correct moves' do
        moves = [[0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], 
                 [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6]]
        result = rook_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
  end
end