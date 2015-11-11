require 'delegate'

class HumanPlayer < SimpleDelegator
  def move
    puts "\nWhat is your move?(type 'exit' to end the game)"
    cell = get_input

    exit if cell == :exit

    if mark_cell(cell, players.current)
      log_mark(cell)
    else
      notify_invalid_cell
    end
  end

  private

  def get_input
    gets.chomp.downcase.to_sym
  end
end
