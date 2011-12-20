# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smpair/version"

Gem::Specification.new do |s|
  s.name        = "smpair"
  s.version     = Smpair::VERSION
  s.authors     = ["Jared Beck"]
  s.email       = ["jared@jaredbeck.com"]
  s.homepage    = "https://github.com/jaredbeck/smpair"
  s.summary     = %q{AGA Swiss McMahon Pairing}
  s.description = %q{AGA Swiss McMahon Pairing}

  s.rubyforge_project = "smpair"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
