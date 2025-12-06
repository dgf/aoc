#!/usr/bin/env ruby
# frozen_string_literal: false

lines = File.read(ARGV.shift || 'example.txt').lines

c = 0
lines.map { |l| l.strip.split(/ +/) }.transpose.each do |p|
  o = p.pop
  a = p.map(&:to_i)
  c += a.reduce(:+) if o == '+'
  c += a.reduce(:*) if o == '*'
end

puts "part 1: #{c}"

total = lines.map { |l| l.chop.split('') }.transpose
             .chunk_while { |_i, j| j.uniq != [' '] }
             .map { |b| b.reject { |l| l.uniq == [' '] } }
             .map { |b| b.map(&:join).map(&:to_i).reduce(b[0][-1] == '+' ? :+ : :*) }
             .sum

puts "part 2: #{total}"
