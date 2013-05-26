module HerokuHeadless
  module DocumentsActions
    def do_action(description)
      print "  " + description + " ..."
      result = yield
      puts " DONE"
      result
    end
  end
end
