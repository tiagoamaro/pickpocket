module Pickpocket
  module Authentication
    class TokenHandler
      attr_accessor :logger

      def initialize
        @logger = Pickpocket::Logger.new
      end

      def save_oauth(token)
        save_token(token: token, path: Pickpocket.config.oauth_token_file)
      end

      def save_authorization(token)
        save_token(token: token, path: Pickpocket.config.authorization_token_file)
      end

      def read_oauth
        read_token(path: Pickpocket.config.oauth_token_file, error_message: 'OAuth Token file does not exist. Make sure you request authorization before proceeding.')
      end

      def read_authorization
        read_token(path: Pickpocket.config.authorization_token_file, error_message: 'Authorization Token file does not exist. Make sure you request authorization before proceeding.')
      end

      private

      def save_token(token:, path:)
        Utility.ensure_home_folder

        file = File.new(path, 'w')
        file.write(token)
        file.close
      end

      def read_token(path:, error_message:)
        file = File.new(path, 'r')
        file.read
      rescue Errno::ENOENT => _
        logger.warn(error_message)
        :no_token
      end
    end
  end
end
