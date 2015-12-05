#!/usr/bin/env ruby
# frozen_string_literal: false

strings = File.read(ARGV.shift || 'example.txt')
              .lines.map(&:strip)

rules = [
  ->(s) { !s.match(/(.)(.).*\1\2/).nil? },
  ->(s) { s.chars.each_cons(3).any? { |(a, _, c)| a == c } }
]

matches = strings.select { |s| rules.all? { |r| r.call(s) } }
puts "part2: #{matches.count}"
