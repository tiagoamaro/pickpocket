require 'fileutils'

module Pickpocket
  class TokenHandler
    TOKEN_FOLDER = File.join(Dir.home, '.pickpocket')
    TOKEN_FILE   = File.join(TOKEN_FOLDER, 'token')

    attr_accessor :logger

    def initialize
      @logger = Pickpocket::Logger.new
    end

    def save(token)
      ensure_token_folder

      file = File.new(TOKEN_FILE, 'w')
      file.write(token)
      file.close
    end

    def read
      file = File.new(TOKEN_FILE, 'r')
      file.read
    rescue Errno::ENOENT => _
      logger.warn('Token file does not exist. Make sure you request authorization before proceeding.')
      :no_token
    end

    private

    def ensure_token_folder
      FileUtils.mkdir_p(TOKEN_FOLDER)
    end
  end
end
