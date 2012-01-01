#!/usr/bin/env ruby

# Example Usage:
# bundle exec ./example.rb spec/input/players/08-cornell.txt 3.0 3
require 'smpair'

# usage instructions: how to invoke this example
if ARGV.length != 3 then
  puts "Usage: ruby smpair.rb <players-file> <bar> <rounds>"
  puts " players-file".ljust(15) + "path to a csv file with headers (eg. name,rating)"
  puts " bar".ljust(15) + "decimal rating threshold defining the top band"
  puts " rounds".ljust(15) + "number of rounds in tournament"
  exit
end

# validate and load cmd line args
player_list_filepath = ARGV[0]
bar = ARGV[1].to_f
rounds = ARGV[2].to_i

# read the input file
c = CSV.open player_list_filepath, :headers => true rescue
  abort "Unable to open file: " + $!.to_s
players = []
c.each_with_index do |r,i|
  players << {name: r['name'], rating: r['rating']}
end

# perform pariring
matching = Smpair.pair(players, bar, rounds)
puts "\nPairings:"
matching.each{|edge| puts edge[0].to_s.ljust(5) + edge[1].to_s.ljust(5)}
