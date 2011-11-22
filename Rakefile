require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# Invoke Rocco.make (from rocco/tasks) which adds a rake task
# for generating docs with rocco.
# http://rtomayko.github.com/rocco/tasks.html
begin
  require 'rocco/tasks'
  Rocco::make 'doc/rocco/', '*.rb'
rescue LoadError
  warn "#$! -- rocco tasks not loaded."
  task :rocco
end
