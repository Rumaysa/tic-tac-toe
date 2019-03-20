# frozen_string_literal: true

class GameGatewayStub
  attr_writer :game

  def fetch_game
    @game.dup
  end
end
