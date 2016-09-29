require 'json'

module Pickpocket
  module Articles
    class Read
      attr_reader :articles_list, :deleted_articles_list

      def initialize
        @articles_list         = FileBuffer.new(file_path: Pickpocket.config.library_file)
      end

      def call
        # Read from articles file buffer
        articles = articles_list.read

        # Pick a random article
        selected_article_id = articles.keys.sample

        # Remove article ID from articles
        articles.delete(selected_article_id)

        # Remove article ID from articles file buffer

        # Add article ID to deleted file buffer
        deleted_articles_list.read()
      end
    end
  end
end
