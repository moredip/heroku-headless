module HerokuHeadless
  module DocumentsActions
    def do_action(description)
      print "  " + description + " ..."
      yield
      puts " DONE"
    end
  end
end
