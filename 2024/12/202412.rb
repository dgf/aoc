#!/usr/bin/env ruby

#       right , down  , left   , up
dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]

garden = File.read(ARGV.shift || 'example.txt')
             .lines.map { |l| l.strip.split '' }

rows = garden.count
cols = garden[0].count

seen = Set.new
regions = []

garden.each.with_index do |line, row|
  line.each.with_index do |plot, col|
    next if seen.include? [row, col]

    region = []
    seen << [row, col]
    neighbors = [[row, col]] # add first

    until neighbors.empty?
      rl, cl = neighbors.shift

      shared = []
      dirs.each do |dir|
        rn = rl + dir[0]
        cn = cl + dir[1]
        next if rn.negative? || rn >= rows || cn.negative? || cn >= cols || garden[rn][cn] != plot

        shared << dir
        next if seen.include?([rn, cn])

        seen << [rn, cn]
        neighbors << [rn, cn]
      end

      region << [rl, cl, dirs - shared]
    end

    regions << [plot, region]
  end
end

total = regions.map { |_, r| r.count * r.map { |_, _, e| e.count }.sum }.sum
puts "part1: #{total}"

def slice_edges(dir, plots)
  plots.map { |r, c| dir[0].zero? ? r : c }.sort.slice_when { |a, b| a + 1 != b }
end

def region_edges(dir, region)
  region.select { |_, _, e| e.include?(dir) }
        .group_by { |r, c, _| dir[0].zero? ? c : r }
        .values
        .map { |p| slice_edges(dir, p) }
        .map(&:count)
end

total = regions.map { |_, r| r.count * dirs.map { |d| region_edges(d, r).sum }.sum }.sum
puts "part2: #{total}"
