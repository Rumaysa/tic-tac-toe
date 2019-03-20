# frozen_string_literal: true

require 'spec_helper'

describe UI do
  let(:ui) { UI.new(stdout: STDOUT, stdin: STDIN) }
  it 'shows the title of the game' do
    expect(STDOUT).to receive(:puts).with("\e[31m\e[1m\n      TIC TAC TOE\e[0m")
    ui.start
  end

  it 'can show an empty UI board' do
    game = Game.new(board_width: 3)
    board = game.board

    expect(STDOUT).to receive(:puts).with("\n1|2|3\n4|5|6\n7|8|9\n\n")
    ui.display_board(board)
  end

  it 'can show the UI board with coloured marks' do
    board = %w[O X O X O X O X O]

    expect(STDOUT).to receive(:puts).with(
      "\n\e[36m\e[1mO\e[0m|\e[35m\e[1mX\e[0m|\e[36m\e[1mO\e[0m\n" \
      "\e[35m\e[1mX\e[0m|\e[36m\e[1mO\e[0m|\e[35m\e[1mX\e[0m\n" \
      "\e[36m\e[1mO\e[0m|\e[35m\e[1mX\e[0m|\e[36m\e[1mO\e[0m\n\n"
    )
    ui.display_board(board)
  end

  it 'can show the winning message after player one wins' do
    status = :player_one_wins
    message = ui.interpret_game_status(status)

    expect(message).to eq("Player one wins\n")
  end

  it 'can show the winning message after player two wins' do
    status = :player_two_wins
    message = ui.interpret_game_status(status)

    expect(message).to eq("Player two wins\n")
  end
end
