#!/usr/bin/env ruby

reports = File.read(ARGV.shift || 'example.txt')
              .lines.map { |l| l.split.map(&:to_i) }
reports.each { |r| r.reverse! if r[0] > r[-1] }

is_safe = lambda do |r|
  ups = 0
  r[1...].each.with_index do |l, i|
    d = l - r[i]
    return i unless 1 <= d and d <= 3

    ups += 1
  end
  ups == r.count - 1
end

safes = 0
reports.each { |r| safes += 1 if is_safe.call(r) == true }
puts "part 1: #{safes}"

tols = 0
reports.each do |r|
  pos = is_safe.call(r)
  next unless pos == true or
              is_safe.call(r[...pos] + r[pos + 1...]) == true or
              is_safe.call(r[...pos + 1] + r[pos + 2...]) == true

  tols += 1
end
puts "part 2: #{tols}"
