# frozen_string_literal: true
require 'spec_helper'
describe AIResponse do
  let(:game) { Game.new(width: 3) }
  let(:find_wining_combinations) { FindWinningCombinations.new }
  let(:winning_combinations) do
    find_wining_combinations.execute(game.board)
  end
  let(:ai_response) { AIResponse.new(winning_combinations) }

  it 'can respond' do
    game = Game.new(width: 3)

    expect(ai_response.execute(game.board)).to eq(4)
  end

  context 'when player has one mark on the board' do
    it 'can respond to a players mark when it is not in the middle' do
      game.board = ['X', nil, nil, nil, nil, nil, nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(4)
    end

    it 'can respond to a players mark when it is in the middle' do
      game.board = [nil, nil, nil, nil, 'X', nil, nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(0)
    end
  end

  context 'when and player has two marks on the board' do
    it 'can block player from winning' do
      game.board = ['X', 'X', nil,
               nil, 'O', nil,
               nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(2)
    end

    it 'can block player from winning, example 2' do
      game.board = ['X', nil, 'X',
               nil, 'O', nil,
               nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(1)
    end

    it 'can block player from winning, example 3' do
      game.board = ['X', nil, nil,
               'X', 'O', nil,
               nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(6)
    end

    it 'can block player from winning, example 4' do
      game.board = ['X', nil, nil,
               nil, 'O', nil,
               'X', nil, nil]

      expect(ai_response.execute(game.board)).to eq(3)
    end

    it 'can block player from winning, example 5' do
      game.board = [nil, 'X', 'X',
               nil, 'O', nil,
               nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(0)
    end

    it 'can block player from winning, example 6' do
      game.board = [nil, nil, 'X',
               nil, 'O', 'X',
               nil, nil, nil]

      expect(ai_response.execute(game.board)).to eq(8)
    end

    it 'can block player from winning, example 7' do
      game.board = [nil, nil, nil,
               'X', 'O', nil,
               'X', nil, nil]

      expect(ai_response.execute(game.board)).to eq(0)
    end

    it 'can block player from winning, example 8' do
      game.board = [nil, nil, nil,
               nil, 'O', 'X',
               nil, nil, 'X']

      expect(ai_response.execute(game.board)).to eq(2)
    end

    it 'can block player from winning, example 9' do
      game.board = [nil, nil, nil,
               nil, 'O', nil,
               'X', 'X', nil]

      expect(ai_response.execute(game.board)).to eq(8)
    end

    it 'can block player from winning, example 10' do
      game.board = [nil, nil, nil,
               nil, 'O', nil,
               nil, 'X', 'X']

      expect(ai_response.execute(game.board)).to eq(6)
    end
  end

  context 'AI looks for all possible outcomes '
  it 'can play a tie' do
    game.board = ['X', 'O', nil,
             nil, 'O', nil,
             nil, 'X', 'X']

    expect(ai_response.execute(game.board)).to eq(6)
  end
end
