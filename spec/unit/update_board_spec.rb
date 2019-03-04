# frozen_string_literal: true

describe UpdateBoard do
  class BoardGatewaySpy
    attr_reader :board

    def initialize
      @board = Array.new(9, nil)
    end

    def fetch_board
      @board
    end

    def update(player, at_index)
      @board[at_index] = player
    end
  end

  let(:board_gateway) { BoardGatewaySpy.new }
  let(:update_board) { UpdateBoard.new(board_gateway) }

  it 'can update the board with players mark' do
    update_board.execute('X', at_index: 6)

    expect(board_gateway.board).to eq(
      [nil, nil, nil, nil, nil, nil, 'X', nil, nil]
    )
  end

  it 'cannot allow any player to make the same move twice' do
    update_board.execute('X', at_index: 7)

    expect do
      update_board.execute('O', at_index: 7)
    end.to raise_error(DuplicationError)
  end

  it 'cannot allow any player to mark incorrectly' do
    expect do
      update_board.execute('X', at_index: 9)
    end.to raise_error(RangeError)
  end

  it 'cannot allow any player to mark incorrectly, example 2' do
    expect do
      update_board.execute('X', at_index: -1)
    end.to raise_error(RangeError)
  end
end
