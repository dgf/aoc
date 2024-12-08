#!/usr/bin/env ruby

city = File.read(ARGV.shift || 'example.txt')
           .lines.map(&:strip)
           .map { |l| l.split('') }

rows = city.count
cols = city[0].count
locs = {}

city.each.with_index do |l, r|
  l.each.with_index do |s, c|
    next if s == '.'

    locs[s] = [] if locs[s].nil?
    locs[s] << [r, c]
  end
end

locs.values.each do |v|
  v.combination(2).to_a.each do |a, b|
    [[a, b], [b, a]].each do |f, l|
      r = f.first + (f.first - l.first)
      c = f.last + (f.last - l.last)
      city[r][c] = '#' if r >= 0 and r < rows and c >= 0 and c < cols
    end
  end
end
puts "part1: #{city.flatten.tally['#']}"

locs.values.each do |v|
  v.combination(2).to_a.each do |a, b|
    [[a, b], [b, a]].each do |f, l|
      rd = f.first - l.first
      cd = f.last - l.last
      r = f.first
      c = f.last
      while r >= 0 and r < rows and c >= 0 and c < cols
        city[r][c] = '#'
        r += rd
        c += cd
      end
    end
  end
end
puts "part2: #{city.flatten.tally['#']}"
