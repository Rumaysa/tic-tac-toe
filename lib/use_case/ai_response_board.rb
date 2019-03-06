# frozen_string_literal: true

class AIResponse
  def execute(board)
    return 6 if board[7] == 'X'
    return 1 if board[8] == 'X'
    return 7 if board[1] == 'X' && board[4] == 'X'

    board[4] == 'X' ? 0 : 4
  end

  private

  def empty_cell?(index, board)
    board[index].nil?
  end
end
