require './person_set'

# cmd line args
if ARGV.length != 2 then
  puts "Usage: ruby smpair.rb players-file bar"
  puts " players-file\tpath to a csv file with headers (eg. name,rating)"
  puts " bar\t\tthe rating threshold defining the top group"
  exit
end

player_list_filepath = ARGV[0]
bar = ARGV[1]

# Bar must be a decimal number
if !bar.match(/^\-?[0-9]+\.[0-9]+$/) or bar.to_f == 0.0 then
  puts "Invalid bar.  Bar must be a decimal number.  See usage instructions."
  exit
end
bar = bar.to_f

# read csv player list and construct bands
ps = PersonSet.read_csv player_list_filepath
bands = ps.bands(bar)

# dev. output
# ps.pretty_print
puts "#{ps.count} players"
puts "band".ljust(10) + "players".ljust(15) + "initial score"
bands.each_with_index do |b,i|
  puts i.to_s.ljust(10) + b.count.to_s.ljust(15) + b.score.to_s
end
# bands.last.pretty_print
