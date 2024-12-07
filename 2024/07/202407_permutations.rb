#!/usr/bin/env ruby

def check2(e)
  (0..2**(e.count - 2)).each do |perm| # binary permutation => 1 = * and 0 = +
    r = e[1]
    e[2...].each do |v|
      r = perm & 0b1 == 1 ? (r *= v) : (r += v)
      perm >>= 1
    end

    return true if r == e.first
  end
  false
end

def check3(e)
  [1, 2, 3].repeated_permutation(e.count - 2).to_a.each do |perm|
    r = e[1]
    perm.each.with_index do |p, i|
      v = e[2 + i]
      case p
      when 1
        r *= v
      when 2
        r += v
      when 3
        r = "#{r}#{v}".to_i
      end
    end
    return true if r == e.first
  end
  false
end

eqs = File.read(ARGV.shift || 'example.txt').lines.map(&:strip)
          .map { |l| l.split(/: | /).map(&:to_i) }

total = 0
unsolved = []
eqs.each { |e| check2(e) ? (total += e.first) : unsolved << e }
puts "part1: #{total}"

unsolved.each { |e| total += e.first if check3(e) }
puts "part2: #{total}"
