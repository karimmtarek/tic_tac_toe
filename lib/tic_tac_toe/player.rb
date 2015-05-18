module TicTacToe
  class Player
    attr_reader :signs, :moves

    def initialize
      @signs = {}
      @moves = []
    end

    def toss
      if rand > 0.5
        signs[:human] = 'X'
        signs[:computer] = 'O'
      else
        signs[:computer] = 'X'
        signs[:human] = 'O'
      end
    end

    def print
      return if signs[:human].empty?

      if signs[:human] == 'X'
        "Human(#{signs[:human]}) vs. Computer(#{signs[:computer]})"
      else
        "Computer(#{signs[:computer]}) vs. Human(#{signs[:human]})"
      end
    end

    def winner
      if signs[:human] == moves.last[0]
        'Human'
      else
        'Computer'
      end
    end

    def current
      return 'X' if moves.empty?
      moves.last[0] == 'X' ? 'O' : 'X'
    end

    def switch
      current == 'X' ? 'O' : 'X'
    end
  end
end
