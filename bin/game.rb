#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/use_case/view_board'
require_relative '../lib/ui_board'
require_relative '../lib/use_case/update_board'
require_relative '../lib/use_case/evaluate_board'
require_relative '../lib/gateway/board_gateway'
require_relative '../lib/domain/board'

class Game
  def initialize
    @active_player = 'X'
    @game_ui = UI.new(stdout: STDOUT, stdin: STDIN)
    board = Board.new(width: 3)
    @board_gateway = InMemoryBoardGateway.new(board)
    @view_board = ViewBoard.new(@board_gateway)
    @evaluate_board = EvaluateBoard.new(@board_gateway)
    @update_board = UpdateBoard.new(@board_gateway)
  end

  def execute
    @game_ui.start
    display_current_board
    while @evaluate_board.execute == :continue
      prompt_player_to_place_mark
      begin
        place_players_mark
      rescue RangeError
        exception_message("\nPlease choose a valid mark\n")
      rescue DuplicationError
        exception_message("\nPlease choose an empty cell\n")
      else
        display_current_board
        next_turn
      end
    end
    display_outcome
  end

  private

  def next_turn
    @active_player = @active_player == 'X' ? 'O' : 'X'
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
    game_status = @evaluate_board.execute
    outcome = @game_ui.interpret_game_status(game_status)
    @game_ui.display_message(outcome)
  end
end

game = Game.new
game.execute
