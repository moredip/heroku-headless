require "heroku-headless/talks_to_heroku"

module HerokuHeadless
  class DisposableAppDeleter
    include TalksToHeroku

    def self.delete_all
      new.delete_all_apps
    end

    def delete_all_apps
      apps = heroku.get_apps.body.map{ |h| h['name'] }
      disposable_apps = apps.select{ |x| x.start_with?( 'disposable' ) }
      disposable_apps.each do |app|
        puts "deleting #{app}"
        heroku.delete_app app
      end
    end
  end
end
