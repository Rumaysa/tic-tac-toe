class FinishGame
  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute
    board = @board_gateway.fetch_board
    if board.nil?
      return nil
    else
      'Player one wins' if board[0..2] == ['X', 'X', 'X']
    end
  end
end