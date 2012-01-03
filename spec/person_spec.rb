require 'spec_helper'

describe Person do
  describe "#new" do

    it "requires an id" do
      expect { Person.new({id: "", rating: 7}) }.
        to raise_error(SmpairInvalidPlayerError, "ID is required")
    end

    it "requires a valid rating" do
      bad_ratings = [nil, 0.0, -0.9, 0.7]
      bad_ratings.each do |r|
        expect { Person.new({id: "007", rating: r}) }.
          to raise_error(SmpairInvalidPlayerError, "Invalid rating")
      end
    end

  end
end