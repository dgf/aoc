#!/usr/bin/env ruby
# frozen_string_literal: false

print = ->(l) { l.gsub(/^"|"$/, '').gsub(/\\["\\]/, 'Q').gsub(/\\x\h\h/, 'X') }
quote = ->(l) { l.gsub(/\\/, 'BB').gsub(/"/, 'BQ') }
diffs = ->(l) { [l.length - print.call(l).length, 2 + quote.call(l).length - l.length] }

d1, d2 = File.read(ARGV.shift || 'example.txt')
             .lines.map(&:strip).map(&diffs).transpose

puts "part1: #{d1.sum}"
puts "part2: #{d2.sum}"
