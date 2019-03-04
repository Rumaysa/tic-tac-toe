# frozen_string_literal: true

describe ClearBoard do
  class BoardGatewaySpyTwo
    attr_reader :board

    def initialize(board)
      @board = board
    end

    def fetch_board
      @board
    end
  end

  def test_for_board(board)
    board_gateway = BoardGatewaySpyTwo.new(board)
    clear_board = ClearBoard.new(board_gateway)

    clear_board.execute

    expect(board_gateway.board).to eq(
      [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    )
  end

  it 'can clear the board' do
    test_for_board([nil, nil, nil, nil, nil, 'X', nil, nil, nil])
  end

  it 'can clear any board (example 2)' do
    test_for_board(%w[O X O X O X O X O])
  end
end
