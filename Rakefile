require 'rubygems'
require 'rake'
require 'bundler/setup'

Bundler.require

require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:all) do |t|
    t.rspec_opts = ["-c", "-fs"]
    t.pattern = "spec/**/*_spec.rb"
  end
end

desc "Same as spec:all"
task :spec => "spec:all"

task :default => :spec

