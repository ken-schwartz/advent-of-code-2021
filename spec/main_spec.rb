# frozen_string_literal: true

require 'rspec'
require_relative '../app/main'

describe '#count_depth_increases' do
  let(:input) do
    [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
  end

  it 'counts the number of times the sliding sum increases from the previous sum' do
    expect(count_depth_increases(input)).to eq(5)
  end
end

describe '#determine_position' do
  let(:movements) do
    ['forward 5',
     'down 5',
     'forward 8',
     'up 3',
     'down 8',
     'forward 2']
  end

  it 'returns an x,y coordinate based on the movements' do
    result = determine_position(movements)

    expect(result[:position]).to eq(15)
    expect(result[:depth]).to eq(60)
  end
end
