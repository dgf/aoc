#!/usr/bin/env ruby
# frozen_string_literal: false

#  I. ax * c + bx * d = px
# II. ay * c + by * d = py

def calc_c(((ax, ay), (bx, by), (px, py)))
  (px * by - py * bx) / (ax * by - ay * bx).to_f
end

def calc_d(steps, ((ax, _), (bx, _), (px, _)))
  (px - steps * ax) / bx.to_f
end

def claw(machine)
  c = calc_c(machine)
  return 0 unless (c % 1).zero?

  d = calc_d(c, machine)
  return 0 unless (d % 1).zero?

  c.to_i * 3 + d.to_i
end

machines = File.read(ARGV.shift || 'example.txt')
               .split(/\n\n/)
               .map { |m| m.lines.map { |l| l.scan(/\d+/).map(&:to_i) } }

puts "part1: #{machines
  .map(&method(:claw))
  .sum}"

def adjust(offset)
  ->((a, b, (px, py))) { [a, b, [px + offset, py + offset]] }
end

puts "part2: #{machines
  .map(&adjust(10_000_000_000_000))
  .map(&method(:claw))
  .sum}"
