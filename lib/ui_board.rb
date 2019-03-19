# frozen_string_literal: false

class UI
  def initialize(stdout:, stdin:)
    @stdout = stdout
    @stdin = stdin
  end

  def start
    title = color("\n      TIC TAC TOE", 31)
    @stdout.puts(title)
  end

  def display_board(board)
    new_board = "\n1 |2 |3 |4 \n5 |6 |7 |8 \n9 |10|11|12\n13|14|15|16\n\n"
    board.each_with_index do |cell, i|
      new_board.gsub!((i + 1).to_s, cell) unless cell.nil?
    end
    change_mark_colour_for('X', 35, new_board)
    change_mark_colour_for('O', 36, new_board)
    @stdout.puts(new_board)
  end

  def display_message(message)
    @stdout.print(message)
  end

  def users_input
    @stdin.gets
  end

  def interpret_game_status(status)
    case status
    when :player_one_wins
      "Player one wins\n"
    when :player_two_wins
      "Player two wins\n"
    when :game_over
      "Game Over!\n"
    end
  end

  private

  def change_mark_colour_for(player, colour_code, board)
    board.gsub!(player, color(player, colour_code))
  end

  def color(mark, color_code)
    "\e[#{color_code}m\e[1m#{mark}\e[0m"
  end
end
