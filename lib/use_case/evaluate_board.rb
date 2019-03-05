# frozen_string_literal: true

class EvaluateBoard
  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(board_gateway)
    @board_gateway = board_gateway
  end

  def execute
    return :player_one_wins if win_for_player?('X')
    return :player_two_wins if win_for_player?('O')
    return :game_over if game_over?

    :continue
  end

  private

  def game_over?
    board = @board_gateway.fetch_board
    return false if board.nil?

    board.compact.length == 9
  end

  def win_for_player?(player)
    board = @board_gateway.fetch_board
    return false if board.nil?

    players_marks = []
    board.each_with_index { |cell, i| players_marks << i if cell == player }
    WINNING_COMBINATIONS.each do |combination|
      return true if match?(players_marks, combination)
    end
    false
  end

  def match?(players_marks, combination)
    (combination & players_marks).length == 3
  end
end
