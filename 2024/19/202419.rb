#!/usr/bin/env ruby
# frozen_string_literal: false

colors = %w[w u b r g]
to_colors = ->(p) { p.strip.chars.map { |c| colors.index(c) } }

def match(cache, patterns, design, pattern)
  return 0 if design[-pattern.count..] != pattern
  return 1 if design.count == pattern.count

  collect(cache, patterns, design[...-pattern.count])
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
