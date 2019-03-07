# frozen_string_literal: true

class ViewBoard
  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute
    @board_gateway.fetch_board
  end
end
