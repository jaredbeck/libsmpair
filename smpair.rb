#!/usr/bin/env ruby

require "open3"
require './field'
require './monkeypatch_core'

# usage instructions
if ARGV.length != 3 then
  puts "Usage: ruby smpair.rb <players-file> <bar> <rounds>"
  puts " players-file".ljust(15) + "path to a csv file with headers (eg. name,rating)"
  puts " bar".ljust(15) + "decimal rating threshold defining the top band"
  puts " rounds".ljust(15) + "number of rounds in tournament"
  exit
end

# validate and load cmd line args
player_list_filepath = ARGV[0]
abort "Bar must be a decimal number." unless ARGV[1].strictly_decimal?
bar = ARGV[1].to_f
abort "Rounds must be an integer." unless ARGV[2].strictly_integer?
rounds = ARGV[2].to_i

# read csv player list and construct bands
field = Field.read_csv player_list_filepath
bands = field.bands bar, rounds

# dev. output
puts
field.pretty_print

# puts "band".ljust(10) + "ratings".ljust(20) + "players".ljust(15) + "initial score"
# bands.each_with_index do |b,i|
#   rating_range = b.max.rating.round(2).to_s + " to " + b.min.rating.round(2).to_s
#   puts i.to_s.ljust(10) + rating_range.ljust(20) + b.count.to_s.ljust(15) + b.score.to_s
# end

# MWPM - Minimum Weight Perfect Match
stdin, stdout, stderr = Open3.popen3('python lib/mwm/mwm.py')
field.edges_for_mwpm.each { |e| stdin.puts e }
stdin.close

puts
puts "Pairings:"
puts stdout.gets until stdout.eof?
