#!/usr/bin/env ruby
# frozen_string_literal: false

def connect(operator, (a, b))
  return nil if a.nil? || b.nil?

  {
    AND: -> { a & b }, OR: -> { a | b }, LSHIFT: -> { a << b }, RSHIFT: -> { a >> b }, NOT: -> { a ^ b }
  }[operator].call
end

def wire(gate, value)
  case gate
  when /^(\S+)$/
    value.call(Regexp.last_match(1))
  when /^NOT\s(\S+)$/
    connect(:NOT, [0xffff, value.call(Regexp.last_match(1))])
  when /^(\S+)\s(\S+)\s(\S+)$/
    connect(Regexp.last_match(2).to_sym, [Regexp.last_match(1), Regexp.last_match(3)].map(&value))
  end
end

def run(regs, proc)
  value = ->(v) { v.match(/\D+/).nil? ? v.to_i : regs[v] }

  until proc.empty?
    w, g = proc.shift
    (o = wire(g, value)).nil? ? proc << [w, g] : regs[w] = o
  end

  regs['a']
end

proc, signals = File.read(ARGV.shift || 'example.txt')
                    .lines.map(&:strip).map { |l| l.split(' -> ').reverse }
                    .partition { |(_w, v)| v.match(/^\d+$/).nil? }
regs = signals.map { |(w, v)| [w, v.to_i] }.to_h

a1 = run(regs.dup, proc.dup)
puts "part1: #{a1}"

a2 = run(regs.map { |k, _| [k, 0] }.to_h.merge({ 'b' => a1 }), proc.dup)
puts "part2: #{a2}"
