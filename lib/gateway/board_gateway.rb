# frozen_string_literal: true

class InMemoryBoardGateway
  def initialize(board)
    @board = board
  end

  def fetch_board
    @board.dup
  end

  def update(board)
    @board = board
  end
end
