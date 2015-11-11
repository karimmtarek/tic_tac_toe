require_relative 'board'
require_relative 'players'
require_relative 'human_player'
require_relative 'computer_player'

module TicTacToe
  class Game
    attr_reader :board, :players

    def initialize
      @board = Board.new
      @players = Players.new
    end

    def run
      players.toss
      # Smell - duplication? #1
      until board.game_over?
        board.render
        make_move
      end
    end

    def current_player
      if human_player?
        human
      else
        computer
      end
    end

    def make_move
      current_player.move

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

    def human
      HumanPlayer.new(self)
    end

    def computer
      ComputerPlayer.new(self)
    end

    def mark_cell(cell, player)
      board.mark_cell(cell, player)
    end

    def notify_invalid_cell
      puts "Invalid entry please try again\n"
    end

    def new_mark?(current_marks)
      current_marks == players.moves.length
    end

    def mark_available_cell(player)
      cell = board.move_to_available_cell(player)
      yield cell
    end

    def find_winning_cell(player, &block)
      board.find_winning_cell(player, &block)
    end

    def log_mark(cell)
      players.moves << "#{players.current} > #{cell}"
    end

    def do_mark_cell(player, cell)
      board.do_mark_cell(cell, player)
    end
  end
end
