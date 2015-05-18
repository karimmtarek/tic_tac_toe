require 'spec_helper'

module TicTacToe
  describe Game do
    context '#initialize' do
      it 'has an empty board cells hash' do
        game = Game.new

        expect(game.board.cells).to eq({ a1: '', a2: '', a3: '', b1: '', b2: '', b3: '', c1: '', c2: '', c3: '' })
      end

      it 'initiates an empty players signs hash' do
        game = Game.new
        expect(game.players.signs).to eq({})
      end

      it 'initiates an empty moves log array' do
        game = Game.new
        expect(game.moves_log).to eq([])
      end
    end

    context '#run' do
      it 'pick who is starting first' do
        game = Game.new
        players = game.players
        players.toss
        expect(players.signs[:human]).not_to eq('')
      end
    end

    context '#moves' do
      it "computer makes a random move" do
        game = Game.new
        players = game.players
        players.toss

        game.computer_move

        expect(game.board_cells.value?('X')).to be_truthy
      end

      it "computer blocks human wining move" do
        game = Game.new
        game.board_cells[:a1] = 'O'
        game.board_cells[:a2] = 'O'

        game.computer_move

        expect(game.board_cells[:a3]).to eq('X')
      end

      it "computer makes wining move" do
        game = Game.new
        game.board_cells[:a1] = 'X'
        game.board_cells[:a2] = 'X'

        players = game.players
        players.toss
        players.signs[:computer] = 'X'
        players.signs[:human] = 'O'

        game.computer_move

        expect(game.board_cells[:a3]).to eq('X')
      end
    end

  end
end
