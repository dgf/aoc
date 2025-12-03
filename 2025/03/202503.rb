#!/usr/bin/env ruby
# frozen_string_literal: false

lines = File.read(ARGV.shift || 'example.txt')
            .lines
            .map { |l| l.strip.chars.map(&:to_i) }

c = 0
lines.each do |l|
  m = l[..-2].sort.reverse.first
  i = l.index(m)
  s = l[i + 1..].sort.reverse.first
  c += "#{m}#{s}".to_i
end

puts "part 1: #{c}"

c = 0
lines.each do |l|
  b = []
  12.downto(1).each do |r|
    m = l[..-r].sort.reverse.first
    i = l.index(m)
    l = l[i + 1...]
    b << m
  end
  c += b.join.to_i
end

puts "part 2: #{c}"
