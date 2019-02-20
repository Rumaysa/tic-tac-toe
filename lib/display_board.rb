class DisplayBoard
  def initialize(board_gateway)
    @board_gateway = board_gateway
    @state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
  end

  def state
    @state
  end

  def execute
    @board_gateway.fetch_board
  end
end