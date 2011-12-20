require 'spec_helper'

PLAYER_LIST_DIR = "spec/input/players"

describe Field do

  context "when first created" do
    it { should have(0).items }
  end

  context "after reading a player list with four players" do
    subject { Field.read_csv PLAYER_LIST_DIR + '/01.csv' }
    its(:count) { should eq(4) }
  end

  context "after reading a list where lisa is the lowest ranked" do
    subject { Field.read_csv PLAYER_LIST_DIR + '/01.csv' }
    its('sort.first.name') { should eq "Lisa Scott"}
  end

end
