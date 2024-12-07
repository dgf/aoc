#!/usr/bin/env ruby

def check2(r, e)
  return r == e.first if e.count == 1
  return true if (r % e.last == 0 and check2(r / e.last, e[...-1])) or # last divisible
                 (r > e.last and check2(r - e.last, e[...-1])) # last is deductible

  false
end

def check3(r, e)
  rs = r.to_s
  ls = e.last.to_s
  return r == e.first if e.count == 1
  return true if (r % e.last == 0 and check3(r / e.last, e[...-1])) or # last divisible
                 (r > e.last and check3(r - e.last, e[...-1])) or # last is deductible
                 (rs.length > ls.length and rs.end_with?(ls) and # last can be concatenated
                                check3(rs[0...-ls.length].to_i, e[...-1]))

  false
end

eqs = File.read(ARGV.shift || 'example.txt').lines.map(&:strip)
          .map { |l| l.split(/: | /).map(&:to_i) }

total = 0
unsolved = []
eqs.each { |e| check2(e.first, e[1..]) ? (total += e.first) : unsolved << e }
puts "part1: #{total}"

unsolved.each { |e| total += e.first if check3(e.first, e[1..]) }
puts "part2: #{total}"
