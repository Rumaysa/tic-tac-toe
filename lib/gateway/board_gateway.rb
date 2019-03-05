# frozen_string_literal: true

class InMemoryBoardGateway
  def initialize(board)
    @board = board
  end

  def fetch_board
    @board
  end

  def update(player, at_index)
    @board[at_index] = player
  end
end
