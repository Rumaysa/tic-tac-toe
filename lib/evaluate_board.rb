class EvaluateBoard
  def initialize(board_gateway)
    @board_gateway = board_gateway
    @winning_combinations = [
      [0, 1, 2],
      [1, 4, 7],
      [0, 3, 6],
      [8, 4, 0]
    ]
  end

  def execute
    board = @board_gateway.fetch_board
    if board.nil?
      nil
    else
      players_marks = []
      board.each_with_index { |cell, i| players_marks << i if cell == 'X' }
      @winning_combinations.each do |combination|
        return 'Player one wins' if combination.all? { |num| players_marks.include?(num) }
      end
      ''
    end
  end
end