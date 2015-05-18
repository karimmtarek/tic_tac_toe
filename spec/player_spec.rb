require 'spec_helper'

module TicTacToe
  describe Player do
    context '#initialize' do
      it 'initiates an empty signs hash' do
        players = Player.new
        expect(players.signs).to eq({})
      end

      it 'initiates an empty moves array' do
        players = Player.new
        expect(players.moves).to eq([])
      end
    end

    context '#toss' do
      it 'assigns value to human and computer' do
        players = Player.new
        players.toss
        expect(players.signs[:human].empty?).to be_falsey
        expect(players.signs[:computer].empty?).to be_falsey
      end
    end

    context '#print' do
      it 'prints human vs. computer' do
        players = Player.new
        players.signs[:human] = 'X'
        players.signs[:computer] = 'O'

        expect(players.print).to eq('Human(X) vs. Computer(O)')
      end

      it 'prints computer vs. human' do
        players = Player.new
        players.signs[:computer] = 'X'
        players.signs[:human] = 'O'

        expect(players.print).to eq('Computer(X) vs. Human(O)')
      end
    end

    context '#winner' do
      it 'prints the winner' do
        players = Player.new
        players.moves << 'X'
        players.signs[:human] = 'X'

        expect(players.winner).to eq('Human')
      end
    end

    context '#current' do
      it 'returns current_palayer' do
        players = Player.new

        expect(players.current).to eq('X')
      end
    end

    context '#switch' do
      it 'switchs current player' do
        players = Player.new

        expect(players.switch).to eq('O')
      end
    end
  end
end
