# frozen_string_literal: true

require 'pry'
require 'pry-nav'

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

def calculate_unmarked_sum(board)
  board.flatten
       .filter { |elem| !elem[:marked] }
       .reduce(0) { |sum, elem| sum + elem[:value].to_i }
end

numbers_called = file_data.slice!(0).first.split(',')
boards = create_boards(file_data)
winning_boards = []
winning_score = 0
losing_score = 0

numbers_called.each do |num|
  boards.each do |board|
    next if winning_boards.include? board

    mark_board!(board, num)

    if winner?(board) && winning_boards.length.zero?
      winning_score = calculate_unmarked_sum(board) * num.to_i
      winning_boards << board
    elsif winner?(board) && winning_boards.length == boards.length - 1
      losing_score = calculate_unmarked_sum(board) * num.to_i
      break
    elsif winner?(board) && !winning_boards.include?(board)
      winning_boards << board
    end
  end

  break if winning_score.positive? && losing_score.positive?
end

p "Part 1 -- Winning Score: #{winning_score}"
p "Part 2 -- Losing Score: #{losing_score}"
