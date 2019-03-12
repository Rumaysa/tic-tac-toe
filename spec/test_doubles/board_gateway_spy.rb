# frozen_string_literal: true

class BoardGatewaySpy
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def fetch_board
    @board
  end

  def update(board)
    @board = board
  end
end
