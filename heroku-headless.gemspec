# -*- encoding: utf-8 -*-
require File.expand_path('../lib/heroku-headless/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Pete Hodgson"]
  gem.email         = ["phodgson@thoughtworks.com"]
  gem.description   = %q{Push from your git repo to a heroku app without any external configuration.}
  gem.summary       = %q{Heroku's workflow is geared towards pushing to a heroku app from a dev workstation. This gem makes it easy to push to a heroku app as part of a CI/CD setup.}
  gem.homepage      = "https://github.com/moredip/heroku-headless"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "heroku-headless"
  gem.require_paths = ["lib"]
  gem.version       = HerokuHeadless::VERSION

  gem.add_runtime_dependency "heroku-api"
  gem.add_development_dependency "rspec"
end
