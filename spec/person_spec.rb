require './person'

describe Person do
  describe "#new" do

    it "requires a name" do
      expect { Person.new("",7) }.
        to raise_error(StandardError, "Name is required")
    end

    it "requires a valid rating" do
      expect { Person.new("Jared",nil) }.
        to raise_error(StandardError, "Invalid rating")
    end

  end
end