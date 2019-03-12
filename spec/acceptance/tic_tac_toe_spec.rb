# frozen_string_literal: true

require 'gateway/board_gateway'
require 'use_case/view_board'
require 'use_case/update_board'
require 'use_case/evaluate_board'
require 'use_case/clear_board'
require 'use_case/ai_response_board'
require 'use_case/find_winning_combinations'
require 'ui_board'
require 'domain/board'
require 'test_doubles/board_gateway_spy'
require 'test_doubles/board_gateway_stub'

describe 'tictactoe' do
  let(:board) { Board.new(width: 3) }
  let(:board_gateway) { InMemoryBoardGateway.new(board) }
  let(:view_board) { ViewBoard.new(board_gateway) }
  let(:update_board) { UpdateBoard.new(board_gateway) }
  let(:evaluate_board) { EvaluateBoard.new(board_gateway) }
  let(:clear_board) { ClearBoard.new(board_gateway) }
  let(:ai_response_board) { AIResponse.new }

  it 'can initialise an empty board' do
    expect(view_board.execute).to eq(
      Board.new(width: 3)
    )
  end

  it 'can display the state of the board after an update' do
    update_board.execute('X', at_index: 8)
    update_board.execute('O', at_index: 5)

    expect(view_board.execute).to eq(
      [nil, nil, nil, nil, nil, 'O', nil, nil, 'X']
    )
  end

  it 'can display the winning outcome of any player' do
    update_board.execute('X', at_index: 8)
    update_board.execute('O', at_index: 7)
    update_board.execute('X', at_index: 4)
    update_board.execute('O', at_index: 6)
    update_board.execute('X', at_index: 0)

    expect(evaluate_board.execute).to eq(:player_one_wins)

    clear_board.execute

    update_board.execute('O', at_index: 8)
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 0)

    expect(evaluate_board.execute).to eq(:player_two_wins)

    clear_board.execute

    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 5)

    expect(evaluate_board.execute).to eq(:player_two_wins)
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

    expect(evaluate_board.execute).to eq(:game_over)

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

    expect(evaluate_board.execute).to eq(:player_one_wins)
  end

  it 'can beat the player using AI' do
    def put_players_mark_at(index)
      update_board.execute('X', at_index: index)
      board = view_board.execute
      ai_choice = ai_response_board.execute(board)
      update_board.execute('O', at_index: ai_choice)
    end

    put_players_mark_at(0)
    put_players_mark_at(1)
    put_players_mark_at(3)

    expect(view_board.execute).to eq(
      ['X', 'X', 'O', 'X', 'O', nil, 'O', nil, nil]
    )
    expect(evaluate_board.execute).to eq(:player_two_wins)
  end
end
