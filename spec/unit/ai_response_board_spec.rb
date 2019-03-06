# frozen_string_literal: true

describe AIResponse do
  it 'can respond to a players mark' do
    ai_response = AIResponse.new

    board = ['X', nil, nil, nil, nil, nil, nil, nil, nil]

    expect(ai_response.execute(board)).to eq(4)
  end

  it 'can respond to a players different mark' do
    ai_response = AIResponse.new

    board = [nil, nil, nil, nil, 'X', nil, nil, nil, nil]

    expect(ai_response.execute(board)).to eq(0)
  end

  it 'can respond to a players different mark' do
    ai_response = AIResponse.new

    board = ['O', 'X', nil, nil, 'X', nil, nil, nil, nil]

    expect(ai_response.execute(board)).to eq(7)
  end

  it 'can respond to a players different mark' do
    ai_response = AIResponse.new

    board = ['X', nil, nil, nil, 'O', nil, nil, nil, 'X']

    expect(ai_response.execute(board)).to eq(1)
  end

  it 'can respond to a players different mark' do
    ai_response = AIResponse.new

    board = ['X', 'O', nil, nil, 'O', nil, nil, 'X', 'X']

    expect(ai_response.execute(board)).to eq(6)
  end
end
