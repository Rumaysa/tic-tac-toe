# frozen_string_literal: true

class AIResponse
  def initialize(board_gateway, winning_combinations)
    @board_gateway = board_gateway
    @winning_combinations = winning_combinations
  end

  def execute(*)
    game = @board_gateway.fetch_board
    minimax(game)
  end

  def minimax(game, player = 'O')
    possible_moves = []
    game.board.each_with_index do |move, index|
      possible_moves << index if move.nil?
    end
    score = []
    possible_moves.each do |move|
      temp_game = Game.new(board_width: 3)
      temp_game.board = game.board.dup
      temp_game.board[move] = player
      if temp_game.board.compact.length <= 3
        possible_moves = []
        temp_game.board.each_with_index do |move, index|
          possible_moves << index if move.nil?
        end
        player = player == 'O' ? 'X' : 'O'
        possible_moves.each do |move|
          temp_game = Game.new(board_width: 3)
          temp_game.board = game.board.dup
          temp_game.board[move] = player
          if temp_game.evaluate == :player_one_wins
            score << [-1, move]
          elsif temp_game.evaluate == :player_two_wins
            score << [+1, move]
          else
            score << [0, move]
          end
        end
      end
      if temp_game.evaluate == :player_one_wins
        score << [-1, move]
      elsif temp_game.evaluate == :player_two_wins
        score << [+1, move]
      else
        score << [0, move]
      end
    end
    score.max[1]
  end

  private

  def minimax_idea(game, player = 'O')
    empty_cell_indexes = game.board.map.with_index { |cell, i| i if cell.nil? }
    scored_moves = []
    return scored_moves if board.evaluate == :game_over
    empty_cell_indexes.each do |cell_index|
      temp_game = Game.new(board_width: 3)
      temp_game.board = game.board.dup
      temp_game.board[cell_index] = player
      scored_moves << [10, cell_index] if temp_game.board.evaluate == :player_two_wins
      scored_moves << [-10, cell_index] if temp_game.board.evaluate == :player_one_wins
      scored_moves << [0, cell_index] if temp_game.board.evaluate == :game_over
      scored_moves << if player == 'O'
                        minimax(temp_board, 'X')
                      else
                        minimax(temp_board, 'O')
                      end
    end
  end

  # def block_opponent(board)
  #   @chance_to_block = []
  #   @winning_combinations.each do |combination|
  #     next if already_blocked(combination, board)

  #     @chance_to_block << combination.reject { |i| i if board[i] == 'X' }
  #   end
  #   @chance_to_block.select do |chances|
  #     chances if chances.length == 1
  #   end.first.first
  # end

  # def already_blocked(combination, board)
  #   combination.any? { |i| board[i] == 'O' }
  # end
end