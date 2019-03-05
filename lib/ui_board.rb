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
    new_board = "\n1|2|3\n4|5|6\n7|8|9\n\n"
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

  private

  def change_mark_colour_for(player, colour_code, board)
    board.gsub!(player, color(player, colour_code))
  end

  def color(mark, color_code)
    "\e[#{color_code}m\e[1m#{mark}\e[0m"
  end
end
