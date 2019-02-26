# frozen_string_literal: true

describe UI2 do
  # class GameSpy
  #   def initialize(tested_object)
  #     @called = []
  #     @tested_object = tested_object
  #   end

  #   def called?(method)
  #     @called.include?(method)
  #   end

  #   def method_missing(method_name)
  #     @called << method_name
  #     @tested_object.send(method_name)
  #   end
  # end

  # it 'should call display board method when initialising a new game ' do

  #   game = UI.new
  #   game_spy = GameSpy.new(game)
  #   expect(game_spy).to eq(true)
  # end

  class StdoutSpy
    attr_reader :lines
    def initialize
      @lines = []
    end

    def puts(output)
      @lines << output
    end
  end
  it do
    stdout = StdoutSpy.new
    ui = UI2.new(stdout: stdout)
    ui.start
    expect(stdout.lines).to eq([
                                 'TIC TAC TOE'
                               ])
  end
end
