require 'CSV'
require 'smpair/band'
require 'smpair/person'
require 'smpair/person_set'
require 'smpair/mwm'

# The Field is a collection of all players in the tournament
class Field  
  include PersonSet

  # `bands` returns an array of bands based on the provided `bar`
  # and number of `rounds`.  The first band contains players above 
  # the `bar`.
  def bands(bar, rounds)
    bands = [Band.new(0, rating_gt(bar))]
    people = rating_lte(bar).sort.reverse
    while people.length > 0
      band_people = people.slice!(0, PREFERRED_BAND_SIZE)
      score = bands.last.score - band_separation(band_people.length, rounds)
      bands.push Band.new(score, band_people)
    end
    return bands
  end
  
  def band_separation(p, r)
    # The usual separation between bands is one McMahon point, but this is increased
    # when a band contains a large number of players. The separation between a given
    # band and the next higher one is given by integer part of S = D * P / R where S
    # is the band separation, P is the number of players in the band, R is the
    # number of rounds in a tournament and D is a parameter. The value of D
    # defaults to 0.75 but may be adjusted by the TD provided it does not conflict
    # with the limitations on the value of S (see below)
    sep = BAND_SEPARATION_CONSTANT.to_f * p / r.to_i
    
    # The value of S ranges between a minimum of 1 and a maximum of R/3, rounded up
    max_sep = (r.to_f / 3.0).ceil
    sep = [sep, max_sep].min
    sep = [sep, 1.0].max
    
    sep.to_i 
  end

  def initialize(players)
    @people = players.map {|p| Person.new p}
  end

  def matching
    return MWM.matching(edges_for_mwpm)
  end
end
