#!/usr/bin/env ruby
# frozen_string_literal: false

serials = File.read(ARGV.shift || 'example.txt')
              .lines.map { |l| l.strip.to_i }
              .map { |s| [s] }

evolve = lambda { |s|
  s = (s << 6 ^ s) % 16_777_216 # 2**24
  s = (s >> 5 ^ s) % 16_777_216
  (s << 11 ^ s) % 16_777_216
}

2000.times { serials.map! { |s| s << evolve.call(s.last) } }
puts "part1: #{serials.map(&:last).sum}"

seqs = Hash.new { |_, _| [] }
bananas = serials.map { |c| c.map { |s| s % 10 } }
bananas.map { |c| c.each_cons(2).map { |(a, b)| b - a } }
       .each.with_index do |changes, bi|
  seen = Set.new
  changes.each_cons(4).with_index do |(a, b, c, d), ci|
    change = [a, b, c, d]
    next if seen.include?(change)

    seen << change
    seqs[change] <<= bananas[bi][ci + 4]
  end
end

puts "part2: #{seqs.max_by { |_, s| s.sum }.last.sum}"
