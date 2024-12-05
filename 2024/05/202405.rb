#!/usr/bin/env ruby

block2d = lambda do |block|
  block.lines
       .map(&:strip)
       .map { |l| l.split(/\||,/).map(&:to_i) }
end

rules, updates = File.read(ARGV.shift || 'example.txt')
                     .split(/\n{2,}/)
                     .map { |b| block2d.call(b) }

pages_by_front = rules.group_by(&:first)
                      .map { |k, v| [k, v.map(&:last)] }
                      .to_h

fits = lambda do |update|
  update[1...].each.with_index do |c, i|
    if pages_by_front[c]
      pref = update[..i]
      return i + 1 if pref - pages_by_front[c] != pref
    end
  end
  true
end

unfits = []
total = 0
updates.each do |update|
  if fits.call(update) == true
    total += update[update.count / 2]
  else
    unfits << update
  end
end
puts "part1: #{total}"

total = 0
unfits.each do |update|
  i = fits.call(update)
  while i != true
    update[i - 1], update[i] = update[i], update[i - 1]
    i = fits.call(update)
  end
  total += update[update.count / 2]
end
puts "part2: #{total}"
