# frozen_string_literal: true
require 'spec_helper'

describe ViewBoard do
  let(:board_gateway) { BoardGatewayStub.new }
  let(:view_board) { ViewBoard.new(board_gateway) }

  it 'displays an empty board when player never moved' do
    board_gateway.board = Array.new(9, nil)
    expect(view_board.execute).to eq(Array.new(9, nil))
  end

  it 'displays the board with a mark' do
    board_gateway.board = [nil, nil, 'X', nil, nil, nil, nil, nil, nil]
    expect(view_board.execute).to eq([nil, nil, 'X', nil, nil, nil, nil, nil, nil])
  end

  it 'displays the board with players mark and AIs mark' do
    board_gateway.board = [nil, nil, 'X', 'O', nil, nil, nil, nil, nil]
    expect(view_board.execute).to eq([nil, nil, 'X', 'O', nil, nil, nil, nil, nil])
  end
end
