#!/usr/bin/env ruby
# frozen_string_literal: false

def lit(insts, change)
  lights = Array.new(1000) { Array.new(1000, 0) }
  insts.each do |o, (sr, sc, tr, tc)|
    (sr..tr).each { |r| (sc..tc).each { |c| lights[r][c] = change.call(o, lights[r][c]) } }
  end
  lights
end

insts = File.read(ARGV.shift || 'example.txt')
            .lines.map { |l| l.strip.sub(/ through /, ',').sub(/turn /, '').split(/ /) }
            .map { |(o, c)| [o, c.split(/,/).map(&:to_i)] }

change1 = ->(o, l) { case o when 'on' then 1 when 'off' then 0 else l.zero? ? 1 : 0 end }
puts "part1: #{lit(insts, change1).flatten.sum}"

change2 = ->(o, l) { case o when 'on' then l + 1 when 'off' then [0, l - 1].max else l + 2 end }
puts "part2: #{lit(insts, change2).flatten.sum}"
