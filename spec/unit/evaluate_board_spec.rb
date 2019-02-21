describe EvaluateBoard do
  class BoardGatewayStub
    attr_writer :board

    def fetch_board
      @board
    end
  end

  it 'continues the game until winning combination or all squares filled' do
    board_gateway = BoardGatewayStub.new
    evaluate_board = EvaluateBoard.new(board_gateway)

    expect(evaluate_board.execute).to eq(nil)
  end

  it 'evaluates the game when player one marks three in a horizontal row' do
    board_gateway = BoardGatewayStub.new
    evaluate_board = EvaluateBoard.new(board_gateway)

    board_gateway.board = ['X', 'X', 'X', nil, nil, nil, nil, 'O', 'O']

    expect(evaluate_board.execute).to eq('Player one wins')
  end

  it 'evaluates the game when player one marks three in a vertical row' do
    board_gateway = BoardGatewayStub.new
    evaluate_board = EvaluateBoard.new(board_gateway)

    board_gateway.board = ['X', nil, nil, 'X', nil, nil, 'X', 'O', 'O']

    expect(evaluate_board.execute).to eq('Player one wins')
  end

  it 'evaluates the game when player one marks three in a vertical row (example 2)' do
    board_gateway = BoardGatewayStub.new
    evaluate_board = EvaluateBoard.new(board_gateway)

    board_gateway.board = [nil, 'X', nil, 'O', 'X', 'O', nil, 'X', nil]

    expect(evaluate_board.execute).to eq('Player one wins')
  end
end
