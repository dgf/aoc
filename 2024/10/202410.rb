#!/usr/bin/env ruby

map = File.read(ARGV.shift || 'example.txt')
          .lines.map { |l| l.strip.chars.map(&:to_i) }

#        up     , down  , left   , right
$dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]]

def walk(m, r, c)
  rows = m.count
  cols = m[0].count
  paths = [[[r, c]]]

  (1..9).each do |level|
    prevs = paths.uniq
    paths = []
    prevs.each do |path|
      lr, lc = path.last
      $dirs.each do |dr, dc|
        nr = lr + dr
        nc = lc + dc
        next unless nr >= 0 and nr < rows and
                    nc >= 0 and nc < cols and
                    m[nr][nc] == level

        paths << path.dup.push([nr, nc])
      end
    end
  end

  paths.map(&:last)
end

total1 = 0
total2 = 0

map.each.with_index do |l, r|
  l.each.with_index do |n, c|
    next unless n == 0

    lasts = walk(map, r, c)
    total1 += lasts.to_set.count
    total2 += lasts.count
  end
end

puts "part1: #{total1}"
puts "part2: #{total2}"
