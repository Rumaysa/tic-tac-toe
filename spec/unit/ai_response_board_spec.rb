# frozen_string_literal: true

describe AIResponse do
  let(:game) { Game.new(board_width: 3) }
  let(:game_gateway) { InMemoryGameGateway.new(game) }
  let(:find_wining_combinations) { FindWinningCombinations.new }
  let(:winning_combinations) do
    find_wining_combinations.execute(game.board)
  end
  let(:ai_response) { AIResponse.new(game_gateway) }

  it 'can respond' do
    game_gateway.update(game)
    expect(ai_response.execute).to eq(8)
  end

  def expected_AI_response(board, response)
    game = game_gateway.fetch_game
    game.board = board
    game_gateway.update(game)
    expect(ai_response.execute).to eq(response)
  end
  context 'when player has one mark on the board' do
    it 'can respond to a players mark when it is not in the middle' do
      expected_AI_response(
        ['X', nil, nil,
         nil, nil, nil,
         nil, nil, nil], 4
      )
    end

    it 'can respond to a players mark when it is in the middle' do
      expected_AI_response(
        [nil, nil, nil,
         nil, 'X', nil,
         nil, nil, nil], 8
      )
    end
  end

  context 'when and player has two marks on the board' do
    it 'can block player from winning horizontally' do
      expected_AI_response(
        ['X', 'X', nil,
         nil, 'O', nil,
         nil, nil, nil], 2
      )
    end

    it 'can block player from winning horizontally, example 2' do
      expected_AI_response(
        ['X', nil, 'X',
         nil, 'O', nil,
         nil, nil, nil], 1
      )
    end
    it 'can block player from winning horizonatally, example 3' do
      expected_AI_response(
        [nil, 'X', 'X',
         nil, 'O', nil,
         nil, nil, nil], 0
      )
    end


    it 'can block player from winning horizontally, example 4' do
      expected_AI_response(
        [nil, nil, nil,
         nil, 'O', nil,
         'X', 'X', nil], 8
      )
    end

    it 'can block player from winning horizontally, example 5' do
      expected_AI_response(
        [nil, nil, nil,
         nil, 'O', nil,
         nil, 'X', 'X'], 6
      )
    end

    it 'can block player from winning vertically' do
      expected_AI_response(
        ['X', nil, nil,
         'X', 'O', nil,
         nil, nil, nil], 6
      )
    end

    it 'can block player from winning vertically, example 2' do
      expected_AI_response(
        ['X', nil, nil,
         nil, 'O', nil,
         'X', nil, nil], 3
      )
    end

    it 'can block player from winning vertically, example 3' do
      expected_AI_response(
        [nil, nil, 'X',
         nil, 'O', 'X',
         nil, nil, nil], 8
      )
    end

    it 'can block player from winning vertically, example 4' do
      expected_AI_response(
        [nil, nil, nil,
         'X', 'O', nil,
         'X', nil, nil], 0
      )
    end

    it 'can block player from winning vertically, example 5' do
      expected_AI_response(
        [nil, nil, nil,
         nil, 'O', 'X',
         nil, nil, 'X'], 2
      )
    end
  end

  context 'AI looks for all possible outcomes ' do
    it 'can play a tie' do
      expected_AI_response(
        ['X', 'O', nil,
         nil, 'O', nil,
         nil, 'X', 'X'], 6
      )
    end
  end

  context 'when AI considers future moves' do
    it 'can pick the winning move from two available moves' do
      expected_AI_response(
        ['X', 'X', 'O',
         'O', 'O', 'X',
         nil, 'X', nil], 6
      )
    end

    it 'can pick the winning move from two available moves, example 2' do
      expected_AI_response(
        [nil, 'O', 'O',
         'X', 'X', 'O',
         nil, 'X', 'X'], 0
      )
    end

    it 'can pick the winning move from two available moves, example 3' do
      expected_AI_response(
        ['X', 'X', 'O',
         nil, 'O', nil,
         'X', 'O', 'X'], 3
      )
    end

    it 'can pick the winning move from four available moves' do
      expected_AI_response(
        ['X', 'O', nil,
         'O', 'X', 'X',
         nil, nil, nil], 8
      )
    end 

    it 'can pick the winning move from six available moves' do
      expected_AI_response(
        [nil, 'X', 'X',
         nil, 'O', nil,
         nil, nil, nil], 0
      )
    end
  end
end
