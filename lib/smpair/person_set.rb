module PersonSet
  include Enumerable

  def each() @people.each { |p| yield p } end
  def empty?() @people.empty? end
  def push(p) @people.push p end
  def size() @people.length end
  
  def pretty_print
    puts "\nThe Field:"
    puts "#".ljust(4) + "name".ljust(30) + "rating".ljust(15) + "mcmahon score"
    @people.sort.reverse.each_with_index { |p,i| puts i.to_s.ljust(4) + p.to_print_s }
    puts
  end

  def edges_for_mwpm
    edges = []

    # Given all people in the set sorted by descending score
    ppl = @people.sort.reverse

    # Each possible pairing becomes a weighted edge in an undirected graph.
    # From this graph, a "perfect match" of edges with the lowest weights
    # will be found.  In other words, pairings with high weights are penalized.
    ppl.each_with_index do |a,y|
      ppl.each_with_index do |b,z|

        # Pairings which have not yet been considered are weighted and
        # added to the set of edges.  We also do not consider pairings
        # where a person plays themselves!  You cannot play against
        # yourself in a tournament :)
        if z > y then
          # puts "#{y} #{z} #{a.name} (#{a.score}) vs. #{b.name} (#{b.score}) = #{a.mwpm_weight(b).to_s}"
          edges.push( "#{y} #{z} #{a.mwpm_weight(b).to_s}" )
        end
      end
    end

    edges
  end
  
  def rating_gt(bar) @people.select { |p| p.rating > bar } end
  def rating_lte(bar) @people.select { |p| p.rating <= bar } end
end
