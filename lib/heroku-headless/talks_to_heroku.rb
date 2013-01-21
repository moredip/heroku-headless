require 'heroku-api'

module HerokuHeadless
  module TalksToHeroku
    def heroku
      @heroku ||= Heroku::API.new()
    end
  end
end
