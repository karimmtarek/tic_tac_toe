require 'delegate'

class ComputerPlayer < SimpleDelegator
  def move
    current_marks = players.moves.length

    try_winning_mark
    try_defensive_mark if new_mark?(current_marks)
    do_neutral_mark if new_mark?(current_marks)
  end

  private

  def try_winning_mark
    find_winning_cell(players.current) do |cell|
      do_mark_cell(players.current, cell)
      log_mark(cell)
    end
  end

  def try_defensive_mark
    find_winning_cell(players.switch) do |cell|
      do_mark_cell(players.current, cell)
      log_mark(cell)
    end
  end

  def do_neutral_mark
    mark_available_cell(players.current) do |cell|
      log_mark(cell)
    end
  end
end
