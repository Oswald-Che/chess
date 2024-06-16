require './lib/game'

# test for input module included in game class

describe Game do
  describe '#check_input' do
    context 'when a valid input is given' do
      subject(:user_input) { described_class.new }

      before do
        input = 'e2e4'
        allow(user_input).to receive(:player_input).and_return(input)
        allow(user_input).to receive(:check_input).and_return(true)
        allow(user_input).to receive(:convert_input).and_return(input)
      end

      it 'doesn\'t display an error message' do
        expect(user_input).not_to receive(:puts)
        user_input.user_input
      end
    end
    context 'when an invalid input is given then a valid inpyt' do
      subject(:user_input) { described_class.new }

      before do
        input = 'e2e4'
        allow(user_input).to receive(:player_input).and_return(input, input)
        allow(user_input).to receive(:check_input).and_return(false, true)
        allow(user_input).to receive(:convert_input).and_return(input)
      end

      it 'display\'s an error message once' do
        expect(user_input).to receive(:puts).once
        user_input.user_input
      end
    end
  end

  describe '#check_input' do
    context 'when an invalid move is given' do
      subject(:input_check) { described_class.new }

      it 'returns false' do
        invalid_move = 'e3e10'
        result = input_check.check_input(invalid_move)
        expect(result).to be false
      end
    end

    context 'when an valid move is given' do
      subject(:input_check) { described_class.new }

      it 'returns false' do
        valid_move = 'b3e5'
        result = input_check.check_input(valid_move)
        expect(result).to be true
      end
    end
  end

  describe '#convert_input' do
    context 'when a move is given' do
      subject(:input_convert) { described_class.new }

      it 'returns the correct conversion to e2e4' do
        move = 'e2e4'
        result = input_convert.convert_input(move)
        expect(result).to eq([[4, 1], [4, 3]])
      end

      it 'returns the correct conversion to b1f5' do
        move = 'b1f5'
        result = input_convert.convert_input(move)
        expect(result).to eq([[1, 0], [5, 4]])
      end

      it 'returns the correct conversion to a1h8' do
        move = 'a1h8'
        result = input_convert.convert_input(move)
        expect(result).to eq([[0, 0], [7, 7]])
      end
    end 
  end
end