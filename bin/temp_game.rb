#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/use_case/view_board'
require_relative '../lib/ui_board'
require_relative '../lib/use_case/update_board'
require_relative '../lib/use_case/evaluate_board'
require_relative '../lib/use_case/ai_response_board'
require_relative '../lib/gateway/game_gateway'
require_relative '../lib/domain/game'

class TestGame
  def initialize
    @game_ui = UI.new(stdout: STDOUT, stdin: STDIN)
    game = Game.new(board_width: 3)
    @game_gateway = InMemoryGameGateway.new(game)
    @view_board = ViewBoard.new(@game_gateway)
    @evaluate_board = EvaluateBoard.new(@game_gateway)
    @minimax_ai = AIResponse.new(@game_gateway)
    @update_board = UpdateBoard.new(@game_gateway)
    @active_player = game.player_turn
  end

  def execute
    @game_ui.start
    display_current_board
    while @evaluate_board.execute[:outcome] == :continue
      begin
        if @active_player == 'X'
          prompt_player_to_place_mark
          place_players_mark
        else
          place_ai_mark
        end
        # place_ai_mark
      rescue RangeError
        exception_message("\nPlease choose a valid mark\n")
      rescue UpdateBoard::DuplicationError
        exception_message("\nPlease choose an empty cell\n")
      else
        display_current_board
        next_turn
      end
    end
    display_outcome
  end

  private

  def place_ai_mark
    ai_choice = @minimax_ai.execute(@active_player)
    @update_board.execute(@active_player, at_index: ai_choice)
  end

  def next_turn
    game = @game_gateway.fetch_game
    @active_player = game.player_turn
  end

  def prompt_player_to_place_mark
    @game_ui.display_message(
      "Player #{@active_player}, choose a number on the grid to put your mark: "
    )
  end

  def exception_message(message)
    @game_ui.display_message(message)
    display_current_board
  end

  def place_players_mark
    players_choice = @game_ui.users_input.to_i
    @update_board.execute(@active_player, at_index: players_choice - 1)
  end

  def display_current_board
    @game_ui.display_board(@view_board.execute)
  end

  def display_outcome
    game_status = @evaluate_board.execute[:outcome]
    outcome = @game_ui.interpret_game_status(game_status)
    @game_ui.display_message(outcome)
  end
end

game = TestGame.new
game.execute
