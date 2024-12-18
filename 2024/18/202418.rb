#!/usr/bin/env ruby
# frozen_string_literal: false

animate = 0
require 'optparse'
parser = OptionParser.new
parser.on('-a FPS', 'animate FPS') { |value| animate = 1 / value.to_i.to_f }
parser.parse!

bytes = File.read(ARGV.shift || 'example.txt')
            .lines.map { |l| l.split(/,/).map(&:to_i) }

size = 70 # 6
falls = 1024 # 12
# falls = 2903 # 12

space = (0..size).map { |_| (0..size).map { |_| '.' } }

bytes.each.with_index do |(x, y), i|
  space[y][x] = '#'
  break unless i < falls - 1
end

pos = [[0, 0, [[0, 0]]]]
dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
seen = Set.new
steps = []
iter = 0

until pos.empty?
  x, y, p = pos.shift
  seen << [x, y]

  dirs.each do |dx, dy|
    nx = x + dx
    next if nx.negative? || nx >= space[0].count

    ny = y + dy
    next if ny.negative? || ny >= space.count
    next if space[ny][nx] == '#'
    next if seen.include?([nx, ny])
    next if pos.any? { |(px, py, _)| px == nx && py == ny }

    if nx == space[0].count - 1 && ny == space.count - 1
      steps << p
      next
    end

    space[ny][nx] = 'O'
    pos << [nx, ny, p.dup.push([nx, ny])]
  end

  iter += 1
  next unless animate.positive? && (iter % 100).zero?

  sleep animate
  puts "\e[H\e[2J"
  puts "iter: #{iter} next: #{pos.count}"
  seen.each { |(sx, sy)| space[sy][sx] = 'O' }
  space.each { |r| puts r.join }
end

shortest = steps.min(&:count)
shortest.each { |(sx, sy)| space[sy][sx] = 'X' }

puts "\e[H\e[2J" if animate.positive?
space.each { |r| puts r.join.gsub(/O/, ' ').gsub(/X/, 'O') }
puts "part1: #{shortest.count}"
