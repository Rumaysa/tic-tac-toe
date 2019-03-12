# frozen_string_literal: true

class BoardGatewayStub
  attr_writer :board

  def fetch_board
    @board
  end
end
