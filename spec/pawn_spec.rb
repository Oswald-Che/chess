require './lib/pieces/pawn.rb'

# test for pawn class

describe Pawn do
  describe '#create_moves' do
    context 'when the pawn is white, has a position of 0,0 and has not moved' do
      subject(:pawn_move) { described_class.new([0, 0], 'WHITE') }

      it 'returns the correct moves' do
        moves = [[1, 0], [2, 0]]
        result = pawn_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the pawn is black, has a position of 6,4 and has not moved' do
      subject(:pawn_move) { described_class.new([6, 4], 'BLACK') }

      it 'returns the correct moves' do
        moves = [[4, 4], [5, 4]]
        result = pawn_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
    context 'when the pawn has a position of 1, 2 and has moved' do
      subject(:pawn_move) { described_class.new([1, 2], 'WHITE') }

      before do
        pawn_move.instance_variable_set(:@moved, true)
      end
      it 'returns the correct moves' do
        moves = [[2, 2]]
        result = pawn_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end

    context 'when the pawn is black has a position of 1, 2 and has moved' do
      subject(:pawn_move) { described_class.new([4, 4], 'BLACK') }

      before do
        pawn_move.instance_variable_set(:@moved, true)
      end

      it 'returns the correct moves' do
        moves = [[3, 4]]
        result = pawn_move.create_moves.sort
        expect(result).to eq(moves)
      end
    end
  end

  describe '#capture_move' do
    context 'when the pawn is black, has a position of 6,4' do
      subject(:pawn_capture) { described_class.new([6, 4], 'BLACK') }

      it 'returns the correct moves' do
        capture = [[5, 3], [5, 5]]
        result = pawn_capture.capture_moves{ true }.sort
        expect(result).to eq(capture)
      end
    end
    context 'when the pawn is white, has a position of 6,4' do
      subject(:pawn_capture) { described_class.new([6, 4], 'white') }

      it 'returns the correct moves' do
        capture = [[7, 3], [7, 5]]
        result = pawn_capture.capture_moves{ true }.sort
        expect(result).to eq(capture)
      end
    end
  end

  describe '#name' do
    subject(:pawn_name) { described_class.new(nil, 'white') }

    it 'returns class name' do
      expect(pawn_name.name).to eq('pawn')
    end
  end
end