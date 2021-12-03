# frozen_string_literal: true

# Part 1
file = File.open('./files/day_3.txt')
file_data = file.to_a.map(&:strip)
file.close

column_groups = file_data.map(&:chars).transpose
number_counts = column_groups.map(&:tally)

gamma_rate = number_counts.map { |tally| tally.max_by { |_k, v| v }[0] }.join.to_i(2)
epsilon_rate = number_counts.map { |tally| tally.min_by { |_k, v| v }[0] }.join.to_i(2)

p "Part 1 -- Gamma: #{gamma_rate}, Epsilon: #{epsilon_rate}, Power Consumption: #{gamma_rate * epsilon_rate}"

# Part 2
