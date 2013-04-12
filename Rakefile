#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:integration) do | spec |
  spec.pattern = 'integration/**/*_spec.rb'
end

task :default => [:spec, :integration]
task :build => :spec
