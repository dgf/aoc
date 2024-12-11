#!/usr/bin/env ruby

arr = File.read(ARGV.shift || 'example.txt').strip.split(' ')

def apply(cache, blinks, stone)
  return 1 if blinks.zero?
  return cache[blinks][stone] unless cache[blinks][stone].nil?

  n = blinks - 1
  r = if stone == '0'
        apply(cache, n, '1')
      elsif stone.length.even?
        h = stone.length / 2
        apply(cache, n, stone[...h]) + apply(cache, n, stone[h..].to_i.to_s)
      else
        apply(cache, n, (2024 * stone.to_i).to_s)
      end

  cache[blinks].store(stone, r)
end

def arrange(arr, blinks)
  cache = (blinks + 1).times.map { |_| {} }
  arr.map { |stone| apply(cache, blinks, stone) }.sum
end

puts "part1: #{arrange(arr, 25)}"
puts "part2: #{arrange(arr, 75)}"
