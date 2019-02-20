describe FinishGame do
  class BoardGatewayStub
    attr_writer :board

    def fetch_board
      @board
    end
  end

  it 'continues the game until winning combination or all squares filled' do
    board_gateway = BoardGatewayStub.new
    finish_game = FinishGame.new(board_gateway)

    expect(finish_game.execute).to eq(nil)
  end

  it 'finishes the game when player one marks three in a row' do
    board_gateway = BoardGatewayStub.new
    finish_game = FinishGame.new(board_gateway)

    board_gateway.board = ['X', 'X', 'X', nil, nil, nil, nil, 'O', 'O']

    expect(finish_game.execute).to eq('Player one wins')
  end
end
