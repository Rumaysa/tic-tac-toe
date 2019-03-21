# frozen_string_literal: true

class UpdateBoard
  DuplicationError = Class.new(RuntimeError)
  IncorrectMarkerError = Class.new(RuntimeError)
  WrongTurnError = Class.new(RuntimeError)

  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute(player, at_index:)
    game = @board_gateway.fetch_game
    board = game.board
    raise RangeError unless index_in_range?(at_index, board.length)
    raise DuplicationError unless board[at_index].nil?
    raise IncorrectMarkerError unless valid_mark?(player)
    raise WrongTurnError if player != game.player_turn

    board[at_index] = player
    @board_gateway.update(game)
    game.player_turn = player == 'X' ? 'O' : 'X'
  end

  private

  def index_in_range?(index, range)
    (0...range).cover?(index)
  end

  def valid_mark?(player)
    %w[X O].include?(player)
  end
end
