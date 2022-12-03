#!/usr/bin/env ruby
# frozen_string_literal: false

lines = File.read(ARGV.shift || 'example.txt').lines.map(&:strip)

to_char_sets = ->(g) { g.map { |l| Set.new(l.chars) } }
to_num = ->(c) { c >= 'a' ? c.ord - 'a'.ord + 1 : c.ord - 'A'.ord + 27 }
first_intersect2d = ->(a) { (a[0] & a[1]).first }
chars2d = lines.map { |s| [s[0, s.length / 2], s[s.length / 2, s.length]] }
               .map(&to_char_sets)

first_intersect3d = ->(a) { (a[0] & a[1] & a[2]).first }
groups = lines.each_slice(3).map(&to_char_sets)

puts "part 1: #{chars2d.map(&first_intersect2d).map(&to_num).sum}"
puts "part 2: #{groups.map(&first_intersect3d).map(&to_num).sum}"
