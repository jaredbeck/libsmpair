require './person_set'

PLAYER_INPUT_DIR = "spec/input/players"

describe PersonSet do

  context "when first created" do
    its(:count) { should eq(0) }
  end

  context "after reading a player list with four players" do
    subject do
      ps = PersonSet.new
      ps.read_csv PLAYER_INPUT_DIR + '/01.csv'
      ps
    end
    its(:count) { should eq(4) }
  end

end
