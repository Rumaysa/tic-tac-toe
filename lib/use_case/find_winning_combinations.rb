class FindWinningCombinations
  def execute(board)
    raise IncorrectShapeError unless square?(board)

    horizontal_winnings_for(board).union(vertical_winnings_for(board))
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
    current_comumn = []
    width = Math.sqrt(board.length).to_i

    width.times do |column|
      i = column
      loop do
        current_comumn << i
        i += width
        winning_combinations << current_comumn; break if i >= board.length
      end
      current_comumn = []
    end
    winning_combinations
  end

  def square?(board)
    (Math.sqrt(board.length) % 1).zero?
  end
end

class IncorrectShapeError < StandardError
end
