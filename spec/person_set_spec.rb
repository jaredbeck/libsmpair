require 'spec_helper'

# Person set is meant to be mixed into a class, so we use a mock
# class for testing.
class BikerGang
  include PersonSet
end

describe PersonSet do
  describe "#push" do
    it "raises an error unless given a person" do
      expect {
        BikerGang.new.push("derp not a person")
      }.to raise_error(SmpairInvalidPlayerError)
    end
  end

  describe "#pairing_order" do
    it "returns people ordered by descending rating" do
      hells_angels = BikerGang.new
      hells_angels.push Person.new(:id => "Ken Kesey", :rating => -35.0)
      hells_angels.push Person.new(id:"Otto Friedli", rating:-30.0)
      hells_angels.pairing_order.first.id.should == "Otto Friedli"
    end
  end 
end
