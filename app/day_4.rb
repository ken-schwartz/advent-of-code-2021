# frozen_string_literal: true

require 'pry'

file = File.open('./files/day_4.txt')
file_data = file.to_a.map(&:split)
file.close

# Part 1
def create_boards(data)
  boards = []
  current_board = []

  data.each do |arr|
    if arr.empty? && !current_board.empty?
      boards.push current_board
      current_board = []
    elsif !arr.empty?
      current_board.push(arr.map { |x| { value: x, marked: false } })
    end
  end

  boards.push current_board
end

def mark_board!(board, num)
  board.each do |row|
    row.each { |elem| elem[:marked] = true unless elem[:value] != num }
  end
end

def winner?(board)
  horizontal = board.any? { |row| row.all? { |elem| elem[:marked] } }
  vertical = board.transpose.any? { |col| col.all? { |elem| elem[:marked] } }
  horizontal || vertical
end

def calculate_sum(board)
  board.flatten
       .filter { |elem| !elem[:marked] }
       .reduce(0) { |sum, elem| sum + elem[:value].to_i }
end

numbers_called = file_data.slice!(0).first.split(',')
boards = create_boards(file_data)
score = 0

numbers_called.each do |num|
  boards.each do |board|
    mark_board!(board, num)

    if winner? board
      score = calculate_sum(board) * num.to_i
      break
    end
  end

  break if score.positive?
end

p "Part 1 -- Score: #{score}"

# Part 2