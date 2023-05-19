require_relative '../lib/queen'
# test for queen class


describe Queen do
  describe '#change_moves' do
    context 'When queen is at 0,0' do
      subject(:queen_moves) { described_class.new('white', 0, 0) }
      it 'does not include its position' do
        result = queen_moves.change_moves
        position = [0, 0]
        expect(result).not_to include(position)
      end

      it 'contains all points vertically' do
        result = queen_moves.change_moves
        vertical_moves = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
        intersection = vertical_moves & result
        expect(intersection).to eq(vertical_moves)
      end

      it 'contain all points diagonally' do
        result = queen_moves.change_moves
        diagonal_moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        intersection = diagonal_moves & result
        expect(intersection).to eq(diagonal_moves)
      end

      it 'contain all points horizontally' do
        result = queen_moves.change_moves
        horizontal_moves = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
        intersection = horizontal_moves & result
        expect(intersection).to eq(horizontal_moves)
      end 
    end

    context 'when queen is in the middle of baord (4,4)' do
      subject(:queen_moves) { described_class.new('white', 4, 4) }
      it 'does not include its position' do
        result = queen_moves.change_moves
        position = [4, 4]
        expect(result).not_to include(position)
      end

      it 'contains all points vertically' do
        result = queen_moves.change_moves
        vertical_moves = [[0, 4], [1, 4], [2, 4], [3, 4], [5, 5], [6, 4], [7, 4]]
        intersection = vertical_moves & result
        expect(intersection).to eq(vertical_moves)
      end

      it 'contain all points diagonally' do
        result = queen_moves.change_moves
        diagonal_moves = [[0, 0], [1, 1], [2, 2], [3, 3], [5, 5], [6, 6], [7, 7]]
        intersection = diagonal_moves & result
        expect(intersection).to eq(diagonal_moves)
      end


      it 'contain all points reverse diagonally' do
        result = queen_moves.change_moves
        diagonal_moves = [ [1, 7], [2, 6], [3, 5], [5, 3], [6, 2], [7, 1]]
        intersection = diagonal_moves & result
        expect(intersection).to eq(diagonal_moves)
      end

      it 'contain all points horizontally' do
        result = queen_moves.change_moves
        horizontal_moves = [[4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7]]
        intersection = horizontal_moves & result
        expect(intersection).to eq(horizontal_moves)
      end 
    end
  end
end