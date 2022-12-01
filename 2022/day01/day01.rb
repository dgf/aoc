#!/usr/bin/env ruby
# frozen_string_literal: false

sums = File.read(ARGV.shift || 'example.txt')
           .gsub(/\n/, '_').split('__') # group by empty line
           .map { |g| g.split('_').map(&:to_i).sum } # sum group values

puts "part 1: #{sums.max}"
puts "part 2: #{sums.max(3).sum}"
