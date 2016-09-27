require 'json'

module Pickpocket
  module Articles
    class Sync
      attr_accessor :logger

      def initialize
        @logger = Pickpocket::Logger.new
      end

      def sync
        # TODO: will sync over Pocket's API
      end
    end
  end
end
