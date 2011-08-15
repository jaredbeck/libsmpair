require './person_set'

# cmd line args
if ARGV.length != 1 then
  puts "Usage: ruby smpair.rb players-file"
  exit
end

# read csv player list
ps = PersonSet.read_csv(ARGV[0])

# get array of people, ordered by descending rating
person_array = ps.sort.reverse

# print players
person_array.each() do |p|
  puts p.name + "\t\t" + p.rating.to_s
end
