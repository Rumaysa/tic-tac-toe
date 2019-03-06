# frozen_string_literal: true

describe ClearBoard do
  def test_for_board(board)
    board_gateway = BoardGatewaySpy.new(board)
    clear_board = ClearBoard.new(board_gateway)

    clear_board.execute

    expect(board_gateway.board).to eq(Array.new(9, nil))
  end

  it 'can clear the board' do
    test_for_board([nil, nil, nil, nil, nil, 'X', nil, nil, nil])
  end

  it 'can clear any board (example 2)' do
    test_for_board(%w[O X O X O X O X O])
  end
end
