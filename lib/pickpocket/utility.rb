require 'fileutils'

module Pickpocket
  class Utility
    def self.ensure_home_folder
      FileUtils.mkdir_p(HOME_FOLDER)
    end
  end
end
