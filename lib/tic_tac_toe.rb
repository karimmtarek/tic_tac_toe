require 'tic_tac_toe/version'
require 'tic_tac_toe/game'

module TicTacToe
  def self.run
    game = Game.new
    game.run
  end
end
