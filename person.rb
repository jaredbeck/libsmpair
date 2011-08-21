class Person
  attr_accessor :name, :rating, :score
  include Comparable

  def <=>(p)
    self.rating <=> p.rating
  end

  def initialize(n,r)
    @name = n.to_s
    @rating = r.to_f
    raise_if_not_valid
  end

  def to_print_s
    name.ljust(30) + rating.round(2).to_s.ljust(15) + score.to_s
  end

  def raise_if_not_valid
    raise "Name is required" if @name.nil? or @name.strip.empty?
    raise "Invalid rating" unless valid_rating?
  end

  def valid_rating?
    # In the AGA, valid kyu ratings are -1.0 and below, while valid dan 
    # ratings are 1.0 and above (including pros). There is no upper or
    # lower limit in the AGA database. The current range is -49.67667 
    # to 10.24712
    !@rating.nil? and (@rating <= -1.0 or @rating >= +1.0)
  end
end
