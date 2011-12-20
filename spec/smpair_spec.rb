require 'spec_helper'

describe Smpair do
  describe "version" do
    it "returns a version string" do
      Smpair::VERSION.should match /^\d+(\.\d+){2}$/
    end
  end
end
