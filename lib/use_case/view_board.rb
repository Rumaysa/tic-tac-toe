# frozen_string_literal: true

class ViewBoard
  def initialize(game_gateway)
    @game_gateway = game_gateway
  end

  def execute
    game = @game_gateway.fetch_game
    game.board
  end
end
