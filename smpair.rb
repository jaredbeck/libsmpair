require './person_set'

# cmd line args
if ARGV.length != 1 then
  puts "Usage: ruby smpair.rb players-file"
end

# read csv player list
ps = PersonSet.new()
ps.read_csv ARGV[0]

# print players
ps.to_array.each() do |p|
  puts p.name + "\t\t" + p.rating.to_s
end