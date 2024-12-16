#!/usr/bin/env ruby
# frozen_string_literal: false

#        >      v       <        ^
dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
maze = File.read(ARGV.shift || 'example.txt').lines.map { |l| l.strip.chars }
pos = ->(m, p) { m.each.with_index { |l, r| l.each.with_index { |s, c| return [r, c] if s == p } } }

paths = []
seen = {}
sr, sc = pos.call(maze, 'S')
queue = [[sr, sc, 0, 0, []]]

until queue.empty?
  qr, qc, qd, qs, qp = queue.shift
  seen[[qr, qc, qd]] = qs

  if maze[qr][qc] == 'E'
    paths << [qs, qp]
    next
  end

  nq = [[qr, qc, (qd + 1) % 4, qs + 1000], [qr, qc, (qd - 1) % 4, qs + 1000]]

  dr, dc = dirs[qd]
  mr = qr + dr
  mc = qc + dc
  nq << [mr, mc, qd, qs + 1] unless maze[mr][mc] == '#'

  np = qp.dup.push([qr, qc])
  nq.each do |nr, nc, nd, ns|
    k = [nr, nc, nd]
    next if !seen[k].nil? && seen[k] < ns

    queue << [nr, nc, nd, ns, np]
  end
end

lowest = paths.map { |s, _| s }.min
tiles = paths.select { |s, _p| s == lowest }
             .map { |_s, p| Set.new(p) }
             .reduce(&:merge)

er, ec = pos.call(maze, 'E')
maze[er][ec] = 'O'
tiles.each { |r, c| maze[r][c] = 'O' }
maze.each { |r| puts r.join }

puts "part1: #{lowest}"
puts "part2: #{tiles.count + 1}"
