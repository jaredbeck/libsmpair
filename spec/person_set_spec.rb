require './person_set'

PLAYER_INPUT_DIR = "spec/input/players"

describe PersonSet do

  context "when first created" do
    its(:to_array) { should have(0).items }
  end

  context "after reading a player list with four players" do
    subject do
      ps = PersonSet.new
      ps.read_csv PLAYER_INPUT_DIR + '/01.csv'
      ps
    end
    its(:to_array) { should have(4).items }
  end

end
