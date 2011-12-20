require 'smpair/person_set'

class Band
  attr_accessor :score
  include PersonSet

  def initialize(score, people=[])
    @people = people
    @score = score
    @people.each { |p| p.score = @score }
  end
end