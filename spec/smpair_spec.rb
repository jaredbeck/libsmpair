require 'spec_helper'

describe Smpair do
  before do
    @bar = 1.0
    @rounds = 3
  end

  describe "::pair" do
    context "with empty player set" do
      before do
        @players = []
      end

      it "returns an empty array" do
        Smpair::pair(@players, @bar, @rounds).should be_empty
      end
    end

    context "with two players" do
      before do
        @players = [
          {name:'Joe', rating:1.5},
          {name:'Jane', rating:2.5}
          ]
      end

      it "returns an array with two corresponding pairings" do
        result = Smpair::pair(@players, @bar, @rounds)
        result.should == [[0, 1], [1, 0]]
      end
    end
  end

  describe "version" do
    it "returns a version string" do
      Smpair::VERSION.should match /^\d+(\.\d+){2}$/
    end
  end
end
