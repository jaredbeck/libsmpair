require 'CSV'
require './band'
require './config'
require './person'

class PersonSet
  include Enumerable

  def self.read_csv(filepath)
    ps = PersonSet.new

    begin
      c = CSV.open filepath, :headers => true 
    rescue
      puts "Unable to open file: " + $!.to_s
      exit
    end

    c.each_with_index do |r,i|
      begin
        ps.push Person.new r['name'], r['rating']
      rescue
        puts "Invalid player record on line #{i+2}: " + $!.to_s
        exit
      end
    end
    
    return ps
  end

  def pretty_print
    puts "name".ljust(30) + "rating".ljust(15) + "mcmahon score"
    @people.each() { |p| puts p.to_print_s } 
  end
  
  def rating_gt(bar) @people.select { |p| p.rating > bar } end
  def rating_lte(bar) @people.select { |p| p.rating <= bar } end
  
  def bands(bar)
    bands = [Band.new(0, rating_gt(bar))] # first band contains players above bar
    people = rating_lte(bar).sort.reverse
    while people.length > 0
      band_people = people.slice!(0, PREFERRED_BAND_SIZE)
      score = bands.last.score - band_separation(band_people.length)
      bands.push Band.new(score, band_people)
    end
    return bands
  end
  
  def band_separation(p, r=6, d=0.75)
    # The usual separation between bands is one McMahon point, but this is increased
    # when a band contains a large number of players. The separation between a given
    # band and the next higher one is given by integer part of S = D * P / R where S
    # is the band separation, P is the number of players in the band, R is the
    # number of rounds in a tournament and D is a parameter. The value of D
    # defaults to 0.75 but may be adjusted by the TD provided it does not conflict
    # with the limitations on the value of S (see below)
    sep = d.to_f * p / r
    
    # The value of S ranges between a minimum of 1 and a maximum of R/3, rounded up
    max_sep = (r.to_f / 3.0).ceil
    sep = [sep, max_sep].min
    sep = [sep, 1.0].max
    
    sep.to_i 
  end
  
  def each() @people.each { |p| yield p } end
  def initialize() @people = [] end
  def push(p) @people.push p end
  def size() @people.length end
end
