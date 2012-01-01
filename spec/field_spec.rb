require 'spec_helper'

PLAYER_LIST_DIR = "spec/input/players"

describe Field do

  context "when given a player set with one player" do
    players =[{name: 'jb', rating: 3.0}]
    subject { Field.new(players) }
    its(:count) { should eq(1) }
  end

  context "when given a set where lisa is the lowest ranked" do
    players =[{name: 'jb', rating: 3.0}, {name: 'lisa', rating: -4.0}]
    subject { Field.new(players) }
    its('sort.first.name') { should eq "lisa"}
  end

end
