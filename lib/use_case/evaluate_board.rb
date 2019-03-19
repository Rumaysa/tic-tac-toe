# frozen_string_literal: true

class EvaluateBoard
  def initialize(game_gateway)
    @game_gateway = game_gateway
  end

  def execute(*)
    game = @game_gateway.fetch_game
    outcome = :continue

    outcome = :game_over if game.full_board?
    outcome = :player_one_wins if game.win_for_player?('X')
    outcome = :player_two_wins if game.win_for_player?('O')

    {
      outcome: outcome
    }
  end
end
