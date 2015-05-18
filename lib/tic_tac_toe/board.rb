module TicTacToe
  class Board
    attr_reader :cells

    def initialize
      @cells = {
        a1: '', a2: '', a3: '',
        b1: '', b2: '', b3: '',
        c1: '', c2: '', c3: ''
      }
    end

    def render
      # header = "\nTic Tac Toe Game - #{print_players(players)}"
      header = "\nTic Tac Toe Game"
      puts header
      puts '=' * header.length
      puts "\n   1   2   3 \n"
      puts "A  #{print_cell(:a1)} | #{print_cell(:a2)} | #{print_cell(:a3)} "
      puts '  ---+---+---'
      puts "B  #{print_cell(:b1)} | #{print_cell(:b2)} | #{print_cell(:b3)} "
      puts '  ---+---+---'
      puts "C  #{print_cell(:c1)} | #{print_cell(:c2)} | #{print_cell(:c3)} "
    end

    def available_cells
      cells.select { |_k, v| v == '' }.keys
    end

    def valid_cells
      cells.keys
    end

    def print_cell(cell)
      return ' ' if cells[:"#{cell}"].empty?
      cells[:"#{cell}"]
    end

    def valid_cell?(cell)
      valid_cells.include? cell
    end

    def empty_cell?(cell)
      cells[:"#{cell}"].empty?
    end

    def win?
      row_win? || column_win? || diagonal_win?
    end

    def row_win?
      return true if cells_equality_check?([:a1, :a2, :a3])
      return true if cells_equality_check?([:b1, :b2, :b3])
      return true if cells_equality_check?([:c1, :c2, :c3])
    end

    def column_win?
      return true if cells_equality_check?([:a1, :b1, :c1])
      return true if cells_equality_check?([:a2, :b2, :c2])
      return true if cells_equality_check?([:a3, :b3, :c3])
    end

    def diagonal_win?
      return true if cells_equality_check?([:a3, :b2, :c1])
      return true if cells_equality_check?([:a1, :b2, :c3])
    end

    def cells_equality_check?(cells_array)
      !cells[cells_array[0]].empty? && all_equal?(cells_array)
    end

    def all_equal?(cells_array)
      cells_array.all? { |cell| cells[cell] == cells[cells_array.first] }
    end

    def draw?
      true unless cells.value?('') || win?
    end

    def game_over?
      win? || draw?
    end
  end
end
