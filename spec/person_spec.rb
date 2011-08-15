require './person'

describe Person do
  describe "#new" do

    it "requires a name" do
      expect { Person.new("",7) }.
        to raise_error(StandardError, "Name is required")
    end

    it "requires a valid rating" do
      bad_ratings = [nil, 0.0, -0.9, 0.7]
      bad_ratings.each do |r|
        expect { Person.new("Jared",r) }.
          to raise_error(StandardError, "Invalid rating")
      end
    end

  end
end