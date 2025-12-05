#!/usr/bin/env ruby
# frozen_string_literal: false

range_lines, id_lines = File.read(ARGV.shift || 'example.txt').split("\n\n")
ranges = range_lines.strip.lines.map { |l| l.strip.split('-').map(&:to_i) }
ids = id_lines.lines.map { |l| l.strip.to_i }

count = ids.count { |id| ranges.any? { |(l, u)| id.between?(l, u) } }
puts "part 1: #{count}"

joined = [[0, 0]]
ranges.sort_by(&:first).each do |(l, u)|
  jl, ju = joined.last

  if l <= ju
    joined[-1] = [jl, [u, ju].max]
  else
    joined << [l, u]
  end
end

counts = joined[1..].map { |(l, u)| u - l + 1 }
puts "part 2: #{counts.sum}"
