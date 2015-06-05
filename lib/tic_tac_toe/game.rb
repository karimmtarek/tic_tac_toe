require_relative 'board'
require_relative 'player'

module TicTacToe
  class Game
    attr_reader :board, :players

    def initialize
      @board = Board.new
      @players = Player.new
    end

    def run
      players.toss
      # Smell - duplication? #1
      until board.game_over?
        board.render
        make_move
      end
    end

    def make_move
      # current_player.move - make this happen (homework)
      if human_player?
        human_move
      else
        computer_move
      end

      # Smell - duplication? #1
      return unless board.game_over?
      board.render
      render_final_status
    end

    def human_player?
      players.signs[:human] == players.current
    end

    def render_final_status
      if board.win?
        puts "\n* #{players.winner} Wins *"
      else
        puts "\n* It's a draw *"
      end
    end

    def human_move
      puts "\nWhat is your move?(type 'exit' to end the game)"
      cell = get_input

      exit if cell == :exit

      if mark_cell(cell, players.current)
        register_cell(cell, players.current)
      else
        notify_invalid_cell
      end
    end

    def get_input
      gets.chomp.downcase.to_sym
    end

    def mark_cell(cell, player)
      board.mark_cell(cell, player)
    end

    def register_cell(cell, player)
      players.moves << "#{player} > #{cell}"
    end

    def notify_invalid_cell
      puts "Invalid entry please try again\n"
    end

    def computer_move
      flag = players.moves.length

      win_move
      win_block if flag == players.moves.length
      filler_move if flag == players.moves.length
    end

    # looking for a win move
    def win_move
      check_each_cell(players.current)
    end

    # block human win
    def win_block
      check_each_cell(players.switch)
    end

    def assign_to_cell(player, cell)
      board.cells[cell] = player
    end

    def check_each_cell(player)
      board.available_cells.each do |cell|
        assign_to_cell(player, cell)
        if board.win?
          assign_to_cell(players.current, cell)
          players.moves << "#{players.current} > #{cell}"
          break
        else
          assign_to_cell('', cell)
        end
      end
    end

    # assign to a random cell
    def filler_move
      ava_cells = board.available_cells
      cell = ava_cells[rand(0..ava_cells.length - 1)]
      assign_to_cell(players.current, cell)
      players.moves << "#{players.current} > #{cell}"
    end
  end
end
