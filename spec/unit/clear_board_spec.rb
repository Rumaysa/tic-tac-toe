# frozen_string_literal: true

require 'spec_helper'

describe ClearBoard do
  def test_for_board(board)
    game = Game.new(board_width: 3)
    game.board = board
    game_gateway = GameGatewaySpy.new(game)
    clear_board = ClearBoard.new(game_gateway)

    clear_board.execute

    expect(game.board).to eq(Array.new(9, nil))
  end

  it 'can clear the board' do
    test_for_board([nil, nil, nil, nil, nil, 'X', nil, nil, nil])
  end

  it 'can clear any board (example 2)' do
    test_for_board(%w[O X O X O X O X O])
  end
end
