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

  context 'when player has one mark on the board' do
    it 'can respond to a players mark when it is not in the middle' do
      game = game_gateway.fetch_game
      game.board = ['X', nil, nil, nil, nil, nil, nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(4)
    end

    it 'can respond to a players mark when it is in the middle' do
      game = game_gateway.fetch_game
      game.board = [nil, nil, nil, nil, 'X', nil, nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(8)
    end
  end

  context 'when and player has two marks on the board' do
    it 'can block player from winning' do
      game = game_gateway.fetch_game
      game.board = ['X', 'X', nil,
               nil, 'O', nil,
               nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute(game.board)).to eq(2)
    end

    it 'can block player from winning, example 2' do
      game = game_gateway.fetch_game
      game.board = ['X', nil, 'X',
               nil, 'O', nil,
               nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute(game.board)).to eq(1)
    end

    it 'can block player from winning, example 3' do
      game = game_gateway.fetch_game
      game.board = ['X', nil, nil,
               'X', 'O', nil,
               nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(6)
    end

    it 'can block player from winning, example 4' do
      game = game_gateway.fetch_game
      game.board = ['X', nil, nil,
               nil, 'O', nil,
               'X', nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(3)
    end

    it 'can block player from winning, example 5' do
      game = game_gateway.fetch_game
      game.board = [nil, 'X', 'X',
               nil, 'O', nil,
               nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(0)
    end

    it 'can block player from winning, example 6' do
      game = game_gateway.fetch_game
      game.board = [nil, nil, 'X',
               nil, 'O', 'X',
               nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(8)
    end

    it 'can block player from winning, example 7' do
      game = game_gateway.fetch_game
      game.board = [nil, nil, nil,
               'X', 'O', nil,
               'X', nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(0)
    end

    it 'can block player from winning, example 8' do
      game = game_gateway.fetch_game
      game.board = [nil, nil, nil,
               nil, 'O', 'X',
               nil, nil, 'X']
               game_gateway.update(game)
      expect(ai_response.execute).to eq(2)
    end

    it 'can block player from winning, example 9' do
      game = game_gateway.fetch_game
      game.board = [nil, nil, nil,
               nil, 'O', nil,
               'X', 'X', nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(8)
    end

    it 'can block player from winning, example 10' do
      game = game_gateway.fetch_game
      game.board = [nil, nil, nil,
               nil, 'O', nil,
               nil, 'X', 'X']
      game_gateway.update(game)
      expect(ai_response.execute).to eq(6)
    end
  end

  context 'AI looks for all possible outcomes ' do
    it 'can play a tie' do
      game = game_gateway.fetch_game
      game.board = ['X', 'O', nil,
              nil, 'O', nil,
              nil, 'X', 'X']
      game_gateway.update(game)
      expect(ai_response.execute(game.board)).to eq(6)
    end
  end

  context 'when implementing minimax' do
    it 'can pick the winning move from two available moves' do
      game = game_gateway.fetch_game
      game.board = ['X', 'X', 'O',
                    'O', 'O', 'X',
                     nil, 'X', nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(6)
    end

    it 'can pick the winning move from two other available moves' do
      game = game_gateway.fetch_game
      game.board = [nil, 'O', 'O',
                    'X', 'X', 'O',
                     nil, 'X', 'X']
      game_gateway.update(game)
      expect(ai_response.execute).to eq(0)
    end

    it 'can pick the winning move from four available moves' do
      game = game_gateway.fetch_game
      game.board = ['X', 'O', nil,
                    'O', 'X', 'X',
                     nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(8)
    end

    it 'can pick the winning move from six available moves' do
      game = game_gateway.fetch_game
      game.board = [nil, 'X', 'X',
                    nil, 'O', nil,
                    nil, nil, nil]
      game_gateway.update(game)
      expect(ai_response.execute).to eq(0)
    end
  end
end
