# frozen_string_literal: true

class Board < Array

  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(width:)
    size = width * width

    size.times { push(nil) }
  end

  def evaluate
    return :player_one_wins if win_for_player?('X')
    return :player_two_wins if win_for_player?('O')
    return :game_over if game_over?

    :continue
  end

  private

  def game_over?
    self.compact.length == 9
  end

  def win_for_player?(player)
    
    players_marks = [] 
    self.each_with_index { |cell, i| players_marks << i if cell == player }
    WINNING_COMBINATIONS.each do |combination|
      return true if match?(players_marks, combination)
    end
    false
  end

  def match?(players_marks, combination)
    (combination & players_marks).length == 3
  end
end
