# frozen_string_literal: true

require 'spec_helper'
require 'gateway/game_gateway'
require 'use_case/view_board'
require 'use_case/update_board'
require 'use_case/evaluate_board'
require 'use_case/ai_response_board'
require 'ui_board'
require 'domain/game'
require 'test_doubles/game_gateway_spy'
require 'test_doubles/game_gateway_stub'

describe 'tictactoe' do
  let(:game) { Game.new(board_width: 3) }
  let(:game_gateway) { InMemoryGameGateway.new(game) }
  let(:view_board) { ViewBoard.new(game_gateway) }
  let(:update_board) { UpdateBoard.new(game_gateway) }
  let(:ai_response_board) { AIResponse.new(game_gateway) }
  let(:evaluate_board) { EvaluateBoard.new(game_gateway) }

  it 'can initialise an empty board' do
    expect(view_board.execute).to eq(
      [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    )
  end

  it 'can display the state of the board after an update' do
    update_board.execute('X', at_index: 8)
    update_board.execute('O', at_index: 5)

    expect(view_board.execute).to eq(
      [nil, nil, nil, nil, nil, 'O', nil, nil, 'X']
    )
  end

  it 'can evaluate to a win for player one, diagonally' do
    update_board.execute('X', at_index: 8)
    update_board.execute('O', at_index: 7)
    update_board.execute('X', at_index: 4)
    update_board.execute('O', at_index: 6)
    update_board.execute('X', at_index: 0)

    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:player_one_wins)
  end

  it 'can evaluate to a win for player one' do
    update_board.execute('X', at_index: 0)
    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 1)
    update_board.execute('X', at_index: 4)
    update_board.execute('O', at_index: 7)
    update_board.execute('X', at_index: 5)
    update_board.execute('O', at_index: 8)
    update_board.execute('X', at_index: 2)

    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:player_one_wins)
  end
  it 'can evaluate to a win for player two' do
    update_board.execute('X', at_index: 1)
    update_board.execute('O', at_index: 8)
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 0)

    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:player_two_wins)
  end

  it 'can evaluate to a win for player two' do
    update_board.execute('X', at_index: 1)
    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 7)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 5)

    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:player_two_wins)
  end

  it 'can can evaluate to a draw' do
    update_board.execute('X', at_index: 0)
    update_board.execute('O', at_index: 4)
    update_board.execute('X', at_index: 1)
    update_board.execute('O', at_index: 2)
    update_board.execute('X', at_index: 6)
    update_board.execute('O', at_index: 3)
    update_board.execute('X', at_index: 5)
    update_board.execute('O', at_index: 8)
    update_board.execute('X', at_index: 7)

    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:game_over)

  end


  it 'can beat the player using AI' do
    def put_players_mark_at(index)
      update_board.execute('X', at_index: index)
      ai_choice = ai_response_board.execute
      update_board.execute('O', at_index: ai_choice)
    end

    put_players_mark_at(0)
    put_players_mark_at(1)
    put_players_mark_at(3)

    expect(view_board.execute).to eq(
      ['X', 'X', 'O', 'X', 'O', nil, 'O', nil, nil]
    )
    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:player_two_wins)
  end

  it 'cannot lose a game using AI' do
    def ai_place_mark(mark)
      ai_choice = ai_response_board.execute(mark)
      update_board.execute(mark, at_index: ai_choice)
    end

    4.times do
      ai_place_mark('X')
      ai_place_mark('O')
    end
    ai_place_mark('X')

    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:game_over)
  end
end
