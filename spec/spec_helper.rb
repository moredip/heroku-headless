require 'rspec'
require 'heroku-headless'

HerokuHeadless.configure do | config |
  config.mock_mode = true
end