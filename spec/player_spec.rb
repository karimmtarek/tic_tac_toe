require 'spec_helper'

module TicTacToe
  describe Player do
    context '#initialize' do
      it 'creates empty players hash' do
        players = Player.new
        expect(players.players).to eq({ human: '', computer: '' })
      end
    end
  end
end
