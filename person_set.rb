module PersonSet
  include Enumerable

  def each() @people.each { |p| yield p } end
  def push(p) @people.push p end
  def size() @people.length end
  
  def pretty_print
    puts "name".ljust(30) + "rating".ljust(15) + "mcmahon score"
    @people.sort.reverse.each() { |p| puts p.to_print_s } 
  end
  
  def rating_gt(bar) @people.select { |p| p.rating > bar } end
  def rating_lte(bar) @people.select { |p| p.rating <= bar } end
end
