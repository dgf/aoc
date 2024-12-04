#!/usr/bin/env ruby

lines = File.read(ARGV.shift || 'example.txt').lines.map(&:strip).map(&:chars)

rows = lines.count
cols = lines[0].count

total = 0
lines.each.with_index do |l, r|
  l.each.with_index do |s, c|
    next unless s == 'X'

    # right, down/r, down  , d/left , left   , up/l    , up     , up/right
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]].each do |x, y|
      rxm = r + x * 3
      cym = c + y * 3
      next unless 0 <= rxm and rxm < rows and 0 <= cym and cym < cols

      total += 1 if 'M' == lines[r + x][c + y] and
                    'A' == lines[r + x * 2][c + y * 2] and
                    'S' == lines[rxm][cym]
    end
  end
end
puts "part 1: #{total}"

total = 0
lines.each.with_index do |l, r|
  l.each.with_index do |s, c|
    next unless s == 'A' and (r >= 1 and r < rows - 1 and c >= 1 and c < cols - 1)

    x = [lines[r - 1][c - 1], lines[r - 1][c + 1], lines[r + 1][c - 1], lines[r + 1][c + 1]]
    total += 1 if x[0] != x[3] or x[1] != x[2] and x.join.chars.sort.join == 'MMSS'
  end
end
puts "part 2: #{total}"
