class UpdateBoard
  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute(player, at_index:)
    board = @board_gateway.fetch_board
    @board_gateway.update(player, at_index) if board[at_index].nil?
  end
end