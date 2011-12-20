# AGA Swiss McMahon Pairing

require "open3"
require 'smpair/version'
require 'smpair/field'
require 'smpair/monkeypatch_core'

module Smpair
  def self.pair(player_list_filepath, bar, rounds)
    
    # read csv player list and construct bands
    field = Field.read_csv player_list_filepath
    bands = field.bands bar, rounds

    # dev. output
    puts
    field.pretty_print

    # puts "band".ljust(10) + "ratings".ljust(20) + "players".ljust(15) + "initial score"
    # bands.each_with_index do |b,i|
    #   rating_range = b.max.rating.round(2).to_s + " to " + b.min.rating.round(2).to_s
    #   puts i.to_s.ljust(10) + rating_range.ljust(20) + b.count.to_s.ljust(15) + b.score.to_s
    # end

    # MWPM - Minimum Weight Perfect Match
    stdin, stdout, stderr = Open3.popen3('python lib/mwm/mwm.py')
    field.edges_for_mwpm.each { |e| stdin.puts e }
    stdin.close

    puts
    puts "Pairings:"
    puts stdout.gets until stdout.eof?
  end
end
