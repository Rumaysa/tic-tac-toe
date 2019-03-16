# frozen_string_literal: true

class Game
  attr_accessor :board
  def initialize(width:)
    size = width * width
    @board = Array.new(size)
  end
end
