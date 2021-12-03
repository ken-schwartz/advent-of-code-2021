# frozen_string_literal: true

def count_depth_increases(measurements)
  measurements
    .each_cons(2)
    .filter { |array| (array[0].to_i - array[1].to_i).negative? }
    .reduce(0) { |count, _array| count + 1 }
end

def determine_position(movements)
  movements.each_with_object({ position: 0, depth: 0, aim: 0 }) do |movement, hash|
    direction, dist = movement.split
    distance = dist.to_i

    case direction.to_sym
    when :forward
      hash[:position] += distance
      hash[:depth] += hash[:aim] * distance
    when :down
      hash[:aim] += distance
    when :up
      hash[:aim] -= distance
    end
  end
end

file = File.open('./files/day_2.txt')
file_data = file.readlines.map(&:chomp)
file.close

coordinates = determine_position(file_data)
puts "Coordinates: #{coordinates}, Multiplied: #{coordinates[:position] * coordinates[:depth]}"
