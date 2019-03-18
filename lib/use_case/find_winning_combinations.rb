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

    (0...board.length).step(@width) do |index|
      winning_combinations << (index...index + @width).to_a
    end

    winning_combinations
  end

  def vertical_winnings_for(board)
    winning_combinations = []

    @width.times do |column|
      current_comumn = []

      (column...board.length).step(@width) do |index|
        current_comumn << index
        winning_combinations << current_comumn
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
