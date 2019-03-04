#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/ui_board'
require_relative '../lib/fetch_board'
require_relative '../lib/update_board'
require_relative '../lib/evaluate_board'
require_relative '../lib/gateway/board_gateway'
require_relative '../lib/domain/board'

class Game
  def initialize
    @active_player = 'X'
    @game_ui = UI.new(stdout: STDOUT, stdin: STDIN)
    board = Board.new(size: 9)
    @board_gateway = InMemoryBoardGateway.new(board)
    @fetch_board = FetchBoard.new(@board_gateway)
    @evaluate_board = EvaluateBoard.new(@board_gateway)
    @update_board = UpdateBoard.new(@board_gateway)
  end

  def execute
    @game_ui.start
    display_current_board
    while @evaluate_board.execute == :Continue
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
    @active_player =
      if @active_player == 'X'
        'O'
      else
        'X'
      end
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
    @game_ui.display_board(@fetch_board.execute)
  end

  def display_outcome
    outcome = @evaluate_board.execute.to_s + "\n"
    @game_ui.display_message(outcome)
  end
end

game = Game.new
game.execute
