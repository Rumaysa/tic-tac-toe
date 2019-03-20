# frozen_string_literal: true
require 'spec_helper'

describe ViewBoard do
  let(:game) { Game.new(board_width: 3) }
  let(:game_gateway) { GameGatewayStub.new }
  let(:view_board) { ViewBoard.new(game_gateway) }

  it 'displays an empty board when player never moved' do
    game_gateway.game = game
    expect(view_board.execute).to eq(Array.new(9, nil))
  end

  it 'displays the board with a mark' do
    game.board = [nil, nil, 'X', nil, nil, nil, nil, nil, nil]
    game_gateway.game = game
    expect(view_board.execute).to eq([nil, nil, 'X', nil, nil, nil, nil, nil, nil])
  end

  it 'displays the board with players mark and AIs mark'  do
    game.board = [nil, nil, 'X', 'O', nil, nil, nil, nil, nil]
    game_gateway.game = game
    expect(view_board.execute).to eq([nil, nil, 'X', 'O', nil, nil, nil, nil, nil])
  end
end
