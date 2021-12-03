# frozen_string_literal: true

def count_depth_increases(measurements)
  measurements
    .each_cons(2)
    .filter { |array| (array[0].to_i - array[1].to_i).negative? }
    .reduce(0) { |count, _array| count + 1 }
end

def determine_position(movements)
  movements.each_with_object({ position: 0, depth: 0 }) do |movement, hash|
    direction, distance = movement.split

    case direction.to_sym
    when :forward then hash[:position] += distance.to_i
    when :down then hash[:depth] += distance.to_i
    when :up then hash[:depth] -= distance.to_i
    end
  end
end

file = File.open('./files/day_2.txt')
file_data = file.readlines.map(&:chomp)
file.close

coordinates = determine_position(file_data)
puts "Coordinates: #{coordinates}, Multiplied: #{coordinates[:position] * coordinates[:depth]}"
