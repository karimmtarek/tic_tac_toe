require 'spec_helper'

module TicTacToe
  describe Board do
    context '#initialize' do
      it 'has an empty board cells hash' do
        board = Board.new

        expect(board.cells).to eq({ a1: '', a2: '', a3: '', b1: '', b2: '', b3: '', c1: '', c2: '', c3: '' })
      end
    end

    context '#available_cells' do
      it 'returns available board cells' do
        board = Board.new
        expect(board.available_cells).to eq(board.valid_cells)
      end
    end

    context '#print_cell' do
      it "returns a ' ' if cell is empty" do
        board = Board.new
        expect(board.print_cell(:a1)).to eq(' ')
      end

      it 'returns a value if it has one' do
        board = Board.new
        board.cells[:a1] = 'X'
        expect(board.print_cell(:a1)).to eq('X')
      end
    end

    context '#valid_cell?' do
      it 'returns false if the cell is not valid' do
        board = Board.new
        expect(board.valid_cell?(:a5)).to be_falsey
      end

      it 'returns true if the cell is valid' do
        board = Board.new
        expect(board.valid_cell?(:a1)).to be_truthy
      end
    end

    context '#empty_cell?' do
      it 'returns true if the cell is empty' do
        board = Board.new
        expect(board.empty_cell?(:a3)).to be_truthy
      end

      it 'returns false if the cell is not empty' do
        board = Board.new
        board.cells[:a3] = 'X'
        expect(board.empty_cell?(:a3)).to be_falsey
      end
    end

    context 'cell position' do
      it 'returns true if the cell position is in the corner' do
        board = Board.new

        expect(board.corner?(:a1)).to be_truthy
        expect(board.corner?(:a3)).to be_truthy
        expect(board.corner?(:c1)).to be_truthy
        expect(board.corner?(:c3)).to be_truthy
      end

      it 'returns true if the cell position is in the middle' do
        board = Board.new

        expect(board.middle?(:a2)).to be_truthy
        expect(board.middle?(:b1)).to be_truthy
        expect(board.middle?(:b3)).to be_truthy
        expect(board.middle?(:c2)).to be_truthy
      end

      it 'returns true if the cell position is in the middle' do
        board = Board.new

        expect(board.diagonal?(:b2)).to be_truthy
      end
    end

    context '#game_over?' do
      it 'returns false if the game is not over' do
        board = Board.new

        expect(board.game_over?).to be_falsey
      end

      it 'returns true if the game is over(win)' do
        board = Board.new
        board.cells[:a3] = 'X'
        board.cells[:a2] = 'X'
        board.cells[:a1] = 'X'

        expect(board.game_over?).to be_truthy
      end

      it 'returns true if the game is over(draw)' do
        board = Board.new
        board.cells[:a1] = 'X'
        board.cells[:a2] = 'X'
        board.cells[:a3] = 'O'
        board.cells[:b1] = 'O'
        board.cells[:b2] = 'O'
        board.cells[:b3] = 'X'
        board.cells[:c1] = 'X'
        board.cells[:c2] = 'X'
        board.cells[:c3] = 'O'

        expect(board.game_over?).to be_truthy
      end
    end

    context '#cells_equality_check?' do
      it 'returns true if three cells equal each other' do
        board = Board.new
        board.cells[:a1] = 'X'
        board.cells[:a2] = 'X'
        board.cells[:a3] = 'X'

        expect(board.cells_equality_check?([:a1, :a2, :a3])).to be_truthy
      end

      it 'returns false if three cells not equal each other' do
        board = Board.new
        board.cells[:a1] = 'X'
        board.cells[:a2] = 'X'
        board.cells[:a3] = 'O'

        expect(board.cells_equality_check?([:a1, :a2, :a3])).to be_falsey
      end
    end

    context '#win?' do
      it 'returns true if there is a win' do
        board = Board.new
        board.cells[:a1] = 'X'
        board.cells[:a2] = 'X'
        board.cells[:a3] = 'X'

        expect(board.win?).to be_truthy
      end

      it 'returns false if there is no win' do
        board = Board.new

        expect(board.win?).to be_falsey
      end
    end

    context '#draw?' do
      it 'returns true if there is a draw' do
        board = Board.new
        board.cells[:a1] = 'X'
        board.cells[:a2] = 'X'
        board.cells[:a3] = 'O'
        board.cells[:b1] = 'O'
        board.cells[:b2] = 'O'
        board.cells[:b3] = 'X'
        board.cells[:c1] = 'X'
        board.cells[:c2] = 'X'
        board.cells[:c3] = 'O'

        expect(board.draw?).to be_truthy
      end

      it 'returns false if there is no draw' do
        board = Board.new
        expect(board.draw?).to be_falsey
      end
    end
  end
end
