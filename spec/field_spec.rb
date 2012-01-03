require 'spec_helper'

describe Field do

  context "when given a player set with one player" do
    players =[{id: 'jb', rating: 3.0}]
    subject { Field.new(players) }
    its(:count) { should eq(1) }
  end

  context "when given a set where lisa is the lowest ranked" do
    players =[{id: 'jb', rating: 3.0}, {id: 'lisa', rating: -4.0}]
    subject { Field.new(players) }
    its('sort.first.id') { should eq "lisa"}
  end

end
