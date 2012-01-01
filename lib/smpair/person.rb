class Person

attr_accessor :name, :rating, :score
include Comparable

#### Public methods
public

def <=>(p)
  self.rating <=> p.rating
end

def initialize(n,r)
  @name = n.to_s
  @rating = r.to_f
  raise SmpairInvalidPlayerError, "Name is required" if @name.nil? or @name.strip.empty?
  raise SmpairInvalidPlayerError, "Invalid rating" unless valid_rating?
end

# `mwpm_weight` takes an `other_person` and returns an integer weight
# measuring the quality of the pairing.  We use _Minimum Weight Perfect
# Matching_, so a higher number indicates lower quality, thus making a
# given pairing less likely.
#
# There are three weighting "modes".  Currently, only handicap
# tournaments are implemented.
#
# * __Traditionally__, all games within a band are played without a handicap.
#   In such a tournament, the difference between player's _McMahon scores_
#   would be the most important factor of the weight.  This works well for
#   tournaments with large fields.
#
# * __Handicap tournaments__ are also popular, especially when player’s ranks
#   are not distributed uniformly, and there are large gaps in the player’s
#   ranks.  In this case, the difference between player's _ratings_ would
#   also be a factor (in addition to McMahon scores)
#
# * __Handicap tournament with even top band__ According to the AGA:
#   "Programs must also have the option to ensure that all games involving
#   players in the top band are even, regardless of the handicap settings
#   for the remainder of the field."
#
# The heuristics for weighting have not yet been established.
#
def mwpm_weight(other_person)
  raise "Score undefined" if (score.nil? or other_person.score.nil?)
  mm_score_delta = (score - other_person.score).abs
  rating_delta = (rating - other_person.rating).abs
  ((mm_score_delta * 100) + rating_delta).to_i
end

def to_print_s
  name.ljust(30) + rating.round(2).to_s.ljust(15) + score.to_s
end

#### Private methods
private

# `valid_rating?` returns true if self.rating is a valid decimal
# AGA rating. In the AGA, valid kyu ratings are -1.0 and below,
# while valid dan ratings are 1.0 and above (including pros). There
# is no upper or lower limit in the AGA database. The last time I
# checked, ratings ranged from -49.67667 to 10.24712
def valid_rating?
  !@rating.nil? and (@rating <= -1.0 or @rating >= +1.0)
end

end
