# frozen_string_literal: true

class FindWinningCombinations
  def execute(board)
    @width = Math.sqrt(board.length).to_i
    horizontal_winnings_for(board)
      .union(vertical_winnings_for(board))
      .union(diagonal_winnings)
  end

  private

  def horizontal_winnings_for(board)
    winning_combinations = []

    i = 0
    loop do
      break if i >= board.length

      winning_combinations << (i...i + @width).to_a
      i += @width
    end
    winning_combinations
  end

  def vertical_winnings_for(board)
    winning_combinations = []
    current_comumn = []

    @width.times do |column|
      i = column
      loop do
        current_comumn << i
        i += @width
        winning_combinations << current_comumn; break if i >= board.length
      end
      current_comumn = []
    end
    winning_combinations
  end

  def diagonal_winnings
    positive_diagonal = []
    negative_diagonal = []
    i = j = 0
    @width.times do
      positive_diagonal << i + @width - 1
      negative_diagonal << j
      i += @width - 1
      j += @width + 1
    end
    [negative_diagonal, positive_diagonal]
  end
end
