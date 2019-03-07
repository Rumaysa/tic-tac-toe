# frozen_string_literal: true

class AIResponse
  def execute(board)
    if board[4].nil?
      4
    elsif board[4] == 'X'
      0
    else
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
      return ai_response.first if ai_response.length == 1 && empty_cell?(ai_response.first, board)
      ai_response = []
    end
    return nil
  end

  def empty_cell?(at_index, board)
    board[at_index].nil?
  end
end
