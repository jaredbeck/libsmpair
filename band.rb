class Band
  attr_accessor :score
  include Enumerable

  def each() @people.each { |p| yield p } end

  def initialize(score, people=[])
    @people = people
    @score = score
    @people.each { |p| p.score = @score }
  end

  def pretty_print
    puts "name".ljust(30) + "rating".ljust(15) + "mcmahon score"
    @people.sort.reverse.each() { |p| puts p.to_print_s } 
  end
end