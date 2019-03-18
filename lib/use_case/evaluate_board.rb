# frozen_string_literal: true

class EvaluateBoard
  def initialize(board_gateway, winning_combinations)
    @board_gateway = board_gateway
    @winning_combinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def execute(*)

    outcome = :continue

    outcome = :game_over if full_board?
    outcome = :player_one_wins if win_for_player?('X')
    outcome = :player_two_wins if win_for_player?('O')

    {
      outcome: outcome
    }
  end

  private

  def full_board?
    board = @board_gateway.fetch_board
    return false if board.nil?

    board.compact.length == 9
  end

  def win_for_player?(player)
    board = @board_gateway.fetch_board

    players_marks = []
    board.each_with_index { |cell, i| players_marks << i if cell == player }
    @winning_combinations.each do |combination|
      return true if match?(players_marks, combination)
    end
    false
  end

  def match?(players_marks, combination)
    (combination & players_marks).length == 3
  end
end
