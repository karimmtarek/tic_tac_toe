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
  end
end
