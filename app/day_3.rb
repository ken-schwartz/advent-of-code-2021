# frozen_string_literal: true

# Part 1
file = File.open('./files/day_3.txt')
file_data = file.to_a.map(&:strip)
file.close

column_groups = file_data
                .map(&:chars)
                .transpose

number_counts = column_groups.map(&:tally)

gamma_rate = number_counts
             .map { |tally| tally.max_by { |_k, v| v }[0] }
             .join
             .to_i(2)

epsilon_rate = number_counts
               .map { |tally| tally.min_by { |_k, v| v }[0] }
               .join
               .to_i(2)

p "Part 1 -- Gamma: #{gamma_rate}, Epsilon: #{epsilon_rate}, Power Consumption: #{gamma_rate * epsilon_rate}"

# Part 2
def get_decimal_rating(remaining_data, index, operator)
  return remaining_data[0].to_i(2) unless remaining_data.length > 1

  number_count = remaining_data
                 .map(&:chars)
                 .transpose
                 .map(&:tally)[index]

  max_number = number_count['1'].public_send(operator, number_count['0']) ? '1' : '0'
  reduced_data = remaining_data.filter { |x| x[index] == max_number }

  get_decimal_rating(reduced_data, index + 1, operator)
end

oxygen = get_decimal_rating(file_data, 0, :>=)
co2 = get_decimal_rating(file_data, 0, :<)
p "Part 2 -- Oxygen: #{oxygen}, CO2: #{co2}, Life: #{oxygen * co2}"
