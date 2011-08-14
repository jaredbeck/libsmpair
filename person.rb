class Person
  attr_accessor :name, :rating
  
  def initialize(n,r)
    @name = n.to_s
    @rating = r.to_f
    raise_if_not_valid
  end

  def raise_if_not_valid
    raise "Name is required" if @name.nil? or @name.strip.empty?
    if @rating.nil? or @rating == 0 or @rating < -35 or @rating > 9 then
      raise "Invalid rating"
    end
  end

end
