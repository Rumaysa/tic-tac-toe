# frozen_string_literal: true

require 'spec_helper'

describe UpdateBoard do
  let(:game) { Game.new(board_width: 3) }
  let(:board_gateway) { GameGatewaySpy.new(game) }
  let(:update_board) { UpdateBoard.new(board_gateway) }

  it 'can update the board with players mark' do
    update_board.execute('X', at_index: 6)
    board_gateway.game
    expect(game.board).to eq(
      [nil, nil, nil, nil, nil, nil, 'X', nil, nil]
    )
  end

  it 'cannot allow any player to make the same move twice' do
    update_board.execute('X', at_index: 7)
    board_gateway.game
    expect do
      update_board.execute('O', at_index: 7)
    end.to raise_error(UpdateBoard::DuplicationError)
  end

  it 'cannot allow any player to mark incorrectly' do
    board_gateway.game
    expect do
      update_board.execute('X', at_index: 9)
    end.to raise_error(RangeError)
  end

  it 'cannot allow any player to mark incorrectly, example 2' do
    board_gateway.game
    expect do
      update_board.execute('X', at_index: -1)
    end.to raise_error(RangeError)
  end
end
