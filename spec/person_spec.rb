require './person'

describe Person do
  describe "#new" do

    it "requires a name" do
      expect { Person.new("",7) }.to raise_error
    end

  end
end