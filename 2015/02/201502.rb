#!/usr/bin/env ruby
# frozen_string_literal: false

presents = File.read(ARGV.shift || 'example.txt')
               .lines.map { |l| l.strip.split(/x/).map(&:to_i) }

papers = presents.map { |(l, w, h)| [l * w, w * h, h * l] }
                 .map { |p| p.min + 2 * p.sum }
puts "part1: #{papers.sum}"

ribbons = presents.map { |p| 2 * p.min(2).sum + p.inject(:*) }
puts "part2: #{ribbons.sum}"
