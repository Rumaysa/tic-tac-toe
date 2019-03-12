# frozen_string_literal: true

describe FindWinningCombinations do
  let(:winning_combinations) { FindWinningCombinations.new }

  it 'can find all winning combinations for a board' do
    board = Board.new(width: 1)
    expect(winning_combinations.execute(board)).to eq([[0]])
  end

  # xit 'can find all winning combinations for a board' do
  #   board = Board.new(width: 2)
  #   expect(winning_combinations.execute(board)).to eq(
  #     [[0, 1], [2, 3], [0, 2], [1, 3], [0, 3], [1, 2]]
  #   )
  # end
end
