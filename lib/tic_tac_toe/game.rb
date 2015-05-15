module TicTacToe
  class Game
    attr_reader :board_cells, :moves_log, :players
    def initialize
      @board_cells = {a1: '', a2: '', a3: '', b1: '', b2: '', b3: '', c1: '', c2: '', c3: ''}
      @moves_log = []
      @players = {human: '', computer:''}
    end

    def run
      player_setup(players)
      until game_over?(board_cells)
        render_board(board_cells, players)
        get_input(board_cells, moves_log, players)
      end
    end

    def player_setup(players)
      if rand > 0.5
        players[:human]= 'X'
        players[:computer] = 'O'
      else
        players[:computer] = 'X'
        players[:human]= 'O'
      end
    end

    def print_players(players)
      unless players[:human].empty?
        if players[:human] == 'X'
          "Human(#{players[:human]}) vs. Computer(#{players[:computer]})"
        else
          "Computer(#{players[:computer]}) vs. Human(#{players[:human]})"
        end
      end
    end

    def print_player(log ,players)
      if players[:human] == log.last[0]
        'Human'
      else
        'Computer'
      end
    end

    def win?(cells)
      # Rows
      unless cells[:a1].empty? && cells[:a2].empty? && cells[:a3].empty?
        return true if cells[:a1] == cells[:a2] && cells[:a2] == cells[:a3]
      end

      unless cells[:b1].empty? && cells[:b2].empty? && cells[:b3].empty?
        return true if cells[:b1] == cells[:b2] && cells[:b2] == cells[:b3]
      end

      unless cells[:c1].empty? && cells[:c2].empty? && cells[:c3].empty?
        return true if cells[:c1] == cells[:c2] && cells[:c2] == cells[:c3]
      end

      # Columns
      unless cells[:a1].empty? && cells[:b1].empty? && cells[:c1].empty?
        return true if cells[:a1] == cells[:b1] && cells[:b1] == cells[:c1]
      end

      unless cells[:a2].empty? && cells[:b2].empty? && cells[:c2].empty?
        return true if cells[:a2] == cells[:b2] && cells[:b2] == cells[:c2]
      end

      unless cells[:a3].empty? && cells[:b3].empty? && cells[:c3].empty?
        return true if cells[:a3] == cells[:b3] && cells[:b3] == cells[:c3]
      end

      # Diagonals
      unless cells[:a1].empty? && cells[:b2].empty? && cells[:c3].empty?
        return true if cells[:a1] == cells[:b2] && cells[:b2] == cells[:c3]
      end

      unless cells[:a3].empty? && cells[:b2].empty? && cells[:c1].empty?
        return true if cells[:a3] == cells[:b2] && cells[:b2] == cells[:c1]
      end
    end

    def draw?(cells)
      true unless cells.has_value? ''
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

    def xo
      rand > 0.5 ? 'X' : 'O'
    end

    def available_cells(cells)
      new_hash = cells.select { |_k, v| v == '' }
      new_hash.keys
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

    def next_move

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


    def computer_input(cells, log, players)
      ary = available_cells(cells)
      flag = ary.length

      # looking for a win move
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

      # block human win
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

      # assign to a random cell
      if flag == available_cells(cells).length
        cell = ary[rand(0..ary.length-1)]
        cells[cell] = current_player(log)
        log << "#{current_player(log)} > #{cell}"
      end
    end

    def get_input(cells, log, players)
      if players[:human] == current_player(log)
        puts "\nWhat is your move?(type 'exit' to end the game)"
        cell = gets.chomp.downcase

        exit if cell == 'exit'

        if valid_cell?(cell) && empty_cell?(cells, cell)
          cells[:"#{cell}"] = current_player(log)
          log << "#{current_player(log)} > #{cell}"
        else
          puts "Invalid entry please try again\n"
        end
      else
        computer_input(cells, log, players)
      end

      if game_over?(cells)
        render_board(cells, players)
        if win?(cells)
          puts "\n* #{print_player(log, players)} Wins *"
        else
          puts "\n* It's a draw *"
        end
      end
    end
  end
end
