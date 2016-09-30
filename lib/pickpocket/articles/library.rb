require 'fileutils'
require 'yaml/store'

module Pickpocket
  module Articles
    class Library
      attr_accessor :logger
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
        @api    = API.new
        @logger = Pickpocket::Logger.new
        @store  = yaml_store

        guarantee_inventory
      end

      # Select an unread article, put it to the read collection and return this article
      def pick
        store.transaction do
          unread     = store[:unread]
          random_key = unread.keys.sample

          if (random_article = unread.delete(random_key))
            store[:read].update({ random_key => random_article })
            Launchy.open(random_article['resolved_url'])
          else
            logger.info 'You have read all articles!'
          end
        end
      end

      # Replace unread store with content from pocket
      def renew
        store.transaction do
          new_unread   = @api.retrieve['list']
          already_read = store[:read]

          @api.delete(already_read.keys)
          store[:unread] = new_unread
          store[:read]   = {}
        end
      end
    end
  end
end
