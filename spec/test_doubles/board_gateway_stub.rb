class BoardGatewayStub
  attr_writer :board

  def fetch_board
    @board
  end
end
