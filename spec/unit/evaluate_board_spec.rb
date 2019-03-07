# frozen_string_literal: true

describe EvaluateBoard do

  let(:board_gateway) { BoardGatewayStub.new }
  let(:evaluate_board) { EvaluateBoard.new(board_gateway) }

  it 'continues the game until winning combination or all squares filled' do
    board_gateway.board = Board.new(size: 9)
    expect(evaluate_board.execute).to eq(:continue)
  end

  context 'when there is a winner' do
    it 'evaluates winning marks in a horizontal row' do
      board_gateway.board = ['X', 'X', 'X', nil, nil, nil, nil, 'O', 'O']

      expect(evaluate_board.execute).to eq(:player_one_wins)
    end

    it 'evaluates winning marks in a vertical row' do
      board_gateway.board = ['X', nil, nil, 'X', nil, nil, 'X', 'O', 'O']

      expect(evaluate_board.execute).to eq(:player_one_wins)
    end

    it 'evaluates winning marks in a vertical row (example 2)' do
      board_gateway.board = [nil, 'X', nil, 'O', 'X', 'O', nil, 'X', nil]

      expect(evaluate_board.execute).to eq(:player_one_wins)
    end

    it 'evaluates winning marks in a horizontal row for other player' do
      board_gateway.board = ['O', 'O', 'O', nil, nil, nil, nil, 'X', 'X']

      expect(evaluate_board.execute).to eq(:player_two_wins)
    end

    it 'evaluates winning marks in right diagonal' do
      board_gateway.board = [nil, nil, 'O', nil, 'O', nil, 'O', 'X', 'X']

      expect(evaluate_board.execute).to eq(:player_two_wins)
    end

    it 'evaluates winning marks in a left diagonal' do
      board_gateway.board = ['O', nil, nil, nil, 'O', nil, 'X', 'X', 'O']

      expect(evaluate_board.execute).to eq(:player_two_wins)
    end
  end

  it 'can end the game when all squares are filled' do
    board_gateway.board = %w[X O X X O X O X O]

    expect(evaluate_board.execute).to eq(:game_over)
  end
end
