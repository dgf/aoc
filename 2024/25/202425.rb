#!/usr/bin/env ruby
# frozen_string_literal: false

heights = lambda do |l|
  l.lines
   .map { |m| m.strip.split('') }
   .transpose
   .map { |m| m.count { |c| c == '#' } - 1 }
end

locks, keys = File.read(ARGV.shift || 'example.txt')
                  .split(/\n\n/)
                  .partition { |b| b.start_with?('#') }
                  .map { |b| b.map(&heights) }

fits = lambda do |lock|
  keys.map { |key| lock.zip(key).map { |(a, b)| a + b }.none? { |h| h > 5 } }
end

puts "part1: #{locks.map(&fits).map { |f| f.count(true) }.sum}"
