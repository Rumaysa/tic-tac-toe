# frozen_string_literal: true

class AIResponse
  def initialize(game_gateway)
    @game_gateway = game_gateway
  end

  def execute(active_player:)
    game = @game_gateway.fetch_game
    min_max(game, active_player)[1]
  end

  private

  def min_max(game, player = 'O')
    return [score(game), nil] if game.full_board?
    return [score(game), nil] if game.win_for_player?('X')
    return [score(game), nil] if game.win_for_player?('O')

    empty_cell_indexes = game.board.each_index.select do |i|
      game.board[i].nil?
    end
    scored_moves = []

    empty_cell_indexes.each do |cell_index|
      temp_game = Game.new(board_width: 3)
      temp_game.board = game.board.dup
      temp_game.board[cell_index] = player
      if player == 'O'
        score = min_max(temp_game, 'X')[0]
      else
        score = min_max(temp_game, 'O')[0]
      end
      scored_moves << [score, cell_index]
      # puts "scored moves: #{scored_moves}"
    end

    player == 'O' ? scored_moves.max : scored_moves.min
  end

  def score(game)
    return -10 if game.win_for_player?('X')
    return +10 if game.win_for_player?('O')
    return 0 if game.full_board?
  end

  
end
