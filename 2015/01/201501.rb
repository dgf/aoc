#!/usr/bin/env ruby
# frozen_string_literal: false

steps = File.read(ARGV.shift || 'example.txt')
            .strip.chars.map { |f| f == '(' ? 1 : -1 }
puts "part1: #{steps.sum}"

floors = [0]
steps.each { |s| floors << floors.last + s }
puts "part2: #{floors.index(-1)}"
