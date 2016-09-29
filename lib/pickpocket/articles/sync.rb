require 'json'

module Pickpocket
  module Articles
    class Sync
      attr_reader :api, :library

      def initialize
        @api            = API.new
        @library = Library.new
      end

      def retrieve
        article_list = api.retrieve['list']
        library.renew(article_list)
      end

      def delete
        # Read deleted article file
        # Call destroy API
        # Truncate deleted article file
      end
    end
  end
end
