#!/usr/bin/env ruby
# frozen_string_literal: false

strings = File.read(ARGV.shift || 'example.txt')
              .lines.map { |l| l.strip.chars }

vowels = %w[a e i o u]
unwanted = %w[ab cd pq xy]
rules = [
  ->(s) { s.select(&vowels.method(:include?)).count > 2 },
  ->(s) { s.each_cons(2).any? { |(a, b)| a == b } },
  ->(s) { s.each_cons(2).map { |(a, b)| "#{a}#{b}" }.none?(&unwanted.method(:include?)) }
]

matches = strings.select { |s| rules.all? { |r| r.call(s) } }
puts "part1: #{matches.count}"
