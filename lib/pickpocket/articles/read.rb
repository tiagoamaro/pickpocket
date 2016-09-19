require 'json'

module Pickpocket
  module Articles
    class Read
      attr_accessor :logger

      def initialize
        @logger = Pickpocket::Logger.new
      end

      def pick
        # Read from articles file buffer
        # Remove article ID from articles file buffer
        # Add article ID to deleted file buffer
      end
    end
  end
end
