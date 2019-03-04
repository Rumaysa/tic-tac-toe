# frozen_string_literal: true

class FetchBoard
  attr_reader :state

  def initialize(board_gateway)
    @board_gateway = board_gateway
    @state = [nil] * 9
  end

  def execute
    @board_gateway.fetch_board
  end
end
