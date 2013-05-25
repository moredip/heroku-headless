require "heroku-headless/version"

require "heroku-headless/documents_actions"
require "heroku-headless/creates_uids"
require "heroku-headless/talks_to_heroku"

require "heroku-headless/deployer"

module HerokuHeadless
  class << self
    attr_writer :configuration
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.heroku
    @@heroku ||= Heroku::API.new(:mock => HerokuHeadless.configuration.mock_mode)
  end

  class Configuration
    attr_accessor :mock_mode, :pre_deploy_git_commands, :post_deploy_commands

    def initialize
      @pre_deploy_git_commands = []
      @post_deploy_commands = []
      @mock_mode ||= false
    end
  end
end
