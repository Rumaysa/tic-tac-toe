describe UpdateBoard do
  class BoardGatewaySpy
    attr_reader :board

    def initialize
      @board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    end

    def fetch_board
      @board
    end

    def update(player, at_index)
      @board[at_index] = player
    end
  end

  let(:board_gateway) { BoardGatewaySpy.new }
  let(:update_board) { UpdateBoard.new(board_gateway) }

  it 'can update the board with players mark' do
    update_board.execute('X', at_index: 6)

    expect(board_gateway.board).to eq(
      [nil, nil, nil, nil, nil, nil, 'X', nil, nil]
    )
  end

  it 'cannot allow any player to make the same move twice' do
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 7)

    expect(board_gateway.board).to eq(
      [nil, nil, nil, nil, nil, nil, nil, 'X', nil]
    )
  end
end
