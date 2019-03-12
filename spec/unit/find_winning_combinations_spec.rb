# frozen_string_literal: true

describe FindWinningCombinations do
  let(:winning_combinations) { FindWinningCombinations.new }

  it 'can find all winning combinations for a one cell board' do
    board = Board.new(width: 1)
    expect(winning_combinations.execute(board)).to eq([[0]])
  end

  it 'can find all winning combinations for a 2 X 2 board' do
    board = Board.new(width: 2)
    expect(winning_combinations.execute(board)).to eq(
      [[0, 1], [2, 3], [0, 2], [1, 3], [0, 3], [1, 2]]
    )
  end

  it 'can find all winning combinations for 3 X 3 a board' do
    board = Board.new(width: 3)
    expect(winning_combinations.execute(board)).to eq(
      [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
       [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    )
  end

  it 'can find all winning combinations for 4 X 4 a board' do
    board = Board.new(width: 4)
    expect(winning_combinations.execute(board)).to eq([
                                                        [0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11],
                                                        [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13],
                                                        [2, 6, 10, 14], [3, 7, 11, 15], [0, 5, 10, 15],
                                                        [3, 6, 9, 12]
                                                      ])
  end
end
