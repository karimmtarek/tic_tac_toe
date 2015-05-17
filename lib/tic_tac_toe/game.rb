module TicTacToe
  class Game
    attr_reader :board_cells, :moves_log, :players
    def initialize
      @board_cells = { a1: '', a2: '', a3: '', b1: '', b2: '', b3: '', c1: '', c2: '', c3: '' }
      @moves_log = []
      @players = { human: '', computer: '' }
    end

    def run
      player_setup(players)
      until game_over?(board_cells)
        render_board(board_cells, players)
        make_move(board_cells, moves_log, players)
      end
    end

    def player_setup(players)
      if rand > 0.5
        players[:human] = 'X'
        players[:computer] = 'O'
      else
        players[:computer] = 'X'
        players[:human] = 'O'
      end
    end

    def make_move(cells, log, players)
      if players[:human] == current_player(log)
        human_move(cells, log)
      else
        computer_move(cells, log, players)
      end

      if game_over?(cells)
        render_board(cells, players)
        render_final_status(cells, log, players)
      end
    end

    def render_final_status(cells, log, players)
      if win?(cells)
        puts "\n* #{print_player(log, players)} Wins *"
      else
        puts "\n* It's a draw *"
      end
    end

    def human_move(cells, log)
      puts "\nWhat is your move?(type 'exit' to end the game)"
      cell = gets.chomp.downcase

      exit if cell == 'exit'

      if valid_cell?(cell) && empty_cell?(cells, cell)
        cells[:"#{cell}"] = current_player(log)
        log << "#{current_player(log)} > #{cell}"
      else
        puts "Invalid entry please try again\n"
      end
    end

    def computer_move(cells, log, players)
      ary = available_cells(cells)
      # flag = ary.length
      flag = log.length

      win_move(cells, ary, log, players)
      win_block(cells, ary, log)

      filler_move(cells, ary, log) if flag == log.length
    end

    # looking for a win move
    def win_move(cells, ary, log, players)
      ary.each do |cell|
        cells[cell] = current_player(log)
        if win?(cells)
          render_board(cells, players)
          puts "\n* Computer Wins *"
          exit
        else
          cells[cell] = ''
        end
      end
    end

    # block human win
    def win_block(cells, ary, log)
      ary.each do |cell|
        cells[cell] = switch_player(log)
        if win?(cells)
          cells[cell] = current_player(log)
          log << "#{current_player(log)} > #{cell}"
          break
        else
          cells[cell] = ''
        end
      end
    end

    # assign to a cell that has a sibling or a random cell
    def filler_move(cells, ary, log)
      flag = log.length

      ary.each do |cell|
        if corner?(cell)
          corner_move(cells, cell, log)
          break
        end

        if middle?(cell)
          middle_move(cells, cell, log)
          break
        end

        if diagonal?(cell)
          diagonal_move(cells, cell, log)
          break
        end
      end

      make_filler_move(cells, ary[rand(0..ary.length - 1)], log) if flag == log.length
    end

    def make_filler_move(cells, cell, log)
      cells[cell] = current_player(log)
      log << "#{current_player(log)} > #{cell}"
    end

    def corner?(cell)
      [:a1, :a3, :c1, :c3].include? cell
    end

    def middle?(cell)
      [:a2, :b1, :b3, :c2].include? cell
    end

    def diagonal?(cell)
      cell == :b2
    end

    def sibling?(cells, siblings_array, log)
      siblings_array.any? { |cell| cells[cell] == current_player(log) }
    end

    def corner_move(cells, cell, log)
      case cell
      when :a1
        make_filler_move(cells, cell, log) if sibling?(cells, [:a2, :b1, :b2], log)
      when :a3
        make_filler_move(cells, cell, log) if sibling?(cells, [:a2, :b3, :b2], log)
      when :c1
        make_filler_move(cells, cell, log) if sibling?(cells, [:c2, :b1, :b2], log)
      when :c3
        make_filler_move(cells, cell, log) if sibling?(cells, [:c2, :b3, :b2], log)
      end
    end

    def middle_move(cells, cell, log)
      case cell
      when :a2
        make_filler_move(cells, cell, log) if sibling?(cells, [:a1, :a3, :b2], log)
      when :b1
        make_filler_move(cells, cell, log) if sibling?(cells, [:a1, :b2, :c1], log)
      when :b3
        make_filler_move(cells, cell, log) if sibling?(cells, [:a3, :b2, :c3], log)
      when :c2
        make_filler_move(cells, cell, log) if sibling?(cells, [:b2, :c1, :c3], log)
      end
    end

    def diagonal_move(cells, cell, log)
      make_filler_move(cells, cell, log) if sibling?(cells, [:a1, :a2, :a3, :b1, :b3, :c1, :c2, :c3], log)
    end

    def print_players(players)
      return if players[:human].empty?

      if players[:human] == 'X'
        "Human(#{players[:human]}) vs. Computer(#{players[:computer]})"
      else
        "Computer(#{players[:computer]}) vs. Human(#{players[:human]})"
      end
    end

    def print_player(log, players)
      if players[:human] == log.last[0]
        'Human'
      else
        'Computer'
      end
    end

    def current_player(log)
      return 'X' if log.empty?
      if log.last[0] == 'X'
        'O'
      else
        'X'
      end
    end

    def switch_player(log)
      current_player(log) == 'X' ? 'O' : 'X'
    end

    def win?(cells)
      # Rows
      return true if cells_equality_check?(cells, :a1, :a2, :a3)

      return true if cells_equality_check?(cells, :b1, :b2, :b3)

      return true if cells_equality_check?(cells, :c1, :c2, :c3)

      # Columns
      return true if cells_equality_check?(cells, :a1, :b1, :c1)

      return true if cells_equality_check?(cells, :a2, :b2, :c2)

      return true if cells_equality_check?(cells, :a3, :b3, :c3)

      # Diagonals
      return true if cells_equality_check?(cells, :a1, :b2, :c3)

      return true if cells_equality_check?(cells, :a3, :b2, :c1)
    end

    def cells_equality_check?(cells, cell1, cell2, cell3)
      !cells[cell1].empty? && cells[cell1] == cells[cell2] && cells[cell2] == cells[cell3]
    end

    def draw?(cells)
      true unless cells.value? ''
    end

    def game_over?(cells)
      win?(cells) || draw?(cells)
    end

    def render_board(cells, players)
      header = "Tic Tac Toe Game - #{print_players(players)}"
      puts header
      puts '=' * header.length
      puts "\n   1   2   3 \n"
      puts "A  #{print_cell(cells, :a1)} | #{print_cell(cells, :a2)} | #{print_cell(cells, :a3)} "
      puts '  ---+---+---'
      puts "B  #{print_cell(cells, :b1)} | #{print_cell(cells, :b2)} | #{print_cell(cells, :b3)} "
      puts '  ---+---+---'
      puts "C  #{print_cell(cells, :c1)} | #{print_cell(cells, :c2)} | #{print_cell(cells, :c3)} "
    end

    def print_cell(cells, cell)
      return ' ' if cells[:"#{cell}"].empty?
      cells[:"#{cell}"]
    end

    def available_cells(cells)
      cells.select { |_k, v| v == '' }.keys
    end

    def valid_cells
      %w(a1 a2 a3 b1 b2 b3 c1 c2 c3)
    end

    def valid_cell?(cell)
      valid_cells.include? cell
    end

    def empty_cell?(cells, cell)
      cells[:"#{cell}"].empty?
    end
  end
end
