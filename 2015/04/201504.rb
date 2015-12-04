#!/usr/bin/env ruby
# frozen_string_literal: false

require 'digest'
md5_start_with = ->(s, z) { Digest::MD5.hexdigest(s).start_with?(z) }

secret = File.read(ARGV.shift || 'example.txt').strip
mine = ->(s, z, i = 0) { loop { return i if md5_start_with.call("#{s}#{i += 1}", '0' * z) } }

puts "part1: #{mine.call(secret, 5)}"
puts "part2: #{mine.call(secret, 6)}"
