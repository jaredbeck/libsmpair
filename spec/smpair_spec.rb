require 'spec_helper'

describe Smpair do
  before do
    @bar = 1.0
    @rounds = 3
  end

  describe "::pair" do
    context "with invalid player set" do
      it "raises an SmpairArgumentError" do
        expect {
          Smpair::pair("quite invalid", @bar, @rounds)
        }.to raise_error(SmpairArgumentError)
      end
    end

    context "with invalid bar" do
      it "raises an SmpairArgumentError" do
        expect {
          Smpair::pair([], true, @rounds)
        }.to raise_error(SmpairArgumentError)
      end
    end

    context "with invalid number of rounds" do
      it "raises an SmpairArgumentError" do
        expect {
          Smpair::pair([], @bar, {})
        }.to raise_error(SmpairArgumentError)
      end
    end

    context "with empty player set" do
      it "returns an empty array" do
        Smpair::pair([], @bar, @rounds).should be_empty
      end
    end

    context "with two players" do
      before do
        @players = [
          {id:'HAL9000', rating:1.5},
          {id:'PDP11', rating:2.5}
          ]
      end

      it "returns an array with two corresponding pairings" do
        Smpair::pair(@players, @bar, @rounds).should == [[0, 1], [1, 0]]
      end
    end
  end

  describe "version" do
    it "returns a version string" do
      Smpair::VERSION.should match /^\d+(\.\d+){2}$/
    end
  end
end
