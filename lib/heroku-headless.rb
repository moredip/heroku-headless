require "heroku-headless/version"

require "heroku-headless/documents_actions"
require "heroku-headless/creates_uuids"
require "heroku-headless/talks_to_heroku"

require "heroku-headless/deployer"

module HerokuHeadless
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.heroku
    @@heroku ||= Heroku::API.new(:mock => HerokuHeadless.configuration.mock_mode)
  end

  class Configuration
    attr_accessor :mock_mode
  end
end