# frozen_string_literal: true

class GameGatewaySpy
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def fetch_game
    @game
  end

  def update(game)
    @game = game
  end
end
