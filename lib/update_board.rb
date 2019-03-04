# frozen_string_literal: true

class UpdateBoard
  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute(player, at_index:)
    board = @board_gateway.fetch_board
    raise RangeError unless index_in_range?(at_index, board.length)

    @board_gateway.update(player, at_index) if board[at_index].nil?
  end

  private

  def index_in_range?(index, range)
    (0..range).cover?(index)
  end
end
