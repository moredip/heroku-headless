require 'securerandom'

module HerokuHeadless
  module CreatesUIDs
    def generate_uid
      SecureRandom.hex(16).downcase
    end
    module_function :generate_uid
  end
end
