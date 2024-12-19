#!/usr/bin/env ruby
# frozen_string_literal: false

to_colors = lambda do |p|
  chars = p.strip.chars
  mask = chars.reduce(0) do |s, c|
    s <<= 3
    s |= %w[_ w u b r g].index(c)
    s
  end
  [chars.count * 3, mask]
end

def match(cache, patterns, design, pattern)
  return 0 if (design[1] & (2**pattern[0] - 1)) ^ pattern[1] != 0
  return 1 if design[0] == pattern[0]

  collect(cache, patterns, [design[0] - pattern[0], design[1] >> pattern[0]])
end

def collect(cache, patterns, design)
  cache[design] || cache[design] = patterns.map { |p| match(cache, patterns, design, p) }.sum
end

blocks = File.read(ARGV.shift || 'example.txt').split(/\n\n/)
patterns = blocks.first.split(/,/).map(&to_colors)
designs = blocks.last.lines.map(&to_colors)

cache = {}
results = designs.map { |d| collect(cache, patterns, d) }

puts "part1: #{results.reject(&:zero?).count}"
puts "part2: #{results.sum}"
