class ClearBoard
  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute
    board = @board_gateway.fetch_board
    board.map! { nil }
  end
end
