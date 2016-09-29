require 'json'

module Pickpocket
  module Articles
    class Sync
      attr_reader :api, :articles_file, :deleted_articles_file

      def initialize
      end

      def retrieve
        article_list = api.retrieve['list']
        articles_file.save(article_list)
      end

      def delete
        # Read deleted article file
        # Call destroy API
        # Truncate deleted article file
      end
    end
  end
end
