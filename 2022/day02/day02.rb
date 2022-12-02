#!/usr/bin/env ruby
# frozen_string_literal: false

lines = File.read(ARGV.shift || 'example.txt').lines

part1 = lines.map do |l|
  x = l.split[0].ord - 'A'.ord
  y = l.split[1].ord - 'X'.ord
  if x == y
    3
  elsif (y - x) % 3 == 1
    6
  else
    0
  end + y + 1
end

part2 = lines.map do |l|
  x = l.split[0].ord - 'A'.ord
  y = l.split[1]
  if y == 'X'
    (x - 1) % 3 + 1
  elsif y == 'Y'
    3 + x + 1
  else
    6 + (x + 1) % 3 + 1
  end
end

puts "part 1: #{part1.sum}"
puts "part 2: #{part2.sum}"
