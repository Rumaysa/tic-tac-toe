# frozen_string_literal: true

class UpdateBoard
  DuplicationError = Class.new(RuntimeError)

  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute(player, at_index:)
    game = @board_gateway.fetch_game
    board = game.board
    raise RangeError unless index_in_range?(at_index, board.length)
    raise DuplicationError unless board[at_index].nil?

    board[at_index] = player
    @board_gateway.update(game)
  end

  private

  def index_in_range?(index, range)
    (0...range).cover?(index)
  end
end
