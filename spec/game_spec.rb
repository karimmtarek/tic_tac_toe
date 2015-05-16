require 'spec_helper'

module TicTacToe
  describe Game do
    context '#initialize' do
      it 'has an empty board cells hash' do
        game = Game.new

        expect(game.board_cells).to eq({ a1: '', a2: '', a3: '', b1: '', b2: '', b3: '', c1: '', c2: '', c3: '' })
      end

      it 'has an empty moves log' do
        game = Game.new

        expect(game.moves_log).to eq([])
      end

      it 'has player hash with empty values' do
        game = Game.new

        expect(game.players).to eq({ human: '', computer: '' })
      end
    end

    context 'game status' do
      it 'is game over if there is a win' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'X', a3: 'X', b1: '', b2: '', b3: '', c1: '', c2: '', c3: '' }
        expect(game.game_over?(board_cells)).to be_truthy
      end

      it 'is game over if there is a draw' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'O', a3: 'X', b1: 'O', b2: 'X', b3: 'O', c1: 'X', c2: 'O', c3: 'X' }
        expect(game.game_over?(board_cells)).to be_truthy
      end

      it 'is win if a row has same symbol' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'X', a3: 'X', b1: '', b2: '', b3: '', c1: '', c2: '', c3: '' }
        expect(game.win?(board_cells)).to be_truthy
      end

      it 'is win if a column has same symbol' do
        game = Game.new
        board_cells = { a1: 'X', a2: '', a3: '', b1: 'X', b2: '', b3: '', c1: 'X', c2: '', c3: '' }
        expect(game.win?(board_cells)).to be_truthy
      end

      it 'is win if a diagonal has same symbol' do
        game = Game.new
        board_cells = { a1: 'X', a2: '', a3: '', b1: '', b2: 'X', b3: '', c1: '', c2: '', c3: 'X' }
        expect(game.win?(board_cells)).to be_truthy
      end

      it 'is a draw if no row, column or diagonal has same symbol' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'O', a3: 'X', b1: 'O', b2: 'X', b3: 'O', c1: 'X', c2: 'O', c3: 'X' }
        expect(game.win?(board_cells)).to be_truthy
      end
    end

    context 'cells' do
      it 'checks the validity of a cell' do
        game = Game.new
        expect(game.valid_cell?('a5')).to be_falsey
        expect(game.valid_cell?('a3')).to be_truthy
      end

      it 'checks if cell is empty' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'O', a3: 'X', b1: 'O', b2: 'X', b3: 'O', c1: 'X', c2: 'O', c3: '' }
        expect(game.empty_cell?(board_cells, :c3)).to be_truthy
      end

      it 'prints a space if the cell is empty' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'O', a3: 'X', b1: 'O', b2: 'X', b3: 'O', c1: 'X', c2: 'O', c3: '' }
        expect(game.print_cell(board_cells, :c3)).to eq(' ')
      end

      it 'prints a cell symbol' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'O', a3: 'X', b1: 'O', b2: 'X', b3: 'O', c1: 'X', c2: 'O', c3: '' }
        expect(game.print_cell(board_cells, :a1)).to eq('X')
      end

      it 'returnes available cells in an array' do
        game = Game.new
        board_cells = { a1: 'X', a2: 'O', a3: 'X', b1: 'O', b2: 'X', b3: 'O', c1: 'X', c2: '', c3: '' }
        expect(game.available_cells(board_cells)).to eq([:c2, :c3])
      end
    end
  end
end
