module HerokuHeadless
  module CreatesUIDs
    def generate_uid
      `uuidgen`.chomp.downcase
    end
    module_function :generate_uid
  end
end
