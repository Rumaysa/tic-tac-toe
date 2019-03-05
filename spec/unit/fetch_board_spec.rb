# frozen_string_literal: true

describe FetchBoard do
  class BoardGatewayStub
    attr_writer :board

    def fetch_board
      @board
    end
  end

  let(:board_gateway) { BoardGatewayStub.new }
  let(:fetch_board) { FetchBoard.new(board_gateway) }

  it 'displays an empty board when player never moved' do
    board_gateway.board = Array.new(9, nil)
    expect(fetch_board.execute).to eq(Array.new(9, nil))
  end

  it 'displays the board with a mark' do
    board_gateway.board = [nil, nil, 'X', nil, nil, nil, nil, nil, nil]
    expect(fetch_board.execute).to eq([nil, nil, 'X', nil, nil, nil, nil, nil, nil])
  end

  it 'displays the board with players mark and AIs mark' do
    board_gateway.board = [nil, nil, 'X', 'O', nil, nil, nil, nil, nil]
    expect(fetch_board.execute).to eq([nil, nil, 'X', 'O', nil, nil, nil, nil, nil])
  end
end
