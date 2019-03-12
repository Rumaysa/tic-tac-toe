# frozen_string_literal: true

class AIResponse
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

  def execute(board)
    if board[4].nil?
      4
    elsif board[4] == 'X'
      0
    else
      # minimax(board, 'O')[1]
      block_opponent(board)
    end
  end

  private

  def block_opponent(board)
    ai_response = []
    WINNING_COMBINATIONS.each do |combination|
      combination.each do |index|
        ai_response << index if board[index] != 'X'
      end
      if ai_response.length == 1 && empty_cell?(ai_response.first, board)
        return ai_response.first
      end

      ai_response = []
    end
    nil
  end

  def empty_cell?(at_index, board)
    board[at_index].nil?
  end
end
