# frozen_string_literal: true

describe DisplayBoard do
  class BoardGatewayStub
    attr_writer :board

    def fetch_board
      @board
    end
  end

  let(:board_gateway) { BoardGatewayStub.new }
  let(:display_board) { DisplayBoard.new(board_gateway) }

  it 'displays an empty board when player never moved' do
    board_gateway.board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    expect(display_board.execute).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it 'displays the board with a mark' do
    board_gateway.board = [nil, nil, 'X', nil, nil, nil, nil, nil, nil]
    expect(display_board.execute).to eq([nil, nil, 'X', nil, nil, nil, nil, nil, nil])
  end

  it 'displays the board with players mark and AIs mark' do
    board_gateway.board = [nil, nil, 'X', 'O', nil, nil, nil, nil, nil]
    expect(display_board.execute).to eq([nil, nil, 'X', 'O', nil, nil, nil, nil, nil])
  end
end
