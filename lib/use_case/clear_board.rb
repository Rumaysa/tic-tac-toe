# frozen_string_literal: true

class ClearBoard
  def initialize(game_gateway)
    @game_gateway = game_gateway
  end

  def execute
    game = @game_gateway.fetch_game
    board = game.board
    board.map! { nil }
    game.player_turn = 'X'
    @game_gateway.update(game)
  end
end
