describe FindWinningCombinations do
  let(:winning_combinations) { FindWinningCombinations.new }
  it 'will throw an error if the board is not a square' do
    board = Array.new(3, nil)
    expect do
      winning_combinations.execute(board)
    end.to raise_error(IncorrectShapeError)
  end

  it 'can find all winning combinations for a board' do
    board = Board.new(width: 1)
    expect(winning_combinations.execute(board)).to eq([[0]])
  end

  it 'can find all winning combinations for a board' do
    board = Board.new(width: 2)
    expect(winning_combinations.execute(board)).to eq(
      [[0, 1], [2, 3], [0, 2], [1, 3], [0, 3], [1, 2]]
    )
  end
end
