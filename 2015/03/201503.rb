#!/usr/bin/env ruby
# frozen_string_literal: false

dirs = { '>' => [0, 1], 'v' => [1, 0], '<' => [0, -1], '^' => [-1, 0] }
moves = File.read(ARGV.shift || 'example.txt')
            .strip.chars.map(&dirs.method(:fetch))

current = [0, 0]
houses = moves.map { |(r, c)| [current[0] += r, current[1] += c] }
puts "part1: #{houses.uniq.count}"

update = ->(o, l, (r, c)) { o[l] = [o[l][0] + r, o[l][1] + c] }
houses = moves.each_slice(2).each_with_object({ s: [0, 0], r: [0, 0] })
              .map { |(s, r), o| [update.call(o, :s, s), update.call(o, :r, r)] }
puts "part2: #{houses.flatten(1).uniq.count}"
