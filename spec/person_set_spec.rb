require './person_set'

PLAYER_LIST_DIR = "spec/input/players"

describe PersonSet do

  context "when first created" do
    its(:count) { should eq(0) }
  end

  context "after reading a player list with four players" do
    subject { PersonSet.read_csv PLAYER_LIST_DIR + '/01.csv' }
    its(:count) { should eq(4) }
  end

  context "after reading a list where lisa is the lowest ranked" do
    subject { PersonSet.read_csv PLAYER_LIST_DIR + '/01.csv' }
    its('sort.first.name') { should eq "Lisa Scott"}
  end

end
