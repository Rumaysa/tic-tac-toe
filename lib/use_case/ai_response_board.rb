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
      block_opponent(board)
    end
  end

  private

  def minimax(board, max: true)
    empty_cell_indexes = board.map.with_index { |cell, i| i if cell.nil? }
    choices = []
    empty_cell_indexes.each do |cell_index|
      temp_board = board
      board[cell_index] = 'X'
      # choices = [cell_index, score] if temp_board_winning
      # minimax(temp_board)
    end
  end

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
