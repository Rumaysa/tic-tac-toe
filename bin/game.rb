#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/ui_board'
require_relative '../lib/fetch_board'
require_relative '../lib/update_board'
require_relative '../lib/evaluate_board'

class InMemoryBoardGateway
  attr_reader :board

  def initialize
    @board = [nil] * 9
  end

  def fetch_board
    @board
  end

  def update(player, at_index)
    @board[at_index] = player
  end
end

class Game
  def initialize
    @active_player = 'X'
    @game_ui = UI.new(stdout: STDOUT, stdin: STDIN)
    @board_gateway = InMemoryBoardGateway.new
    @fetch_board = FetchBoard.new(@board_gateway)
    @evaluate_board = EvaluateBoard.new(@board_gateway)
    @update_board = UpdateBoard.new(@board_gateway)
  end

  def execute
    @game_ui.start
    @game_ui.display_board(@fetch_board.execute)
    while @evaluate_board.execute == :Continue
      prompt_player_to_place_mark
      players_choice = @game_ui.users_input.to_i
      @update_board.execute(@active_player, at_index: players_choice - 1)
      @game_ui.display_board(@fetch_board.execute)
      next_turn
    end
    @game_ui.display_message(@evaluate_board.execute)
  end

  def next_turn
    @active_player =
      if @active_player == 'X'
        'O'
      else
        'X'
      end
  end

  def prompt_player_to_place_mark
    @game_ui.display_message("Player #{@active_player}, choose a number on the grid to put your mark")
  end
end

game = Game.new
game.execute
