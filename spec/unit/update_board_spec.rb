# frozen_string_literal: true

require 'spec_helper'

describe UpdateBoard do
  let(:game) { Game.new(board_width: 3) }
  let(:board_gateway) { GameGatewaySpy.new(game) }
  let(:update_board) { UpdateBoard.new(board_gateway) }

  context 'when updating the board with a single marker' do
    it 'can update the board with players mark' do
      update_board.execute('X', at_index: 6)
      board_gateway.game
      expect(game.board).to eq(
        [nil, nil, nil,
         nil, nil, nil,
         'X', nil, nil]
      )
    end

    it 'can raise a duplication error when a marker is placed on a taken position' do
      update_board.execute('X', at_index: 7)
      board_gateway.game
      expect do
        update_board.execute('O', at_index: 7)
      end.to raise_error(UpdateBoard::DuplicationError)
    end

    it 'can raise a duplication error when a marker is outside board' do
      board_gateway.game
      expect do
        update_board.execute('X', at_index: 9)
      end.to raise_error(RangeError)
    end

    it 'can raise a duplication error when a marker is outside board, example 2' do
      board_gateway.game
      expect do
        update_board.execute('X', at_index: -1)
      end.to raise_error(RangeError)
    end
    it 'can raise a wrongturn error when the wrong turn is taken' do
      board_gateway.game
      update_board.execute('X', at_index: 6)
      expect do
        update_board.execute('X', at_index: 0)
      end.to raise_error(UpdateBoard::WrongTurnError)
    end
  end
  context 'when updating the board with a multiple markers' do
    it 'can update the board with players mark' do
      update_board.execute('X', at_index: 6)
      update_board.execute('O', at_index: 0)
      board_gateway.game
      expect(game.board).to eq(
        ['O', nil, nil,
         nil, nil, nil,
         'X', nil, nil]
      )
    end
  end
end
