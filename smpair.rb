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

# read csv player list
ps = PersonSet.read_csv player_list_filepath

# get array of people, ordered by descending rating
person_array = ps.sort.reverse

# get players above the bar, ordered by descending rating
people_above_bar = ps.select { |p| p.rating > bar }.sort.reverse
PersonSet.print_person_array people_above_bar
