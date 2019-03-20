# frozen_string_literal: true

class InMemoryGameGateway
  def initialize(game)
    @game = game
  end

  def fetch_game
    @game.dup
  end

  def update(game)
    @game = game
  end
end
