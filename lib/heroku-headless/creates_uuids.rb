module HerokuHeadless
  module CreatesUUIDs
    def generate_lowercase_uuid
      `uuidgen`.chomp.downcase
    end
    module_function :generate_lowercase_uuid
  end
end
