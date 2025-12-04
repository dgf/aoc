#!/usr/bin/env ruby
# frozen_string_literal: false

ADJACENTS = [
  [0, -1], # left
  [-1, -1], # top left
  [-1, 0], # top
  [-1, 1], # top right
  [0, 1], # right
  [1, 1], # bottom right
  [1, 0], # bottom
  [1, -1] # bottom left
].freeze

def count_adjacents(grid, row, col)
  rolls = 0

  ADJACENTS.each do |dr, dc|
    nr = row + dr
    next if nr.negative? || nr >= grid.size

    nc = col + dc
    next if nc.negative? || nc >= grid[0].size

    rolls += 1 if grid[nr][nc]
  end

  rolls
end

def find_accessibles(grid)
  accessibles = []

  grid.each_with_index do |row, r|
    row.each_index do |c|
      next unless grid[r][c]

      accessibles << [r, c] if count_adjacents(grid, r, c) < 4
    end
  end

  accessibles
end

floor = File.read(ARGV.shift || 'example.txt')
            .lines
            .map { |l| l.strip.chars.map { |c| c == '@' } }

a = find_accessibles(floor)
puts "part 1: #{a.size}"

removed = 0
loop do
  a = find_accessibles(floor)
  break if a.empty?

  removed += a.size
  a.each { |(r, c)| floor[r][c] = false }
end
puts "part 2: #{removed}"
