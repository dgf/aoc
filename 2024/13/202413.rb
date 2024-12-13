#!/usr/bin/env ruby

machines = File.read(ARGV.shift || 'example.txt')
               .split(/\n\n/)
               .map { |m| m.lines.map { |l| l.scan(/\d+/).map(&:to_i) } }

def claw(off, machine)
  a, b, p = machine
  ax, ay = a
  bx, by = b
  px, py = p

  c = ((px + off) * by - (py + off) * bx) / (ax * by - ay * bx).to_f
  return 0 unless (c % 1).zero?

  d = ((px + off) - c * ax) / bx.to_f
  return 0 unless (d % 1).zero?

  c.to_i * 3 + d.to_i
end

puts "part1: #{machines.map { |m| claw(0, m) }.sum}"
puts "part2: #{machines.map { |m| claw(10_000_000_000_000, m) }.sum}"
