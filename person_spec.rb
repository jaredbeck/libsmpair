require './person'

describe Person do
  describe "#name" do
    it "returns nil" do
      p = Person.new
      p.name.should == nil
    end
  end
end