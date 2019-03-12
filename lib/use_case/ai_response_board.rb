# frozen_string_literal: true

class AIResponse
  def initialize(winning_combinations)
    @winning_combinations = winning_combinations
  end

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
    @chance_to_block = []
    @winning_combinations.each do |combination|
      next if already_blocked(combination, board)

      @chance_to_block << combination.select { |i| i if board[i] != 'X' }
    end
    @chance_to_block.select do |chances|
      chances if chances.length == 1
    end.first.first
  end

  def already_blocked(combination, board)
    combination.any? { |i| board[i] == 'O' }
  end
end
