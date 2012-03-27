require 'scanf'
module Capistrano

  class Version

    MAJOR = 2
    MINOR = 11
    PATCH = 2

    def self.to_s
      "#{MAJOR}.#{MINOR}.#{PATCH}"
    end

  end

end
