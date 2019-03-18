# frozen_string_literal: true

class Game
  attr_accessor :board
  def initialize(board_width:)
    size = board_width * board_width
    @board = Array.new(size)
  end

  
end
