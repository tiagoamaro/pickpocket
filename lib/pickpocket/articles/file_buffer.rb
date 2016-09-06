require 'json'

module Pickpocket
  module Articles
    class FileBuffer
      attr_accessor :articles_hash, :logger

      def initialize
        @articles_hash = {}
        @logger        = Pickpocket::Logger.new
      end

      def save
        Utility.ensure_home_folder
        file          = File.new(Pickpocket.config.article_list_file, 'w')
        articles_json = JSON.generate(@articles_hash)
        file.write(articles_json)
        file.close
      end

      def read
        articles_text  = File.read(Pickpocket.config.article_list_file)
        @articles_hash = JSON.parse(articles_text)
      rescue Errno::ENOENT => _
        logger.info('Article file does not exist.')
        {}
      end

      def random_article_id
        @articles_hash.keys.sample
      end

      def delete_article(article_id)
        @articles_hash.delete(article_id)
      end
    end
  end
end
