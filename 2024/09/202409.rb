#!/usr/bin/env ruby

fs = File.read(ARGV.shift || 'example.txt')
         .strip.chars.map(&:to_i)

s = 0
slots = fs.map.with_index { |f, i| i.even? ? [i / 2] * f : [nil] * f }.flatten
slots[s].nil? ? slots[s] = slots.pop : s += 1 while s < slots.count
total = slots.map.with_index { |b, i| i * b }.sum
puts "part1: #{total}"

blocks = []
files = []
spaces = []
pos = 0
fs.each.with_index do |b, i|
  if b > 0
    if i.even?
      files << [pos, b, i / 2]
      blocks << [i / 2] * b
    else
      spaces << [pos, b]
      blocks << [nil] * b
    end
    pos += b
  end
end

disk = blocks.flatten
files.reverse.each do |fpos, fcnt, file|
  spaces.reject! { |spos, _| spos > fpos }
  s = spaces.index { |_, scnt| scnt >= fcnt }
  next if s.nil?

  spos, scnt = spaces[s]
  fcnt.times.each do |p|
    disk[spos + p] = file
    disk[fpos + p] = nil
  end

  if scnt == fcnt
    spaces.delete_at(s)
  else
    spaces[s] = [spos + fcnt, scnt - fcnt]
  end
end

total = disk.map.with_index { |b, i| i * (b || 0) }.sum
puts "part2: #{total}"
