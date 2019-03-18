# frozen_string_literal: true

class AIResponse
  def initialize(board_gateway, winning_combinations)
    @board_gateway = board_gateway
    @winning_combinations = winning_combinations
  end

  def execute(*)
    board = @board_gateway.fetch_board
    if board[4].nil?
      4 
    else
      block_opponent(board)
    end
  end

  private

  def block_opponent(board)
    @chance_to_block = []
    @winning_combinations.each do |combination|
      next if already_blocked(combination, board)

      @chance_to_block << combination.reject { |i| i if board[i] == 'X' }
    end
    @chance_to_block.select do |chances|
      chances if chances.length == 1
    end.first.first
  end

  def already_blocked(combination, board)
    combination.any? { |i| board[i] == 'O' }
  end

  def minimax(board, player = 'O')
    possible_moves = board.map.with_index { |move, i| i if move.nil? }
    possible_moves.each do | position |
      board[position] = player
      player = player == 'O' ? 'X' : 'O'
    
  end

  def minimax_idea(board, player)
    empty_cell_indexes = board.map.with_index { |cell, i| i if cell.nil? }
    scored_moves = []
    return scored_moves if board.evaluate == :game_over
    empty_cell_indexes.each do |cell_index|
      temp_board = board
      temp_board[cell_index] = player
      scored_moves << [10, cell_index] if temp_board.evaluate == :player_two_wins
      scored_moves << [-10, cell_index] if temp_board.evaluate == :player_one_wins
      scored_moves << [0, cell_index] if temp_board.evaluate == :game_over
      scored_moves << if player == 'O'
                        minimax(temp_board, 'X')
                      else
                        minimax(temp_board, 'O')
                      end
    end
  end
end
end 