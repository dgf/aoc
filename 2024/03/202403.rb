#!/usr/bin/env ruby

filename = ARGV.shift

result1 = 0
File.read(filename || 'example1.txt')
    .scan(/mul\((\d{1,3}),(\d{1,3})\)/)
    .map { |i| i.map(&:to_i) }
    .each { |a, b| result1 += a * b }
puts "part 1: #{result1}"

enabled = true
result2 = 0
File.read(filename || 'example2.txt')
    .scan(/do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\)/)
    .each do |i|
  if i == 'do()'
    enabled = true
  elsif i == "don't()"
    enabled = false
  elsif enabled
    a, b = /(\d+),(\d+)/.match(i).captures.map(&:to_i)
    result2 += a * b
  end
end
puts "part 2: #{result2}"
