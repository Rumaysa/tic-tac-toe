class Find_winning_combinations
  def execute(board)
    raise IncorrectShapeError unless square?(board)
    return [[0]] if board.length == 1
    horizontal_winnings_for(board) | vertical_winnings_for(board)
  end

  private

  def horizontal_winnings_for(board)
    winning_combinations = []
    width = Math.sqrt(board.length).to_i

    i = 0
    loop do
      break if i >= board.length

      winning_combinations << (i...i + width).to_a
      i += width
    end
    winning_combinations
  end

  def vertical_winnings_for(board)
    winning_combinations = []
    width = Math.sqrt(board.length).to_i

    i = 0
    loop do
      break if i >= board.length

      winning_combinations << i
      i += width
    end
    winning_combinations
  end

  def square?(board)
    (Math.sqrt(board.length) % 1).zero?
  end
end

class IncorrectShapeError < StandardError
end
