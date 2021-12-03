# frozen_string_literal: true

require 'rspec'
require_relative '../app/main'

describe '#count_depth_increases' do
  let(:input) do
    [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
  end

  it 'counts the number of times the depth increases from the previous measurement' do
    expect(count_depth_increases(input)).to eq(7)
  end
end
