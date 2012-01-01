require 'spec_helper'

describe Smpair do
  before do
    @bar = 1.0
    @rounds = 3
  end

  context "with empty player set" do
    before do
      @players = []
    end

    describe "pair" do
      it "returns an empty array" do
        Smpair::pair @players, @bar, @rounds
      end
    end
  end

  describe "version" do
    it "returns a version string" do
      Smpair::VERSION.should match /^\d+(\.\d+){2}$/
    end
  end
end
