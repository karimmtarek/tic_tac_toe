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
      until board.game_over?
        board.render
        make_move
      end
    end

    def make_move
      if players.signs[:human] == players.current
        human_move
      else
        computer_move
      end

      return unless board.game_over?
      board.render
      render_final_status
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

      exit if cell == 'exit'

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
      board.available_cells.each do |cell|
        board_cells[cell] = players.current
        if board.win?
          board_cells[cell] = players.current
          moves_log << "#{players.current} > #{cell}"
          break
        else
          board_cells[cell] = ''
        end
      end
    end

    # block human win
    def win_block
      board.available_cells.each do |cell|
        board_cells[cell] = players.switch
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
