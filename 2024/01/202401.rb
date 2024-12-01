#!/usr/bin/env ruby

left, right = File.read(ARGV.shift || 'example.txt')
                  .lines.map { |l| l.split.map(&:to_i) }
                  .transpose.map(&:sort)

dists = left.zip(right).map { |l, r| (l - r).abs }
puts "part 1: #{dists.sum}"

count_by_location = right.tally
scores = left.map { |l| l * (count_by_location[l] || 0) }
puts "part 2: #{scores.sum}"
