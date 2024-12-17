#!/usr/bin/env ruby
# frozen_string_literal: false

combo = ->(r, c) { c < 4 ? c : r[c % 4] }

inst = [
  ->(r, c) { r[0] = r[0] / (2**combo.call(r, c)) }, # adv
  ->(r, l) { r[1] = r[1] ^ l },                     # bxl
  ->(r, c) { r[1] = combo.call(r, c) % 8 },         # bst
  ->(r, _) { r[0] != 0 },                           # jnz
  ->(r, _) { r[1] = r[1] ^ r[2] },                  # bxc
  ->(r, c) { combo.call(r, c) % 8 },                # out
  ->(r, c) { r[1] = r[0] / (2**combo.call(r, c)) }, # bdv
  ->(r, c) { r[2] = r[0] / (2**combo.call(r, c)) }  # cdv
]

run = lambda do |prog, regs, &out|
  p = 0
  while p < prog.count
    i = prog[p]
    o = prog[p + 1]
    r = inst[i].call(regs, o)
    out.call(r) if i == 5
    i == 3 && r == true ? (p = o) : (p += 2)
  end
end

blocks = File.read(ARGV.shift || 'example.txt').split(/\n\n/)
regs = blocks.first.lines.map { |l| l.split(/:/).last.to_i }
prog = blocks.last.split(/:/).last.split(/,/).map(&:to_i)

output = []
run.call(prog, regs) { |o| output << o }
puts "part1: #{output.join(',')}"

# preconditions for that specific part 2 solution
raise 'needs a loop at the end' unless prog[-2..] == [3, 0]
raise 'outputs directly before the end' unless prog[-4] == 5

# raise 'shifts 3 of A each run' unless prog == 5 ???

apps = [0]
(0...prog.count).reverse_each do |i|
  next_apps = []
  apps.each do |a|
    (0..7).each do |t| # bit mask
      n = a + (t << (3 * i))
      r = []
      run.call(prog, [n, 0, 0]) { |o| r << o }
      next unless prog[i..] == r[i..]

      next_apps << n
    end
  end
  apps = next_apps
end
puts "part2: #{apps.min}"
