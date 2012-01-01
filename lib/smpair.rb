# AGA Swiss McMahon Pairing

require 'smpair/version'
require 'smpair/field'
require 'smpair/exceptions'

module Smpair

  # `pair` takes a set of `players`, a decimal `bar`, and an integer number
  # of `rounds`.  It returns an array of pairings.  Each paring is an
  # array with two elements: the identifiers of the paired players.
  #
  # * `players` is an array of hashes
  # * `bar` is a decimal rating threshold defining the top band
  # * `rounds` is the total number of rounds in the tournament
  #
  def self.pair(players, bar, rounds)
    validate_argument players.respond_to?(:each), "Players must be ennumerable"
    validate_argument bar.respond_to?(:to_f), "Bar must be a decimal number"
    validate_argument rounds.respond_to?(:to_i), "Rounds must be an integer"

    # build field from players array
    field = Field.new players

    # dev. output
    field.pretty_print 

    # construct bands
    bands = field.bands bar, rounds
    puts "band".ljust(10) + "ratings".ljust(20) + "players".ljust(15) + "initial score"
    bands.each_with_index do |b,i|
      rating_range = b.max.rating.round(2).to_s + " to " + b.min.rating.round(2).to_s
      puts i.to_s.ljust(10) + rating_range.ljust(20) + b.count.to_s.ljust(15) + b.score.to_s
    end

    # Minimum Weight Perfect Match (MWPM)
    return field.matching
  end

  private

  # `assert_valid_argument` provides a nice shorthand
  def self.validate_argument(success, message)
    raise SmpairArgumentError, message unless success
  end

end
