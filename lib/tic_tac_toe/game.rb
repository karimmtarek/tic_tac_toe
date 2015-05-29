require_relative 'board'
require_relative 'player'

module TicTacToe
  class Game
    attr_reader :board, :board_cells, :moves_log, :players

    def initialize
      @board = Board.new
      @board_cells = @board.cells
      @players = Player.new
      @moves_log = @players.moves
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
      cell = gets.chomp.downcase.to_sym

      exit if cell == :exit

      if board.valid_full_cell?(cell)
        board_cells[:"#{cell}"] = players.current
        moves_log << "#{players.current} > #{cell}"
      else
        puts "Invalid entry please try again\n"
      end
    end

    def computer_move
      flag = moves_log.length

      win_move
      win_block if flag == moves_log.length
      filler_move if flag == moves_log.length
    end

    # looking for a win move
    def win_move
      check_each_cell(players.current)
    end

    # block human win
    def win_block
      check_each_cell(players.switch)
    end

    def check_each_cell(player)
      board.available_cells.each do |cell|
        board_cells[cell] = player
        if board.win?
          board_cells[cell] = players.current
          moves_log << "#{players.current} > #{cell}"
          break
        else
          board_cells[cell] = ''
        end
      end
    end

    # assign to a random cell
    def filler_move
      ava_cells = board.available_cells
      cell = ava_cells[rand(0..ava_cells.length - 1)]
      board_cells[cell] = players.current
      moves_log << "#{players.current} > #{cell}"
    end
  end
end
