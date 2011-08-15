require './person_set'

describe PersonSet do

  context "when first created" do
    its(:to_array) { should have(0).items }
  end

  context "after reading a player list with four players" do
    subject do
      ps = PersonSet.new
      ps.read_csv 'input/01.csv'
      ps
    end
    its(:to_array) { should have(4).items }
  end

end
