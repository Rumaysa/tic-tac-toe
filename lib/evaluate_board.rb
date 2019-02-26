# frozen_string_literal: true

class EvaluateBoard
  def initialize(board_gateway)
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

  def execute
    return 'Player one wins' if win_for_player?('X')
    return 'Player two wins' if win_for_player?('O')
    return 'Game over' if game_over?

    ''
  end

  private

  def game_over?
    board = @board_gateway.fetch_board
    return false if board.nil?

    board.compact.length == 9
  end

  def win_for_player?(player)
    players_marks = []
    board = @board_gateway.fetch_board
    if board.nil?
      nil
    else
      board.each_with_index { |cell, i| players_marks << i if cell == player }
      @winning_combinations.each do |combination|
        return true if combination.all? do |num|
          players_marks.include?(num)
        end
      end
      false
    end
  end
end
