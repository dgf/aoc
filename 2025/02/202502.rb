#!/usr/bin/env ruby
# frozen_string_literal: false

lines = File.read(ARGV.shift || 'example.txt')
            .lines.join.split(',')
            .map { |l| l.split('-').map(&:to_i) }

c = 0
lines.each do |(s, e)|
  (s..e).each do |i|
    p = i.to_s
    l = p[0, p.size / 2]
    r = p[p.size / 2..]

    c += i if l == r
  end
end

puts "part 1: #{c}"

c = 0
lines.each do |(s, e)|
  (s..e).each do |i|
    p = i.to_s
    (1..p.size - 1).each do |n|
      a = p.chars.each_slice(n).map(&:join).to_a
      if a.uniq.count == 1
        c += i
        break
      end
    end
  end
end

puts "part 2: #{c}"
