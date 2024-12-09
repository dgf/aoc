#!/usr/bin/env ruby

disk = File.read(ARGV.shift || 'example.txt')
           .strip.chars.map(&:to_i)

blocks = disk.map.with_index { |f, i| i.even? ? [i / 2] * f : [nil] * f }.reject { |b| b == [] }

s = 0
slots = blocks.flatten
slots[s].nil? ? slots[s] = slots.pop : s += 1 while s < slots.count
total = slots.map.with_index { |b, i| i * b }.sum
puts "part1: #{total}"

frags = blocks.flatten.map { |b| b.nil? ? '#' : b }.join('_')
blocks.reverse.reject { |b| b.first.nil? }.each do |b|
  spaces = (['#'] * b.count).join('_')
  file = b.join('_')
  s = frags.index(spaces)
  f = frags.index(file)
  next unless !s.nil? and s < f

  frags = frags.sub(file, spaces).sub(spaces, file)
end

total = frags.split('_')
             .map { |b| b == '#' ? 0 : b.to_i }
             .map.with_index { |b, i| i * b }.sum
puts "part2: #{total}"
