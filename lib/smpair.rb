# AGA Swiss McMahon Pairing

require "open3"
require 'smpair/version'
require 'smpair/field'

module Smpair
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

    # MWPM - Minimum Weight Perfect Match
    puts "\nPairings:", field.matching.inspect
  end
end
