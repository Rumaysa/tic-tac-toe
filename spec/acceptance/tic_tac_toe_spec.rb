# frozen_string_literal: true

require 'fetch_board'
require 'update_board'
require 'evaluate_board'
require 'clear_board'
require 'ui_board'

describe 'tictactoe' do
  class BoardGateway
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

  let(:board_gateway) { BoardGateway.new }
  let(:fetch_board) { FetchBoard.new(board_gateway) }
  let(:update_board) { UpdateBoard.new(board_gateway) }
  let(:evaluate_board) { EvaluateBoard.new(board_gateway) }
  let(:clear_board) { ClearBoard.new(board_gateway) }

  it 'can display the state of the board' do
    expect(fetch_board.execute).to eq(
      [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    )
  end

  it 'can display the state of the board after an update' do
    update_board.execute('X', at_index: 8)
    update_board.execute('O', at_index: 5)

    expect(fetch_board.execute).to eq(
      [nil, nil, nil, nil, nil, 'O', nil, nil, 'X']
    )
  end

  it 'can display the winning outcome of any player' do
    update_board.execute('X', at_index: 8)
    update_board.execute('O', at_index: 7)
    update_board.execute('X', at_index: 4)
    update_board.execute('O', at_index: 6)
    update_board.execute('X', at_index: 0)

    expect(evaluate_board.execute).to eq(:"Player one wins")

    clear_board.execute

    update_board.execute('O', at_index: 8)
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 0)

    expect(evaluate_board.execute).to eq(:"Player two wins")

    clear_board.execute

    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 5)

    expect(evaluate_board.execute).to eq(:"Player two wins")
  end

  it 'can display the outcome of two full games' do
    update_board.execute('X', at_index: 0)
    update_board.execute('O', at_index: 1)
    update_board.execute('O', at_index: 2)
    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 4)
    update_board.execute('X', at_index: 5)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 7)
    update_board.execute('O', at_index: 8)

    expect(evaluate_board.execute).to eq(:"Game over")

    clear_board.execute

    update_board.execute('X', at_index: 0)
    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 1)
    update_board.execute('X', at_index: 4)
    update_board.execute('O', at_index: 7)
    update_board.execute('X', at_index: 5)
    update_board.execute('O', at_index: 8)
    update_board.execute('X', at_index: 2)

    expect(evaluate_board.execute).to eq(:"Player one wins")
  end
end
