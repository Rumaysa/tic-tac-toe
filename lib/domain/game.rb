# frozen_string_literal: true

class Game
  attr_accessor :board, :player_turn
  def initialize(board_width:, starting_player: 'X')
    @board_width = board_width
    size = board_width * board_width
    @board = Array.new(size)
    @winning_combinations = find_winning_combinations
    @player_turn = starting_player
  end

  def full_board?
    @board.compact.length == 9
  end

  def draw?
    full_board? unless win_for_player?('X') || win_for_player?('O')
  end

  def win_for_player?(player)
    players_marks = []
    @board.each_with_index { |cell, i| players_marks << i if cell == player }
    @winning_combinations.each do |combination|
      return true if match?(players_marks, combination)
    end
    false
  end

  private

  def match?(players_marks, combination)
    (combination & players_marks).length == 3
  end

  def find_winning_combinations
    horizontal_winnings_for(@board)
      .union(vertical_winnings_for(@board))
      .union(diagonal_winnings)
  end

  def horizontal_winnings_for(board)
    winning_combinations = []

    (0...board.length).step(@board_width) do |index|
      winning_combinations << (index...index + @board_width).to_a
    end

    winning_combinations
  end

  def vertical_winnings_for(board)
    winning_combinations = []

    @board_width.times do |column|
      current_comumn = []

      (column...board.length).step(@board_width) do |index|
        current_comumn << index
        winning_combinations << current_comumn
      end
      current_comumn = []
    end
    winning_combinations
  end

  def diagonal_winnings
    positive_diagonal = []
    negative_diagonal = []
    i = j = 0
    @board_width.times do
      positive_diagonal << i + @board_width - 1
      negative_diagonal << j
      i += @board_width - 1
      j += @board_width + 1
    end
    [negative_diagonal, positive_diagonal]
  end
end
