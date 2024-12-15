#!/usr/bin/env ruby
# frozen_string_literal: false

dirs = { '>': [0, 1], 'v': [1, 0], '<': [0, -1], '^': [-1, 0] }

def robot_pos(map)
  map.each.with_index { |l, r| l.each.with_index { |s, c| return [r, c] if s == '@' } }
end

def twice(s)
  case s when 'O' then '[]' when '@' then '@.' else s * 2 end.chars
end

animate = 0
require 'optparse'
parser = OptionParser.new
parser.on('-a FPS', 'animate FPS') { |value| animate = 1 / value.to_i.to_f }
parser.parse!

wb, mb = File.read(ARGV.shift || 'example.txt').split(/\n\n/)
warehouse = wb.lines.map { |l| l.strip.chars.map { |s| twice(s) }.flatten }
moves = mb.gsub(/\n/, '').chars
pos = robot_pos(warehouse)

moves.each.with_index do |d, m|
  dr, dc = dirs[d.to_sym]
  nr = pos[0] + dr
  nc = pos[1] + dc

  nt = warehouse[nr][nc]
  next if nt == '#'

  if '[]'.include?(nt)
    case d.to_sym
    when :<, :>
      gpos = [nr, nc]
      replaces = [gpos]
      while '[]'.include?(warehouse[nr][gpos[1]])
        gpos = [nr, gpos[1] + dc]
        replaces << gpos
      end
      next if warehouse[nr][gpos[1]] == '#'

      go = d.to_sym == :> ? [']', '['] : ['[', ']']
      replaces.each.with_index do |r, i|
        warehouse[r[0]][r[1]] = go[i % 2]
      end

    when :^, :v
      gpos = [[nr, nc]]
      replaces = {}
      bumped = false
      until gpos.empty?
        gp = gpos.shift
        gv = warehouse[gp[0]][gp[1]]
        if gv == '#'
          bumped = true
          break
        end

        next unless '[]'.include?(gv) and !replaces.include?(gp)

        replaces[gp] = gv
        gpos << [gp[0] + dr, gp[1]]
        case gv
        when '['
          replaces[[gp[0], gp[1] + 1]] = ']'
          gpos << [gp[0] + dr, gp[1] + 1]
        when ']'
          replaces[[gp[0], gp[1] - 1]] = '['
          gpos << [gp[0] + dr, gp[1] - 1]
        end
      end

      next if bumped

      go = nt == '[' ? [']', '['] : ['[', ']']
      overrides = replaces.each.to_a.sort_by { |((r))| r }
      overrides.reverse! if d.to_sym == :v
      overrides.each do |(r, c), v|
        warehouse[r + dr][c] = v
        warehouse[r][c] = '.'
      end
    end
  end

  warehouse[pos[0]][pos[1]] = '.'
  pos = [nr, nc]
  warehouse[pos[0]][pos[1]] = '@'

  next unless animate.positive?

  sleep animate
  puts "\e[H\e[2J"
  puts "#{d} #{m}"
  warehouse.each { |r| puts r.join }
end

warehouse.each { |r| puts r.join } if animate.zero?

total = 0
warehouse.each.with_index { |l, r| l.each.with_index { |s, c| total += r * 100 + c if s == '[' } }
puts "part2: #{total}"
