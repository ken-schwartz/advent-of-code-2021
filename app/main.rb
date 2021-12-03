# frozen_string_literal: true

def count_depth_increases(measurements)
  measurements
    .each_cons(2)
    .filter { |array| (array[0].to_i - array[1].to_i).negative? }
    .reduce(0) { |count, _array| count + 1 }
end

file = File.open('./files/day_1.txt')
file_data = file.readlines.map(&:chomp)
file.close

puts count_depth_increases(file_data)
