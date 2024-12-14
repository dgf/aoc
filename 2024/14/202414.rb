#!/usr/bin/env ruby
# frozen_string_literal: false

def move_time(robs, cols, rows, secs, animate: false)
  row_max_ever = 1
  secs.times do |sec|
    robs.each do |p, v|
      p[0] = (p[0] + v[0]) % cols
      p[1] = (p[1] + v[1]) % rows
    end

    next unless animate

    pmap = rows.times.map { |_| [0] * cols }
    robs.each { |((c, r))| pmap[r][c] += 1 }

    maxs = pmap.map do |r|
      r.slice_when { |a, b| a.zero? || b.zero? }.to_a.map(&:count).max
    end
    row_max = maxs.max

    next unless row_max > row_max_ever

    sleep 0.042
    puts "\e[H\e[2J"
    puts "rows: #{pmap.count}, cols: #{pmap[0].count}, sec: #{sec} / #{secs}, max: #{row_max}"
    pmap.each.with_index do |r, i|
      print "\e[31m" if maxs[i] >= row_max
      puts r.map { |c| c.zero? ? ' ' : c.to_s }.join
      print "\e[0m" if maxs[i] >= row_max
    end
    puts "\e[0m"

    row_max_ever = row_max
  end

  map = []
  rows.times { |r| map[r] = [0] * cols }
  robs.map { |p, _| p }
      .tally
      .each { |(c, r), a| map[r][c] = a }
  map
end

robots = File.read(ARGV.shift || 'example.txt').lines
             .map { |l| l.strip.split(/ /).map { |pv| pv.split(/=/).last.split(/,/).map(&:to_i) } }

cols = robots.map { |((c, _))| c }.max + 1
cols_half = cols / 2
rows = robots.map { |((_, r))| r }.max + 1
rows_half = rows / 2

map = move_time(robots, cols, rows, 100)
regions = [map[0...rows_half], map[rows_half + 1...]].map do |bt|
  btt = bt.transpose
  btt[0...cols_half].flatten.sum * btt[cols_half + 1...].flatten.sum
end

move_time(robots, cols, rows, 10_000, animate: true)
puts "part1: #{regions.inject(:*)}"
puts 'part2: last sec of tree pic + 101'
