# AGA Swiss McMahon Pairing

require 'smpair/version'
require 'smpair/field'

module Smpair

  # `pair` takes a set of players, a decimal `bar`, and an integer number
  # of `rounds`.  It returns an array of pairings.  Each paring is an
  # array with two elements: the identifiers of the paired players.
  #
  # * `bar` is a decimal rating threshold defining the top band
  # * `rounds` is the total number of rounds in the tournament
  #
  def self.pair(player_list_filepath, bar, rounds)

    # validate arguments
    abort "Bar must be a decimal number." unless bar.respond_to?(:to_f)
    abort "Rounds must be an integer." unless rounds.respond_to?(:to_i)
    
    # read csv player list
    field = Field.read_csv player_list_filepath
    field.pretty_print # dev. output

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
end
