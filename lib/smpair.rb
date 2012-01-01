# AGA Swiss McMahon Pairing

require 'smpair/config'
require 'smpair/version'
require 'smpair/field'
require 'smpair/exceptions'

module Smpair

  # `pair` takes an array of `players`, a `bar`, and a number
  # of `rounds`.  It returns an array of pairings.  Each paring is an
  # array with two elements: the identifiers of the paired players.
  #
  # * `players` is an array of hashes (see below)
  # * `bar` is a decimal rating threshold defining the top band
  # * `rounds` is the total number of rounds in the tournament
  #
  # The hashes in the `players` array should have certain keys.
  # See `Person::initialize` for more details.
  #
  def self.pair(players, bar, rounds)
    validate_argument players.respond_to?(:each), "Players must be ennumerable"
    validate_argument bar.respond_to?(:to_f), "Bar must be a decimal number"
    validate_argument rounds.respond_to?(:to_i), "Rounds must be an integer"

    # build field from players array and construct bands
    field = Field.new players
    bands = field.bands bar, rounds

    if DEBUG_OUTPUT
      field.pretty_print
      puts "band".ljust(10) + "ratings".ljust(20) + "players".ljust(15) + "initial score"
      bands.each_with_index do |b,i|
        unless b.empty? then
          rating_range = b.max.rating.round(2).to_s + " to " + b.min.rating.round(2).to_s
          puts i.to_s.ljust(10) + rating_range.ljust(20) + b.count.to_s.ljust(15) + b.score.to_s
        end
      end
    end

    # Minimum Weight Perfect Match (MWPM)
    return field.matching
  end

  #### Private methods
  private

  def self.validate_argument(success, message)
    raise SmpairArgumentError, message unless success
  end

end
