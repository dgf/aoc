#!/usr/bin/env ruby
# frozen_string_literal: false

move = ['>', 'v', '<', '^']
dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]

def robot_pos(map)
  map.each.with_index { |l, r| l.each.with_index { |s, c| return [r, c] if s == '@' } }
end

animate = 0
require 'optparse'
parser = OptionParser.new
parser.on('-a FPS', 'animate FPS') { |value| animate = 1 / value.to_i.to_f }
parser.parse!

wb, mb = File.read(ARGV.shift || 'example.txt').split(/\n\n/)
warehouse = wb.lines.map { |l| l.strip.split(//) }
moves = mb.gsub(/\n/, '').split(//).map { |m| move.index(m) }

pos = robot_pos(warehouse)
moves.each.with_index do |d, m|
  dr, dc = dirs[d]
  nr = pos[0] + dr
  nc = pos[1] + dc

  nt = warehouse[nr][nc]
  next if nt == '#'

  if nt == 'O'
    gpos = [nr, nc]
    gpos = [gpos[0] + dr, gpos[1] + dc] while warehouse[gpos[0]][gpos[1]] == 'O'
    next if warehouse[gpos[0]][gpos[1]] == '#'

    warehouse[gpos[0]][gpos[1]] = 'O'
  end

  warehouse[pos[0]][pos[1]] = '.'
  pos = [nr, nc]
  warehouse[pos[0]][pos[1]] = '@'

  next unless animate.positive?

  sleep animate
  puts "\e[H\e[2J"
  puts "#{move[d]} #{m}"
  warehouse.each { |r| puts r.join }
end

warehouse.each { |r| puts r.join } if animate.zero?

total = 0
warehouse.each.with_index { |l, r| l.each.with_index { |s, c| total += r * 100 + c if s == 'O' } }
puts "part1: #{total}"
