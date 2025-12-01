#!/usr/bin/env ruby
# frozen_string_literal: false

lines = File.read(ARGV.shift || 'example.txt')
            .lines.map { |l| [l[0], l[1..].to_i] }

p = 50
c = 0
lines.each do |(d, s)|
  n = s % 100
  d == 'L' ? (p -= n) : (p += n)

  p += 100 if p.negative?
  p -= 100 if p > 99

  c += 1 if p.zero?
end

puts "part 1: #{c}"

p = 50
c = 0
lines.each do |(d, s)|
  n = s % 100
  e = (s - n) / 100

  if d == 'L'
    np = p - n
    if np.negative?
      np += 100
      e += 1 if p != 0
    end
    p = np
  else
    p += n
    if p > 99
      p -= 100
      e += 1 if p.positive?
    end
  end

  c += e
  c += 1 if p.zero?
end

puts "part 2: #{c}"
