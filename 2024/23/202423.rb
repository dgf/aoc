#!/usr/bin/env ruby
# frozen_string_literal: false

conns = Hash.new { |h, k| h[k] = Set.new }
File.read(ARGV.shift || 'example.txt')
    .lines.map { |l| l.strip.split(/-/) }
    .each do |(a, b)|
  conns[a] << b
  conns[b] << a
end

triples = Set.new
conns.each do |n, c|
  c.each do |a|
    conns[a].each do |b|
      triples << Set[n, a, b] if conns[b].include?(n)
    end
  end
end

puts "part1: #{triples.select { |t| t.any? { |c| c.start_with?('t') } }.count}"

def connect(groups, conns, group, name)
  return if groups.include?(group)

  groups << group
  conns[name].each do |n|
    next if group.include?(n)
    next if group.any? { |g| !conns[g].include?(n) }

    connect(groups, conns, group << n, n)
  end
end

groups = Set.new
conns.each_key { |n| connect(groups, conns, Set[n], n) }
puts "part2: #{groups.max_by(&:count).sort.join(',')}"
