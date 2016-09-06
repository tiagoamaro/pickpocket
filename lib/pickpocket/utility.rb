require 'fileutils'

module Pickpocket
  class Utility
    def self.ensure_home_folder
      FileUtils.mkdir_p(Pickpocket.config.home_folder)
    end
  end
end
