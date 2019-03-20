# frozen_string_literal: true

class AIResponse
  def initialize(game_gateway, winning_combinations)
    @game_gateway = game_gateway
    @winning_combinations = winning_combinations
  end

  def execute(*)
    game = @game_gateway.fetch_game
    min_max(game)[1]
  end

  private

  def min_max(game, player = 'O')
    return [score(game), nil] if game.evaluate == :game_over
    return [score(game), nil] if game.evaluate == :player_one_wins
    return [score(game), nil] if game.evaluate == :player_two_wins

    empty_cell_indexes = game.board.each_index.select do |i|
      game.board[i].nil?
    end
    scored_moves = []

    empty_cell_indexes.each do |cell_index|
      temp_game = Game.new(board_width: 3)
      temp_game.board = game.board.dup
      temp_game.board[cell_index] = player
      if player == 'O'
        score = min_max(temp_game, 'X')[0]
      else
        score = min_max(temp_game, 'O')[0]
      end
      scored_moves << [score, cell_index]
    end

    player == 'O' ? scored_moves.max : scored_moves.min
  end

  def score(game)
    return 0 if game.evaluate == :game_over
    return -10 if game.evaluate == :player_one_wins
    return +10 if game.evaluate == :player_two_wins
  end
end
