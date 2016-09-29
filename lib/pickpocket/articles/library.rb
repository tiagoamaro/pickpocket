require 'fileutils'
require 'yaml/store'

module Pickpocket
  module Articles
    class Library
      attr_reader :store

      private def yaml_store
        FileUtils.mkdir_p(File.dirname(Pickpocket.config.library_file))
        YAML::Store.new(Pickpocket.config.library_file)
      end

      private def guarantee_inventory
        store.transaction do
          store[:read]   = {} if store[:read].nil?
          store[:unread] = {} if store[:unread].nil?
        end
      end

      def initialize
        @api   = API.new
        @store = yaml_store

        guarantee_inventory
      end

      # Replace unread store with content from pocket
      def renew
        articles = @api.retrieve['list']
        store.transaction do
          store[:unread] = articles
        end
      end

      # Select an unread article, put it to the read collection and return this article
      def pick
        store.transaction do
          unread     = store[:unread]
          random_key = unread.keys.sample

          if (random_article = unread.delete(random_key))
            store[:read].update({ random_key => random_article })

            random_article
          end
        end
      end

      # Clear and return read articles hash
      def clear_read
        store.transaction do
          read         = store[:read]
          store[:read] = {}

          read
        end
      end
    end
  end
end
