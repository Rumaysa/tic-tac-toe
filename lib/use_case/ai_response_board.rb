# frozen_string_literal: true

class AIResponse
  def initialize(board_gateway, winning_combinations)
    @board_gateway = board_gateway
    @winning_combinations = winning_combinations
  end

  def execute(*)
    game = @board_gateway.fetch_board
    min_max(game)[1]
  end

  # def minimax(game, player = 'O')
  #   possible_moves = []
  #   game.board.each_with_index do |move, index|
  #     possible_moves << index if move.nil?
  #   end
  #   score = []
  #   possible_moves.each do |move|
  #     temp_game = Game.new(board_width: 3)
  #     temp_game.board = game.board.dup
  #     temp_game.board[move] = player
  #     if temp_game.board.compact.length <= 3
  #       possible_moves = []
  #       temp_game.board.each_with_index do |move, index|
  #         possible_moves << index if move.nil?
  #       end
  #       player = player == 'O' ? 'X' : 'O'
  #       possible_moves.each do |move|
  #         temp_game = Game.new(board_width: 3)
  #         temp_game.board = game.board.dup
  #         temp_game.board[move] = player
  #         if temp_game.evaluate == :player_one_wins
  #           score << [-1, move]
  #         elsif temp_game.evaluate == :player_two_wins
  #           score << [+1, move]
  #         else
  #           score << [0, move]
  #         end
  #       end
  #     end
  #     if temp_game.evaluate == :player_one_wins
  #       score << [-1, move]
  #     elsif temp_game.evaluate == :player_two_wins
  #       score << [+1, move]
  #     else
  #       score << [0, move]
  #     end
  #   end
  #   score.max[1]
  # end

  private

  def min_max(game, player = 'O')
    return [score(game), nil] if game.evaluate == :game_over
    return [score(game), nil] if game.evaluate == :player_one_wins
    return [score(game), nil] if game.evaluate == :player_two_wins

    empty_cell_indexes = game.board.each_index.select do |i|
      game.board[i].nil?
    end

    puts "ARRAY OF: #{empty_cell_indexes.inspect}"
    scored_moves = []

    empty_cell_indexes.each do |cell_index|
      puts "cell index is #{cell_index.inspect}"
      temp_game = Game.new(board_width: 3)
      temp_game.board = game.board.dup
      temp_game.board[cell_index] = player
      if player == 'O'
        score = min_max(temp_game, 'X')[0]
      else
        score = min_max(temp_game, 'O')[0]
      end
      scored_moves << [score, cell_index]
    end
    puts "SCORED MOVES #{scored_moves.inspect}"
    if player == 'O'
      scored_moves.max
    else
      scored_moves.min
    end
  end

  def score(game)
    return 0 if game.evaluate == :game_over
    return -10 if game.evaluate == :player_one_wins
    return +10 if game.evaluate == :player_two_wins
  end
end