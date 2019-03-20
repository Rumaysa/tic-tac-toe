# frozen_string_literal: true

require 'spec_helper'

describe EvaluateBoard do
  let(:game) { Game.new(board_width: 3) }
  let(:game_gateway) { GameGatewayStub.new }
  let(:evaluate_board) do
    EvaluateBoard.new(game_gateway)
  end

  it 'continues the game until winning combination or all squares filled' do
    game_gateway.game = game
    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:continue)
  end

  context 'when there is a winner' do
    it 'evaluates winning marks in a horizontal row' do
      game_gateway.game = game
      game.board = ['X', 'X', 'X', nil, nil, nil, nil, 'O', 'O']
      response = evaluate_board.execute({})
      expect(response[:outcome]).to eq(:player_one_wins)
    end

    it 'evaluates winning marks in a vertical row' do
      game_gateway.game = game
      game.board = ['X', nil, nil, 'X', nil, nil, 'X', 'O', 'O']
      response = evaluate_board.execute({})
      expect(response[:outcome]).to eq(:player_one_wins)
    end

    it 'evaluates winning marks in a vertical row (example 2)' do
      game_gateway.game = game
      game.board = [nil, 'X', nil, 'O', 'X', 'O', nil, 'X', nil]
      response = evaluate_board.execute({})
      expect(response[:outcome]).to eq(:player_one_wins)
    end

    it 'evaluates winning marks in a horizontal row for other player' do
      game_gateway.game = game
      game.board = ['O', 'O', 'O', nil, nil, nil, nil, 'X', 'X']
      response = evaluate_board.execute({})
      expect(response[:outcome]).to eq(:player_two_wins)
    end

    it 'evaluates winning marks in right diagonal' do
      game_gateway.game = game
      game.board = [nil, nil, 'O', nil, 'O', nil, 'O', 'X', 'X']
      response = evaluate_board.execute({})
      expect(response[:outcome]).to eq(:player_two_wins)
    end

    it 'evaluates winning marks in a left diagonal' do
      game_gateway.game = game
      game.board = ['O', nil, nil, nil, 'O', nil, 'X', 'X', 'O']
      response = evaluate_board.execute({})
      expect(response[:outcome]).to eq(:player_two_wins)
    end
  end

  it 'can end the game when all squares are filled' do
    game_gateway.game = game
    game.board = %w[X O X X O X O X O]
    response = evaluate_board.execute({})
    expect(response[:outcome]).to eq(:game_over)
  end
end
